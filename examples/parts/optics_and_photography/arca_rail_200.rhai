// Arca-Swiss compatible nodal / macro rail: 200 x 38 mm, 12 mm tall, 45 deg dovetails, 6.5 mm through slot 160 mm long, 1/4-20 and 3/8-16 tapped holes at each end, safety-stop screw holes
let length = 200.0; // [80.0, 400.0] Rail length (mm)
let width = 38.0; // [36.0, 40.0] Dovetail width (mm)
let height = 12.0; // [10.2, 16.0] Rail height (mm)
let dovetail_height = 4.5; // [3.0, 5.4] Dovetail height (mm)
let end_margin = 20.0; // [18.3, 40.0] Solid length at each end (mm)
let w = width / 2.0;
let d = dovetail_height;
// dovetails on both the bottom (for a clamp) and the top (for a plate clamp to ride on)
let profile = polygon("YZ", [[-w + d, 0], [w - d, 0], [w, d], [w, height - d], [w - d, height], [-w + d, height], [-w, height - d], [-w, d]]);
let rail = profile.to_face().extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
rail = rail.chamfer(0.5, "|Y");
let sl = length - 2.0 * end_margin;
let cut = box_centered(sl, 6.5, height + 2.0).translate([0, 0, height / 2.0]) + cylinder([-sl / 2.0, 0, -1], "Z", 3.25, height + 2.0) + cylinder([sl / 2.0, 0, -1], "Z", 3.25, height + 2.0);
rail = rail - cut;
// tapped mounting holes in the ends (tap drill sizes) and stop-screw holes along the top edges
let holes = [];
for s in [-1.0, 1.0] {
    holes.push(cylinder([s * (length / 2.0 - end_margin / 2.0 - 3.0), 0, -1], "Z", 2.55, height + 2.0));
    holes.push(cylinder([s * (length / 2.0 - 5.0), 0, -1], "Z", 4.2, height + 2.0));
    holes.push(cylinder([s * (length / 2.0 - 5.0), w - d - 1.5, height - 6.0], "Z", 1.25, 7.0));
}
rail - compound(holes)
