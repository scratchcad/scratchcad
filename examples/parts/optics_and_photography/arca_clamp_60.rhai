// Arca-Swiss screw-knob clamp: 60 x 56 mm body 10 mm thick, fixed and sliding 45 deg jaws for a 38 mm dovetail, 20 mm knurled knob on an M8 screw, 3/8-16 tapped base hole
let length = 60.0; // [40.0, 100.0] Clamp length along the plate (mm)
let width = 56.0; // [50.0, 70.0] Clamp width (mm)
let base_height = 10.0; // [8.0, 16.0] Base thickness (mm)
let knob_diameter = 20.0; // [14.0, 30.0] Knob diameter (mm)
let opening = 1.0; // [0.0, 4.0] Jaw opening beyond the plate (mm)
let w = width / 2.0;
let zb = base_height;
let lx = length / 2.0;
// base with a slot for the sliding jaw's tongue and a bore for the screw
let base = box_from_corners([-lx, -w, 0], [lx, w, zb]);
let fixed_jaw = polygon("YZ", [[-w, zb - 0.1], [-19.4, zb - 0.1], [-15.4, zb + 3.9], [-15.4, zb + 5.0], [-w, zb + 5.0]]).to_face().extrude([length, 0, 0]).translate([-lx, 0, 0]);
base = base.chamfer(0.6, "|X and <Z") + fixed_jaw;
const zs = 4.5;
base -= box_from_corners([-8.5, 15.0, 1.5], [8.5, w + 1.0, zb + 0.1]);
base -= cylinder([0, -w - 1.0, zs], "Y", 4.3, width);
base -= cylinder([0, 0, -1.0], "Z", 4.2, 8.0);
// sliding jaw with a tongue that rides in the slot
let jaw = polygon("YZ", [[w, zb], [19.4, zb], [15.4, zb + 4.0], [15.4, zb + 5.0], [w, zb + 5.0]]).to_face().extrude([length, 0, 0]).translate([-lx, 0, 0]);
let tongue = box_from_corners([-8.0, 20.0, 2.0], [8.0, w - 1.0, zb + 0.5]);
jaw = (jaw + tongue).translate([0, opening, 0]) - cylinder([0, 15.0, zs], "Y", 4.0, w);
// knob with an M8 screw running back through the tongue into the base
let rk = knob_diameter / 2.0;
let knob = cylinder([0, w + 1.0 + opening, zs], "Y", rk, 10.0).chamfer(0.8, "%CIRCLE");
let flutes = [];
for i in 0..12 {
    flutes.push(cylinder([0, w, zs + rk + 0.6], "Y", 1.5, 13.0 + opening).rotate([0, 0, zs], "Y", i.to_float() * 30.0));
}
knob = knob - compound(flutes);
let screw = cylinder([0, -6.0, zs], "Y", 3.9, w + 8.0 + opening);
compound([base, jaw, knob + screw])
