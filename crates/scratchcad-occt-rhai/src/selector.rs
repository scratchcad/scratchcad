//! A small CadQuery-style selector language for filtering faces, edges and vertices.
//!
//! | selector  | keeps                                                                       |
//! |-----------|-----------------------------------------------------------------------------|
//! | `>Z`      | the shapes whose centers are farthest along +Z (ties within tolerance)      |
//! | `<Z`      | the shapes whose centers are nearest along +Z                               |
//! | `>Z[1]`   | the second-farthest level along +Z (`[-1]` is the nearest level)            |
//! | `\|Z`     | planar faces whose normal / straight edges whose direction is parallel to Z |
//! | `#Z`      | planar faces whose normal / straight edges whose direction is perpendicular |
//! | `+Z`      | planar faces whose normal / straight edges whose direction points along +Z  |
//! | `-Z`      | ... points along -Z                                                         |
//! | `%CIRCLE` | edges or faces with that geometry type (`LINE`, `PLANE`, `CYLINDER`, ...)    |
//!
//! Directions are `X`, `Y`, `Z` or an explicit vector such as `(1, 1, 0)`. Selectors combine
//! with `and`, `or`, `not`, `exc` (and-not) and parentheses, e.g. `"|Z and >X"` or
//! `"not (%LINE or %CIRCLE)"`. `and`/`exc` bind tighter than `or`.

use crate::{
    error::{Error, Result},
    math::parse_direction,
    selection::Selection,
};
use glam::DVec3;

/// A parsed selector expression.
#[derive(Debug, Clone, PartialEq)]
pub enum Selector {
    /// `>D[n]`: level `n` counted from the farthest along `D`.
    Farthest {
        dir: DVec3,
        index: i64,
    },
    /// `<D[n]`: level `n` counted from the nearest along `D`.
    Nearest {
        dir: DVec3,
        index: i64,
    },
    /// `|D`
    Parallel(DVec3),
    /// `#D`
    Perpendicular(DVec3),
    /// `+D` (and `-D`, stored as the negated direction)
    Facing(DVec3),
    /// `%TYPE`
    GeomType(String),
    And(Box<Selector>, Box<Selector>),
    Or(Box<Selector>, Box<Selector>),
    Except(Box<Selector>, Box<Selector>),
    Not(Box<Selector>),
}

impl Selector {
    /// Applies the selector to `selection`, preserving the original order.
    pub fn apply(&self, selection: &Selection) -> Result<Selection> {
        match self {
            Selector::Farthest { dir, index } => selection.nth_farthest(*dir, *index),
            Selector::Nearest { dir, index } => selection.nth_farthest(-*dir, *index),
            Selector::Parallel(dir) => selection.parallel_to(*dir),
            Selector::Perpendicular(dir) => selection.perpendicular_to(*dir),
            Selector::Facing(dir) => selection.facing(*dir),
            Selector::GeomType(name) => selection.of_type(name),
            Selector::And(a, b) => Ok(a.apply(selection)?.intersect(&b.apply(selection)?)),
            Selector::Or(a, b) => {
                let matched = a.apply(selection)?.union(&b.apply(selection)?);
                // Restore the original order.
                Ok(selection.intersect(&matched))
            },
            Selector::Except(a, b) => Ok(a.apply(selection)?.subtract(&b.apply(selection)?)),
            Selector::Not(inner) => Ok(selection.subtract(&inner.apply(selection)?)),
        }
    }
}

/// Parses a selector expression.
pub fn parse(source: &str) -> Result<Selector> {
    let mut parser = Parser { source, chars: source.chars().collect(), pos: 0 };
    let selector = parser.parse_or()?;
    parser.skip_whitespace();
    if parser.pos < parser.chars.len() {
        return Err(parser.error(format!("unexpected {:?}", parser.rest())));
    }
    Ok(selector)
}

struct Parser<'a> {
    source: &'a str,
    chars: Vec<char>,
    pos: usize,
}

