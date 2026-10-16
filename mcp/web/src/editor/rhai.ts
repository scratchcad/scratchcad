// Rhai syntax highlighting and completions for the modelling functions that
// scratchcad-occt-rhai registers (see its docs/rhai-api.md).
import { type Completion, snippetCompletion } from "@codemirror/autocomplete";
import {
  HighlightStyle,
  StreamLanguage,
  type StreamParser,
  StringStream,
} from "@codemirror/language";
import { tags } from "@lezer/highlight";

const KEYWORDS = new Set([
  "let", "const", "if", "else", "switch", "while", "loop", "for", "in", "do", "until",
  "break", "continue", "return", "throw", "try", "catch", "fn", "private", "this",
]); // prettier-ignore
const ATOMS = new Set(["true", "false"]);

/** Functions that make shapes and values: [name, snippet, what it makes]. */
const CONSTRUCTORS: [name: string, template: string, detail: string][] = [
  ["box", "box(${10}, ${10}, ${10})", "solid, corner at the origin"],
  ["box_centered", "box_centered(${10}, ${10}, ${10})", "solid, centered"],
  ["box_from_corners", "box_from_corners([${0}, ${0}, ${0}], [${10}, ${10}, ${10}])", "solid"],
  ["cube", "cube(${10})", "solid"],
  ["cylinder", "cylinder(${5}, ${10})", "solid, on the XY plane"],
  ["cylinder", 'cylinder([${0}, ${0}, ${0}], "${Z}", ${5}, ${10})', "solid: base, axis, r, h"],
  ["sphere", "sphere(${5})", "solid"],
  ["sphere", "sphere([${0}, ${0}, ${0}], ${5})", "solid: center, r"],
  ["cone", "cone(${5}, ${2}, ${10})", "solid: r1, r2, h"],
  ["torus", "torus(${10}, ${2})", "solid: R, r"],
  ["vertex", "vertex([${0}, ${0}, ${0}])", "point"],
  ["line", "line([${0}, ${0}, ${0}], [${10}, ${0}, ${0}])", "edge"],
  ["arc", "arc(${start}, ${mid}, ${end})", "edge through three points"],
  ["circle", "circle(${5})", "closed wire"],
  ["circle", 'circle("${XY}", ${5})', "closed wire in a plane"],
  ["rect", "rect(${20}, ${10})", "closed wire, centered"],
  ["polygon", "polygon([[${0}, ${0}], [${10}, ${0}], [${5}, ${8}]])", "closed wire"],
  ["polyline", "polyline([${points}])", "open wire"],
  ["spline", "spline([${points}])", "edge through points"],
  ["bezier", "bezier([${points}])", "edge"],
  ["wire", "wire([${edges}])", "wire from edges"],
  ["face", "face(${wire})", "face from a closed wire"],
  ["compound", "compound([${shapes}])", "group of shapes"],
  ["fuse_all", "fuse_all([${shapes}])", "union of many shapes"],
  ["loft", "loft([${sections}], true)", "solid through wires"],
  ["sketch", 'sketch("${XY}")', "2D drawing in a plane"],
  ["vec3", "vec3(${0}, ${0}, ${0})", "vector"],
  ["plane", 'plane("${XY}")', "sketch plane"],
  ["selection", "selection([${shapes}])", "list of shapes"],
  ["draw", "draw(${shape})", "output the shape"],
];

/** Methods, after a dot: [name, snippet or null for a plain call, what it does]. */
const METHODS: [name: string, template: string | null, detail: string][] = [
  ["translate", "translate([${0}, ${0}, ${0}])", "move"],
  ["rotate", 'rotate("${Z}", ${90})', "about an axis, degrees"],
  ["rotate_x", "rotate_x(${90})", "degrees"],
  ["rotate_y", "rotate_y(${90})", "degrees"],
  ["rotate_z", "rotate_z(${90})", "degrees"],
  ["scale", "scale(${2})", "uniformly"],
  ["mirror", 'mirror("${YZ}")', "across a plane"],
  ["extrude", "extrude(${10})", "along the normal"],
  ["revolve", 'revolve("${Z}", ${360})', "about an axis, degrees"],
  ["sweep", "sweep(${path})", "along a path"],
  ["fillet", 'fillet(${1}, "${|Z}")', "round edges"],
  ["chamfer", 'chamfer(${0.5}, "${>Z}")', "bevel edges"],
  ["shell", 'shell(${-1}, "${>Z}")', "hollow, opening faces"],
  ["offset", "offset(${1})", "grow a 2D wire"],
  ["fuse", "fuse(${other})", "boolean union (+)"],
  ["cut", "cut(${other})", "boolean difference (-)"],
  ["common", "common(${other})", "boolean intersection (&)"],
  ["section", "section(${other})", "intersection curves"],
  ["clean", null, "merge faces after booleans"],
  ["to_face", null, "face from a closed wire"],
  ["faces", 'faces("${>Z}")', "select faces"],
  ["edges", 'edges("${|Z}")', "select edges"],
  ["vertices", null, "select vertices"],
  ["wires", null, "select wires"],
  ["solids", null, "select solids"],
  ["top_face", null, "highest face"],
  ["bottom_face", null, "lowest face"],
  ["volume", null, "measure"],
  ["area", null, "measure"],
  ["length", null, "measure"],
  ["center", null, "center of mass"],
  ["bounding_box", null, "measure"],
  ["distance", "distance(${other})", "measure"],
  ["contains", "contains([${0}, ${0}, ${0}])", "point inside?"],
  ["classify", "classify([${0}, ${0}, ${0}])", '"inside", "outside" or "on"'],
  ["is_valid", null, "check"],
  ["shape_type", null, "solid, face, ..."],
  ["geom_type", null, "line, circle, plane, ..."],
  ["radius", null, "of a circular edge"],
  ["normal", null, "of a face"],
  ["plane", null, "sketch plane on a face"],
  ["point_at", "point_at(${0.5})", "along an edge, 0 to 1"],
  ["move_to", "move_to(${0}, ${0})", "sketch: start"],
  ["line_to", "line_to(${10}, ${0})", "sketch"],
  ["hline", "hline(${10})", "sketch"],
  ["vline", "vline(${10})", "sketch"],
  ["hline_to", "hline_to(${0})", "sketch"],
  ["vline_to", "vline_to(${0})", "sketch"],
  ["polar_line", "polar_line(${10}, ${45})", "sketch: length, degrees"],
  ["arc_to", "arc_to(${5}, ${5}, ${10}, ${0})", "sketch: through, to"],
  ["close", null, "sketch: closed wire"],
  ["filter", "filter(|${f}| ${f.area() > 1})", "keep matching shapes"],
  ["sort_by", "sort_by(|${f}| ${f.center().z})", "order shapes"],
  ["first", null, "of a selection"],
  ["last", null, "of a selection"],
  ["len", null, "of a selection"],
];

