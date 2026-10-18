// The classic OpenCASCADE bottle, built from a sketch, a mirror and a revolve-free extrusion.
let width = 50.0;
let thickness = 30.0;
let height = 70.0;

// Half of the profile: a line, an arc and a line.
let half = sketch()
    .move_to(-width / 2, 0)
    .line_to(-width / 2, -thickness / 4)
    .arc_to(0, -thickness / 2, width / 2, -thickness / 4)
    .line_to(width / 2, 0)
    .wire();

let profile = wire([half, half.mirror("Y")]);
let body = profile.extrude(height).fillet(thickness / 12);

// The neck.
let neck = cylinder([0, 0, height], "Z", thickness / 4, height / 10);
let bottle = body + neck;

// Hollow it out through the top of the neck.
bottle.shell(-thickness / 50, bottle.faces(">Z"))
