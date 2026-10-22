# Rhai API reference

`scratchcad_occt_rhai::engine()` returns a Rhai `Engine` with everything registered;
`scratchcad_occt_rhai::register(&mut engine)` adds it to an engine of your own. `eval_shape(script)`
runs a script and converts its result to a `Shape`.

Scripts model, measure and mesh; they cannot read or write files, and `import` resolves no
modules (`register` replaces Rhai's default resolver, which loads `.rhai` files from disk; set your
own after it to give scripts modules). Files are the host's job,
through the Rust API: read a shape with `Shape::import(path)` or `Shape::from_bytes(format, bytes)`
and hand it to the script in its `Scope` (`scope.push("part", shape)`), and write the shape the
script returns with `shape.export(path, stl_tolerance)` or `shape.to_bytes(format, &options)`. For
scripts you do not trust, also set Rhai's own limits (`set_max_operations` and friends) and run
the script inside `with_cancel` to be able to stop long OpenCASCADE operations; see
[Embedding](#embedding).

## Conventions

* **Handles.** `Shape`, `Selection`, `Sketch` and `Plane` are immutable values that are cheap to
  clone. Every operation returns a new value, so calls chain and variables never change under you.
* **One shape type.** A `Shape` can be a vertex, edge, wire, face, shell, solid or compound;
  operations that need a particular kind check at runtime. Algorithms that return a compound
  holding a single shape return that shape directly.
* **Errors.** Every fallible function raises a runtime error that scripts can catch:
  `try { ... } catch (err) { print(err) }`. The error is its message, tagged with its kind:
  `err.tag` is 1 (OpenCASCADE exception), 2 (operation failed), 3 (wrong shape type), 4 (invalid
  argument), 5 (empty selection), 6 (index out of range), 7 (bad selector) or 9 (cancelled).
  Values a script throws itself have tag 0, and scripts cannot set tags, so a tag always comes from
  a real error. (Kind 8, file and format errors, only comes from the Rust API.)
* **Numbers** may be integers or floats. **Angles** are in degrees.
* **Vectors** are `vec3(x, y, z)` values or arrays (`[x, y, z]`, or `[x, y]` with `z = 0`).
  **Directions** may also be axis names: `"X"`, `"-Z"`.
* **Planes** may be `Plane` values or names (`"XY"`, `"YZ"`, `"ZX"`, `"XZ"`, `"YX"`, `"ZY"`).
* **Picking faces or edges.** Arguments like `fillet`'s edges accept a selector string, a
  `Selection`, a single `Shape` or an array of shapes.

## Constructors

| function | result |
|----------|--------|
| `box(dx, dy, dz)`, `box_centered(dx, dy, dz)`, `box_from_corners(a, b)`, `cube(s)` | solid box |
| `cylinder(r, h)`, `cylinder(base, axis, r, h)` | solid cylinder |
| `sphere(r)`, `sphere(center, r)`, `cone(r1, r2, h)`, `torus(R, r)` | solids |
| `vertex(p)`, `line(a, b)`, `arc(start, mid, end)` | vertex / edges |
| `circle(r)`, `circle(plane, r)`, `circle(center, normal, r)` | closed wire |
| `rect(w, h)`, `rect(plane, w, h)` | closed wire, centered |
| `polygon(points)`, `polygon(plane, points_2d)`, `polyline(points)` | closed / open wire |
| `spline(points)`, `spline(points, closed)`, `bezier(points)` | edges |
| `wire(edges)`, `face(wire)`, `face(outer, holes)`, `compound(shapes)` | assemblies |
| `fuse_all(shapes)`, `loft(sections)`, `loft(sections, solid)`, `ruled_loft(sections)`, `ruled_loft(sections, solid)` | solids (a smooth loft can swing past unevenly spaced sections; a ruled one joins each to the next with straight lines) |
| `sketch()`, `sketch(plane)` | a `Sketch` (see below) |
| `vec3(x, y, z)`, `plane(name)`, `plane(origin, normal)`, `plane(origin, normal, x_dir)` | values |

## Shape methods

| category | methods |
|----------|---------|
| booleans | `fuse`/`union`/`+`, `cut`/`-`, `common`/`intersect`/`&`, `section` |
| transforms | `translate(v)`, `translate(x, y, z)`, `rotate(axis, deg)`, `rotate(origin, axis, deg)`, `rotate_x/y/z(deg)`, `scale(f)`, `scale(center, f)`, `mirror(plane_or_normal)`, `mirror(origin, normal)` |
| features | `extrude(distance)` (along the face normal; see [Sketches](#sketches)), `extrude(vector)`, `revolve(axis, deg)`, `revolve(origin, axis, deg)`, `sweep(path)`, `fillet(r)`, `fillet(r, edges)`, `chamfer(d)`, `chamfer(d, edges)`, `shell(t)`, `shell(t, open_faces)`, `offset(d)` (2D; a face keeps its holes, and an open wire or edge grows into the outline around it, such as a slot around a line), `clean()`, `to_face()` |
| exploration | `faces()`, `edges()`, `vertices()`, `wires()`, `shells()`, `solids()`, `faces(sel)`, `edges(sel)`, `vertices(sel)`, `face(sel)`, `edge(sel)`, `vertex(sel)`, `top_face()`, `bottom_face()`, `children()` |
| measurement | `volume()`, `area()`, `length()`, `center()`, `bounding_box()`, `distance(other)`, `closest_points(other)`, `contains(point)`, `classify(point)` (`"inside"`, `"outside"` or `"on"` the solids), `is_valid()`, `is_closed()`, `shape_type()`, `is_same(other)`, `==` |
| edges, faces, vertices | `point()`, `start_point()`, `end_point()`, `point_at(t)`, `tangent_at(t)`, `radius()`, `geom_type()`, `normal()`, `plane()` (a sketch plane on a planar face), `outer_wire()` |
| meshing | `mesh(tolerance)`, `mesh(tolerance, angle)` (angle in degrees, default 28.6); a `Mesh` has `vertices`, `normals`, `indices`, `vertex_count`, `triangle_count`, `area()` and `welded()` (shared vertices merged) |

A fillet or chamfer whose result OpenCASCADE's checker rejects fails at its own line, suggesting
a smaller size or fewer edges, rather than returning an invalid solid.
A sweep that comes out partly inside out fails as well: OpenCASCADE returns such solids, which its
checker passes, along paths that cross themselves, or with a profile that isn't square to the
path. Sweep along a smooth path (`wire([spline(points)])`) with the profile on its first point,
square to it.

## Selections and selectors

`faces()`, `edges()` and friends return a `Selection`: an ordered list of shapes that supports
`len()`, indexing (`sel[0]`, `sel[-1]`), `first()`, `last()`, `single()`, `for x in sel { }`,
`filter(|f| ...)`, `sort_by(|f| key)`, `farthest(dir)`, `nearest(dir)`, `top()`, `bottom()`,
`left()`, `right()`, `front()`, `back()`, `parallel_to(dir)`, `perpendicular_to(dir)`,
`facing(dir)`, `of_type(name)`, `union`/`+`, `intersect`, `subtract`/`-`, `to_array()` and
`compound()`.

`select(selector)` (and every `sel` argument above) takes a CadQuery-style selector string:

| selector | keeps |
|----------|-------|
| `>Z` / `<Z` | shapes whose centers are farthest / nearest along +Z (ties within 1e-4 are kept) |
| `>Z[1]` | the second level along +Z; `[-1]` is the last level |
| `\|Z` | planar faces whose normal, or straight edges whose direction, is parallel to Z |
| `#Z` | ... perpendicular to Z |
| `+Z` / `-Z` | ... pointing along +Z / -Z |
| `%CIRCLE` | edges or faces of a geometry type (`LINE`, `CIRCLE`, `BSPLINE`, `PLANE`, `CYLINDER`, `SPHERE`, ...) |

Directions are `X`, `Y`, `Z` or vectors like `(1, 1, 0)`. Combine selectors with `and`, `or`,
`not`, `exc` and parentheses: `box.edges("|Z and >X")`, `faces("not (%PLANE or %CYLINDER)")`.

## Sketches

A `Sketch` draws lines and arcs in a plane's 2D coordinates and turns them into wires or faces:

```rhai
let profile = sketch("XZ")
    .move_to(0, 0)
    .hline(10)
    .vline(2)
    .arc_to(5, 6, 0, 2)  // through (5, 6), ending at (0, 2)
    .close();             // closed wire; .face() for a face, .wire() for an open wire
profile.translate([20, 0, 0]).revolve("Z", 360)
```

Pen moves: `move_to(x, y)` (before drawing), `line_to(x, y)`, `line(dx, dy)`, `hline(dx)`,
`vline(dy)`, `hline_to(x)`, `vline_to(y)`, `polar_line(length, deg)`, `arc_to(mx, my, x, y)`.

`extrude(distance)` goes along a face's normal. Outlines drawn on a plane (closed sketches,
`rect`, `circle`, `polygon(plane, points)`, and `polygon(points)` whose points all lie at one
height) run counter-clockwise about the plane's normal whichever way round they were drawn, so
their faces extrude to the plane's positive side: +Z for `"XY"`, -Y for `"XZ"`. Other outlines
face the way their winding points (counter-clockwise seen from the side they face); give
`extrude([0, 0, h])` a vector to be sure of the direction.

Use a face as a sketch plane with `face.plane()`:

```rhai
let block = box(30, 20, 10);
let hole = circle(block.top_face().plane(), 4).extrude(-10);
block - hole
```

More examples live in [`crates/scratchcad-occt-rhai/examples`](../examples);
the test suite runs every one of them.

## Embedding

The Rust API behind the scripts adds a few things for programs that run scripts on behalf of
others, such as servers:

* **In memory.** `shape.to_bytes(format, &mesh_options)` writes STEP, IGES, BREP or binary STL,
  and `Shape::from_bytes(format, bytes)` reads STEP or BREP, without touching the filesystem.
  OpenCASCADE 7.8 reads IGES only from files: use `Shape::read_iges(path)` for those. A
  conversion cancelled part way fails with `Error::Cancelled` rather than returning part of the
  model. `Format::from_extension` and `Format::media_type` help with file names and HTTP.
* **Cancellation.** Booleans, shells, meshing (between faces) and STEP/IGES/BREP conversion
  poll the `CancelToken` of the enclosing `with_cancel(&token, || ...)` and fail with
  `Error::Cancelled` once it is cancelled from another thread. OpenCASCADE 7.8 ignores the
  progress range of fillets, chamfers and lofts, so those (and sweeps and `clean`) run to the end
  once started, but fail with `Error::Cancelled` instead of starting after a cancel.
  `error_kind(&err)` recovers the kind of an error raised inside a script.
* **Meshing.** `shape.mesh_with(&MeshOptions::new(tolerance).angular_tolerance(10.0))` also sets
  relative tolerances and parallel meshing. Meshing never modifies the shape (it works on a copy),
  `mesh.face_triangles` tells which triangles belong to which face, and `mesh.welded()` merges the
  vertices faces share, making the mesh of a solid watertight. When OpenCASCADE can't mesh a face,
  which it can't where two surfaces coincide, the error names the face's type and where it lies.
* **Measuring.** `volume()`, `area()` and `center()` are exact for analytic geometry (lines,
  conics, planes, cylinders, cones, spheres, tori). A shape with B-spline curves or surfaces
  (lofts, sweeps, splines) is measured on a copy split into Bézier patches, to about 1e-7 of
  the result; integrating its B-spline faces directly is off by percent. That split is the
  slow part, so `shape.mass_properties()` returns all three from one split. The split works on a
  deep copy, cutting closed faces open first, so measuring never changes the shape or the shapes it
  shares geometry with. If it fails, the shape is integrated directly, and `MassProperties::exact`
  is `false`.
* **Notes.** A boolean can succeed and still return an invalid shape (where faces only touch or
  nearly coincide), which later operations may mangle or drop without an error, leaving a final
  shape that looks fine. Booleans that raise OpenCASCADE warnings check their result, and record an
  invalid one as a note, placed at its line in the script when called from one. Take them after a
  script with `take_notes()`, to show them to whoever wrote it. Notes are kept per thread.
* **Console output.** OpenCASCADE prints to stdout. `set_message_handler(level, |level, text| ..)`
  receives its messages instead; `set_occt_messages(false)` sends only failures, to stderr.
* **Threads.** `Shape` is neither `Send` nor `Sync`: OpenCASCADE shares sub-shapes between shapes
  and many of its algorithms update their inputs' sub-shapes in place. `shape.detach()` makes a
  deep copy that can move to another thread, where `attach()` turns it back into a `Shape`. Do not
  enable Rhai's `sync` feature, which requires `Send + Sync` types.
