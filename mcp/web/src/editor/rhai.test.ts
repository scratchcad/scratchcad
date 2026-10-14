import { describe, expect, it } from "vitest";
import { completions, parser, tokenize } from "./rhai";

const styles = (line: string) => tokenize(line).filter(([, style]) => style !== null);

describe("rhai tokenizer", () => {
  it("highlights a parameter line", () => {
    expect(styles("let r = 2.5; // [1, 5] Radius")).toEqual([
      ["let", "keyword"],
      ["r", "variable"],
      ["=", "operator"],
      ["2.5", "number"],
      ["// [1, 5] Radius", "comment"],
    ]);
  });

  it("knows constructors, methods, atoms, maps and strings", () => {
    expect(styles('draw(cube(s).fillet(1, ">Z")); let m = #{ on: true }; print("a\\"b");')).toEqual(
      [
        ["draw", "builtin"],
        ["(", "bracket"],
        ["cube", "builtin"],
        ["(", "bracket"],
        ["s", "variable"],
        [")", "bracket"],
        ["fillet", "builtin"],
        ["(", "bracket"],
        ["1", "number"],
        ['">Z"', "string"],
        [")", "bracket"],
        [")", "bracket"],
        ["let", "keyword"],
        ["m", "variable"],
        ["=", "operator"],
        ["#{", "bracket"],
        ["on", "variable"],
        ["true", "atom"],
        ["}", "bracket"],
        ["print", "builtin"],
        ["(", "bracket"],
        ['"a\\"b"', "string"],
        [")", "bracket"],
      ],
    );
  });

  it("handles nested block comments, chars and backtick strings", () => {
    expect(styles("/* a /* b */ c */ 'x' `t` 1e3")).toEqual([
      ["/* a /* b */ c */", "comment"],
      ["'x'", "string"],
      ["`t`", "string"],
      ["1e3", "number"],
    ]);
    expect(styles("/* open")).toEqual([["/* open", "comment"]]);
  });

  it("skips characters it does not know", () => {
    expect(tokenize("@")).toEqual([["@", null]]);
  });
});

describe("completions", () => {
  it("offers constructors, methods and keywords", () => {
    const labels = completions.map((c) => c.label);
    for (const name of ["box", "cylinder", "sketch", "draw", "fillet", "faces", "arc_to", "let"]) {
      expect(labels).toContain(name);
    }
    const types = Object.fromEntries(completions.map((c) => [c.label, c.type]));
    expect([types.box, types.fillet, types.let]).toEqual(["function", "method", "keyword"]);
  });
});

describe("parser state", () => {
  it("copies block comment depth", () => {
    const state = parser.startState!(4);
    state.blockComment = 2;
    const copy = parser.copyState!(state);
    expect(copy).toEqual({ blockComment: 2 });
    expect(copy).not.toBe(state);
  });
});
