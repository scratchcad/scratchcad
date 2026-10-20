// Tomato truss support: curved cradle that stops heavy trusses kinking, 60 mm arc of 30 mm radius in a 6 mm wide channel, 3 mm thick, with a 4 mm stem clip for the main vine and a 12 mm snap ring
// # Cradle
let cradle_r = 30.0; // [20.0, 45.0] Cradle radius (mm)
let sweep_angle = 110.0; // [70.0, 150.0] Cradle sweep (degrees)
let width = 6.0; // [4.0, 10.0] Cradle width (mm)
let thickness = 3.0; // [2.0, 4.0] Thickness (mm)
// # Stem clip
let stem = 12.0; // [8.0, 18.0] Main stem diameter (mm)
let rc = cradle_r;
let half = sweep_angle / 2.0;
let arc_ring = cylinder([0, 0, 0], "Z", rc + thickness, width) - cylinder([0, 0, -1.0], "Z", rc, width + 2.0);
let keep = polygon([[0.0, 0.0], [(rc * 2.0) * ((-90.0 - half) * PI() / 180.0).cos(), (rc * 2.0) * ((-90.0 - half) * PI() / 180.0).sin()], [0.0, -rc * 2.0], [(rc * 2.0) * ((-90.0 + half) * PI() / 180.0).cos(), (rc * 2.0) * ((-90.0 + half) * PI() / 180.0).sin()]]).extrude([0, 0, width + 2.0]).translate([0, 0, -1.0]);
let cradle = arc_ring & keep;
let ends = [];
for s in [-1.0, 1.0] {
    let a = (-90.0 + s * half) * PI() / 180.0;
    ends.push(cylinder([(rc + thickness / 2.0) * a.cos(), (rc + thickness / 2.0) * a.sin(), 0], "Z", thickness / 2.0 + 0.3, width));
}
let post = box_from_corners([-thickness / 2.0, -rc - 0.5, 0], [thickness / 2.0, 0.0, width]);
let ring_c = stem / 2.0 + thickness;
let clip = cylinder([0, ring_c - 0.5, 0], "Z", stem / 2.0 + thickness, width) - cylinder([0, ring_c - 0.5, -1.0], "Z", stem / 2.0, width + 2.0) - box_from_corners([-stem * 0.3, ring_c, -1.0], [stem * 0.3, ring_c * 3.0, width + 1.0]);
cradle + fuse_all(ends) + post + clip