const BUILTINS = new Set([
  ...CONSTRUCTORS.map(([name]) => name),
  ...METHODS.map(([name]) => name),
  "print",
  "debug",
]);

export const completions: Completion[] = [
  ...CONSTRUCTORS.map(([name, template, detail]) =>
    snippetCompletion(template, { label: name, detail, type: "function" }),
  ),
  ...METHODS.map(([name, template, detail]) =>
    snippetCompletion(template ?? `${name}()`, { label: name, detail, type: "method" }),
  ),
  ...[...KEYWORDS].map((name) => ({ label: name, type: "keyword" })),
];

interface State {
  blockComment: number; // nesting depth; Rhai block comments nest
}

function token(stream: StringStream, state: State): string | null {
  if (state.blockComment > 0) {
    while (!stream.eol()) {
      if (stream.match("/*")) state.blockComment++;
      else if (stream.match("*/")) {
        if (--state.blockComment === 0) break;
      } else stream.next();
    }
    return "comment";
  }
  if (stream.eatSpace()) return null;
  if (stream.match("//")) {
    stream.skipToEnd();
    return "comment";
  }
  if (stream.match("/*")) {
    state.blockComment = 1;
    return token(stream, state);
  }
  if (stream.match(/^"(?:[^"\\]|\\.)*"?/) || stream.match(/^`[^`]*`?/)) return "string";
  if (stream.match(/^'(?:[^'\\]|\\.)'/)) return "string";
  if (stream.match(/^\d[\d_]*(?:\.\d[\d_]*)?(?:[eE][+-]?\d+)?/)) return "number";
  if (stream.match("#{")) return "bracket";
  const word = stream.match(/^[A-Za-z_]\w*/) as RegExpMatchArray | null;
  if (word) {
    const name = word[0];
    if (KEYWORDS.has(name)) return "keyword";
    if (ATOMS.has(name)) return "atom";
    if (BUILTINS.has(name)) return "builtin";
    return "variable";
  }
  if (stream.match(/^[-+*/%=<>!&|^]+/)) return "operator";
  if (stream.match(/^[()[\]{}]/)) return "bracket";
  stream.next();
  return null;
}

export const parser: StreamParser<State> = {
  name: "rhai",
  startState: () => ({ blockComment: 0 }),
  copyState: (state) => ({ ...state }),
  token,
  languageData: {
    commentTokens: { line: "//", block: { open: "/*", close: "*/" } },
    closeBrackets: { brackets: ["(", "[", "{", '"'] },
    autocomplete: completions,
  },
};

export const rhai = StreamLanguage.define(parser);

// Colours come from CSS variables (see index.css), so they follow the theme.
export const highlightStyle = HighlightStyle.define([
  { tag: tags.keyword, color: "var(--code-keyword)" },
  { tag: tags.comment, color: "var(--code-comment)", fontStyle: "italic" },
  { tag: tags.string, color: "var(--code-string)" },
  { tag: tags.number, color: "var(--code-number)" },
  { tag: tags.atom, color: "var(--code-atom)" },
  { tag: tags.standard(tags.variableName), color: "var(--code-function)" },
  { tag: tags.operator, color: "var(--code-operator)" },
]);

/** For tests: the token names for each piece of a line. */
export function tokenize(line: string): [string, string | null][] {
  const stream = new StringStream(line, 4, 2);
  const state = parser.startState!(4);
  const out: [string, string | null][] = [];
  while (!stream.eol()) {
    stream.start = stream.pos;
    const style = token(stream, state);
    out.push([stream.current(), style]);
  }
  return out;
}
