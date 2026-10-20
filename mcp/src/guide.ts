// The server's MCP instructions: how to write scripts and use the tools.
// The scripting API is scratchcad-occt-rhai's; see crates/scratchcad-occt-rhai/docs/rhai-api.md.

/** The guide's example scripts; the integration tests run them. */
export const EXAMPLES = {
  plate: `let plate = box_centered(80, 50, 6).fillet(5, "|Z");
for x in [-1, 1] {
    for y in [-1, 1] {
        plate -= cylinder([x * 32, y * 17, -5], "Z", 2.5, 10);
    }
}
let boss = cylinder([0, 0, 3], "Z", 10, 12);
(plate + boss).chamfer(0.8, ">Z")`,
  vase: `let profile = sketch("XZ").move_to(0, 0).hline(20).vline(4).arc_to(28, 30, 16, 60).hline_to(0).close();
profile.to_face().revolve("Z", 360).shell(-1.5, ">Z")`,
};

const indent = (script: string) => script.replace(/^/gm, "  ");

export const GUIDE = `scratchcad models solid parts with OpenCASCADE, a CAD kernel, from scripts written in Rhai. Shapes are exact B-rep solids: faces, edges and vertices, not meshes. Z is up: parts usually stand on the XY plane. Units are millimetres.

A script produces its shape in one of two ways:
- its last expression is the shape, or
- it calls draw(shape) exactly once.
A selection, a sketch or an array of shapes also works; they become one compound.

Conventions:
- Numbers may be integers or floats, and angles are in degrees. Maths: x ** y, sqrt(x), x.abs(), min(a, b), max(a, b), x.sin() and the other trig functions in radians, PI(); there is no pow() or clamp().
- Vectors are [x, y, z] arrays (or [x, y] with z = 0) or vec3(x, y, z). Directions may also be axis names: "X", "-Z".
- Planes are "XY", "YZ", "XZ" (and the reversed "YX", "ZY", "ZX"), or plane(origin, normal), or face.plane() for a planar face.
- Shapes never change: every operation returns a new shape, so chain calls and reassign: \`part = part.fillet(1, "|Z");\`.
- Rhai reserves some words that make natural names, and rejects them as variable names: module, thread, case, match, default, new, use, with, static, shared, sync, spawn, go, goto, var, void, null, nil, package, super, is, import, export, private, protected, public, async, await, yield, as, fn, this, try, catch, throw, loop, switch, do, until. Use gear_module, threads, housing and so on.

Solids:
- box(dx, dy, dz) has a corner at the origin; box_centered(dx, dy, dz) is centered on it; box_from_corners(a, b); cube(s)
- cylinder(r, h) stands on the XY plane around Z; cylinder(base, axis, r, h), e.g. cylinder([0, 0, -1], "Z", 3, 12)
- sphere(r), sphere(center, r), cone(r1, r2, h), torus(R, r)
- loft(sections) or loft(sections, true) for a solid through wires; fuse_all(shapes)

Curves, wires and faces (to extrude, revolve, sweep or loft):
- line(a, b), arc(start, mid, end), spline(points), spline(points, closed), bezier(points)
- circle(r), circle(plane, r), circle(center, normal, r); rect(w, h) and rect(plane, w, h) are centered
- polygon(points) is closed, polyline(points) open; polygon(plane, points_2d)
- wire(edges), face(wire), face(outer, holes), compound(shapes), vertex(p)
- sketch() or sketch(plane) draws in the plane's 2D coordinates: .move_to(x, y) first, then .line_to(x, y), .line(dx, dy), .hline(dx), .vline(dy), .hline_to(x), .vline_to(y), .polar_line(length, deg), .arc_to(mid_x, mid_y, x, y). Finish with .close() (closed wire), .face() or .wire() (open).

Operations (methods on shapes):
- Booleans: a + b (fuse), a - b (cut), a & b (common); also fuse, cut, common, section. part -= hole works.
- Transforms: translate([x, y, z]), rotate(axis, deg), rotate(origin, axis, deg), rotate_x/y/z(deg), scale(f), scale(center, f), mirror(plane or normal), mirror(origin, normal).
- Features: extrude(distance) along a face's or closed wire's normal, extrude([x, y, z]), revolve(axis, deg), revolve(origin, axis, deg), sweep(path), fillet(r), fillet(r, edges), chamfer(d), chamfer(d, edges), shell(thickness, open_faces) (negative thickness hollows inward), offset(d) for 2D wires, clean() to merge faces after booleans, to_face().
- Exploring: faces(), edges(), vertices(), wires(), solids() and faces(selector), edges(selector), face(selector), top_face(), bottom_face().
- Measuring: volume(), area(), length(), center(), bounding_box(), distance(other), closest_points(other), contains(point), classify(point) ("inside", "outside" or "on"), is_valid(), shape_type(), radius() and geom_type() of an edge or face, normal() of a face.

Selectors pick faces or edges by a CadQuery-style string, wherever a method takes edges or faces: ">Z" farthest along +Z (the top), "<Z" nearest (the bottom), ">Z[1]" the next level down, "|Z" parallel to Z (vertical edges, or faces whose normal is along Z), "#Z" perpendicular, "+Z"/"-Z" facing that way, "%CIRCLE" or "%PLANE" by geometry type. Combine them with and, or, not, exc and parentheses: box(10, 10, 5).fillet(1, "|Z and >X"). Selections also have len(), indexing, first(), filter(|f| ...), sort_by(|f| ...), top(), bottom() and friends, and can be passed instead of a selector.

A helix (for a spring or a coil) is a spline through points on it: sweep a profile placed square to the helix at its start along spline(points), with 12 or more points per turn. Threads are better lofted than swept: loft(sections, true) through 16 or more copies of the thread's cross-section per turn, each turned about the axis and raised by the pitch over that count, with the ridge's root sunk a little into the core so the two fuse cleanly.

Errors are catchable: try { ... } catch (err) { print(err) }. Fillets and chamfers fail when the radius is too large for the faces around an edge; do them last, on the finished body, with radii smaller than the walls they touch. Booleans need the tool to overlap the part: make cutting tools a little longer than the part is thick, rather than flush with its faces. Prefer one fuse_all(array) over many + in a loop.

Example: a plate with four holes, rounded corners and a boss:
${indent(EXAMPLES.plate)}

A revolved profile, hollowed through its top:
${indent(EXAMPLES.vase)}

Workflow: validate_script first: it catches errors cheaply and reports the shape's type, validity, bounding box, volume and center, so you can check dimensions exactly (print() values from the script for anything else, and use contains(point) or classify(point) to probe). Then render_3d to see the part, from several angles, and render_2d for the cross-section at z = 0 (translate the shape in the script to slice elsewhere). Renders fit the part automatically and say which view they used. Watch for warnings: an invalid shape, or no solids (a face or wire where you meant a solid). Save the script with save_script once it looks right.

The saved .rhai script is the deliverable: the user opens it in the scratchcad editor, which previews it, lets them change it, and exports STEP, IGES, BREP, STL, OBJ and 3MF files. save_script returns the editor link for the script (editor_url) when the editor is running; give it to the user. Only call export when the user asks for a file; its path's extension picks the format.

Parameters: most users never read the script. They change the part with sliders that the editor builds from top-level \`let\` lines, so design those lines for them:
- Write one line per dimension a user might reasonably change, at the top of the script, in the form \`let name = value; // [min, max] Label (unit)\`. Typically 3 to 12 of them, the most important first.
- The label is what the user reads next to the slider. Write it in plain words, as the user would say it, with the unit in brackets: "Thread length (mm)", "Number of blades", "Twist angle (degrees)". Avoid internal jargon and abbreviations.
- The name is a snake_case variable the rest of the script uses: \`thread_length\`, not \`tl\` or \`p1\`.
- Always give [min, max]. Pick a range over which the part stays valid and sensible, and include the current value. Without a range the slider has to guess one.
- Compute everything that follows from the parameters (clearances, derived radii, positions) in the script body, not as more parameters, so the part stays consistent whichever slider moves. If one parameter limits another (a fillet radius and a wall thickness, a hole and the plate around it), choose ranges that can't break the part, or clamp in the body with min/max.
- Counts are integers (\`let holes = 4;\`), as loops like \`for i in 0..holes\` need one; lengths and angles are floats with a decimal point (\`let width = 20.0;\`), as integer division truncates (\`7 / 2\` is 3). The slider keeps each literal's kind.
- Group related parameters under a section line, \`// # Head\`, which the editor shows as a heading.
For example:
  // # Thread
  let thread_length = 26.0; // [10, 60] Thread length (mm)
  let thread_pitch = 1.5; // [0.5, 3.0] Thread pitch (mm)
  // # Head
  let head_height = 6.4; // [3.0, 12.0] Head height (mm)
  let head_width = 16.0; // [10.0, 30.0] Head width across flats (mm)
save_script lists the sliders it found and notes any that are unclear; fix those and save again.

The user may edit a saved script in the editor at any time. Before changing a script you saved earlier, read_script it again and build on what is there.`;