impl Parser<'_> {
    fn error(&self, message: impl Into<String>) -> Error {
        Error::Selector { selector: self.source.to_owned(), message: message.into() }
    }

    fn rest(&self) -> String {
        self.chars[self.pos..].iter().collect()
    }

    fn skip_whitespace(&mut self) {
        while self.chars.get(self.pos).is_some_and(|c| c.is_whitespace()) {
            self.pos += 1;
        }
    }

    fn peek(&mut self) -> Option<char> {
        self.skip_whitespace();
        self.chars.get(self.pos).copied()
    }

    fn expect(&mut self, expected: char) -> Result<()> {
        match self.peek() {
            Some(c) if c == expected => {
                self.pos += 1;
                Ok(())
            },
            Some(c) => Err(self.error(format!("expected {expected:?}, found {c:?}"))),
            None => Err(self.error(format!("expected {expected:?}, found end of input"))),
        }
    }

    fn eat_keyword(&mut self, keyword: &str) -> bool {
        self.skip_whitespace();
        let end = self.pos + keyword.len();
        if end > self.chars.len() {
            return false;
        }
        let word: String = self.chars[self.pos..end].iter().collect();
        let boundary = self.chars.get(end).is_none_or(|c| !c.is_alphanumeric() && *c != '_');
        if word.eq_ignore_ascii_case(keyword) && boundary {
            self.pos = end;
            true
        } else {
            false
        }
    }

    fn parse_or(&mut self) -> Result<Selector> {
        let mut left = self.parse_and()?;
        while self.eat_keyword("or") {
            left = Selector::Or(Box::new(left), Box::new(self.parse_and()?));
        }
        Ok(left)
    }

    fn parse_and(&mut self) -> Result<Selector> {
        let mut left = self.parse_not()?;
        loop {
            if self.eat_keyword("and") {
                left = Selector::And(Box::new(left), Box::new(self.parse_not()?));
            } else if self.eat_keyword("exc") {
                left = Selector::Except(Box::new(left), Box::new(self.parse_not()?));
            } else {
                return Ok(left);
            }
        }
    }

    fn parse_not(&mut self) -> Result<Selector> {
        if self.eat_keyword("not") {
            Ok(Selector::Not(Box::new(self.parse_not()?)))
        } else {
            self.parse_atom()
        }
    }

    fn parse_atom(&mut self) -> Result<Selector> {
        let Some(c) = self.peek() else {
            return Err(self.error("expected a selector, found end of input"));
        };
        self.pos += 1;
        match c {
            '(' => {
                let inner = self.parse_or()?;
                self.expect(')')?;
                Ok(inner)
            },
            '>' | '<' => {
                let dir = self.parse_direction()?;
                let index = self.parse_index()?;
                Ok(if c == '>' {
                    Selector::Farthest { dir, index }
                } else {
                    Selector::Nearest { dir, index }
                })
            },
            '|' => Ok(Selector::Parallel(self.parse_direction()?)),
            '#' => Ok(Selector::Perpendicular(self.parse_direction()?)),
            '+' => Ok(Selector::Facing(self.parse_direction()?)),
            '-' => Ok(Selector::Facing(-self.parse_direction()?)),
            '%' => {
                let name = self.parse_identifier();
                if name.is_empty() {
                    return Err(self.error("expected a geometry type after '%'"));
                }
                Ok(Selector::GeomType(name.to_ascii_lowercase()))
            },
            other => {
                self.pos -= 1;
                Err(self.error(format!("unexpected {other:?}, expected one of > < | # + - % (")))
            },
        }
    }

    fn parse_identifier(&mut self) -> String {
        self.skip_whitespace();
        let start = self.pos;
        while self.chars.get(self.pos).is_some_and(|c| c.is_alphanumeric() || *c == '_') {
            self.pos += 1;
        }
        self.chars[start..self.pos].iter().collect()
    }

    fn parse_number(&mut self) -> Result<f64> {
        self.skip_whitespace();
        let start = self.pos;
        while self
            .chars
            .get(self.pos)
            .is_some_and(|c| c.is_ascii_digit() || matches!(c, '.' | '-' | '+' | 'e' | 'E'))
        {
            self.pos += 1;
        }
        let text: String = self.chars[start..self.pos].iter().collect();
        text.parse::<f64>()
            .ok()
            .filter(|n| n.is_finite())
            .ok_or_else(|| self.error(format!("invalid number {text:?}")))
    }

    fn parse_direction(&mut self) -> Result<DVec3> {
        if self.peek() == Some('(') {
            self.pos += 1;
            let x = self.parse_number()?;
            self.expect(',')?;
            let y = self.parse_number()?;
            self.expect(',')?;
            let z = self.parse_number()?;
            self.expect(')')?;
            let dir = DVec3::new(x, y, z);
            if dir.length() < 1e-12 {
                return Err(self.error("direction must not be zero"));
            }
            return Ok(dir);
        }
        let name = self.parse_identifier();
        parse_direction(&name).map_err(|_| {
            self.error(format!("expected a direction (X, Y, Z or (x, y, z)), found {name:?}"))
        })
    }

    fn parse_index(&mut self) -> Result<i64> {
        if self.peek() != Some('[') {
            return Ok(0);
        }
        self.pos += 1;
        let value = self.parse_number()?;
        self.expect(']')?;
        if value.fract() != 0.0 {
            return Err(self.error(format!("index must be an integer, got {value}")));
        }
        Ok(value as i64)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn farthest(dir: DVec3) -> Selector {
        Selector::Farthest { dir, index: 0 }
    }

    #[test]
    fn parses_simple_selectors() {
        assert_eq!(parse(">Z").unwrap(), farthest(DVec3::Z));
        assert_eq!(parse(" <x ").unwrap(), Selector::Nearest { dir: DVec3::X, index: 0 });
        assert_eq!(parse(">Z[2]").unwrap(), Selector::Farthest { dir: DVec3::Z, index: 2 });
        assert_eq!(parse("<Y[-1]").unwrap(), Selector::Nearest { dir: DVec3::Y, index: -1 });
        assert_eq!(parse("|Y").unwrap(), Selector::Parallel(DVec3::Y));
        assert_eq!(parse("#X").unwrap(), Selector::Perpendicular(DVec3::X));
        assert_eq!(parse("+Z").unwrap(), Selector::Facing(DVec3::Z));
        assert_eq!(parse("-Z").unwrap(), Selector::Facing(DVec3::NEG_Z));
        assert_eq!(parse("%Circle").unwrap(), Selector::GeomType("circle".into()));
        assert_eq!(parse(">(1, -1, 0.5e1)").unwrap(), farthest(DVec3::new(1.0, -1.0, 5.0)));
    }

    #[test]
    fn parses_boolean_combinations_with_precedence() {
        let parsed = parse("|Z and >X or not %LINE exc <Y").unwrap();
        let expected = Selector::Or(
            Box::new(Selector::And(
                Box::new(Selector::Parallel(DVec3::Z)),
                Box::new(farthest(DVec3::X)),
            )),
            Box::new(Selector::Except(
                Box::new(Selector::Not(Box::new(Selector::GeomType("line".into())))),
                Box::new(Selector::Nearest { dir: DVec3::Y, index: 0 }),
            )),
        );
        assert_eq!(parsed, expected);

        let grouped = parse("(>Z or <Z) AND %plane").unwrap();
        assert!(matches!(grouped, Selector::And(..)));
        assert_eq!(
            parse("not not >Z").unwrap(),
            Selector::Not(Box::new(Selector::Not(Box::new(farthest(DVec3::Z)))))
        );
    }

    #[test]
    fn keywords_need_word_boundaries() {
        // "order" must not be read as "or" followed by "der".
        let err = parse(">Z order").unwrap_err().to_string();
        assert!(err.contains("unexpected \"order\""), "{err}");
    }

    #[test]
    fn reports_errors() {
        let cases = [
            ("", "found end of input"),
            ("   ", "found end of input"),
            ("Z", "unexpected 'Z'"),
            (">", "expected a direction"),
            (">W", "found \"W\""),
            (">Z[", "invalid number"),
            (">Z[1", "expected ']'"),
            (">Z[1.5]", "must be an integer"),
            ("%", "expected a geometry type"),
            ("(>Z", "expected ')', found end of input"),
            ("(>Z]", "expected ')', found ']'"),
            (">(1, 2)", "expected ','"),
            (">(0, 0, 0)", "must not be zero"),
            (">(a, 0, 0)", "invalid number"),
            (">Z and", "found end of input"),
            (">Z >X", "unexpected \">X\""),
        ];
        for (source, expected) in cases {
            let err = parse(source).unwrap_err();
            assert!(matches!(err, Error::Selector { .. }), "{source}");
            let message = err.to_string();
            assert!(message.contains(expected), "{source:?}: {message}");
        }
    }
}
