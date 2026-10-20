// Cable reel (spool), 100 mm flanges 3 mm thick, 40 mm drum 50 mm wide between flanges, 16 mm arbor hole, six 16 mm lightening holes per flange and a 3 mm cable anchor hole next to the drum
let flange_diameter = 100.0; // [50.0, 200.0] Flange diameter (mm)
let drum_diameter = 40.0; // [15.0, 120.0] Drum diameter (mm)
let traverse = 50.0; // [10.0, 120.0] Width between flanges (mm)
let flange_thickness = 3.0; // [1.5, 6.0] Flange thickness (mm)
let arbor_hole = 16.0; // [5.0, 52.0] Arbor hole diameter (mm)
let windows = 6; // [2, 12] Lightening holes per flange
let rf = flange_diameter / 2.0;
let rd = min(drum_diameter / 2.0, rf - 6.0);
let ra = min(arbor_hole / 2.0, rd - 2.0);
let total = traverse + 2.0 * flange_thickness;
let reel = fuse_all([
    cylinder(rf, flange_thickness),
    cylinder([0, 0, flange_thickness - 0.1], "Z", rd, traverse + 0.2),
    cylinder([0, 0, total - flange_thickness], "Z", rf, flange_thickness),
]);
// the drum is hollow inside a 2.5 mm wall, so only a hub ring carries the arbor hole
reel = reel - cylinder([0, 0, flange_thickness], "Z", rd - 2.5, traverse);
reel = reel + (cylinder([0, 0, flange_thickness - 0.1], "Z", ra + 2.5, traverse + 0.2));
reel = reel - cylinder([0, 0, -1], "Z", ra, total + 2.0);
reel = reel.fillet(0.8, "%CIRCLE and (>Z or <Z)");
let rw = (rd + rf) / 2.0;
let ww = min((rf - rd) * 0.35, rw * PI() / windows.to_float() * 0.6);
let cuts = [];
for i in 0..windows {
    cuts.push(cylinder([rw, 0, -1], "Z", ww, total + 2.0).rotate_z(i.to_float() * 360.0 / windows.to_float()));
}
cuts.push(cylinder([rd + 2.5, 0, -1], "Z", 1.5, flange_thickness + 2.0).rotate_z(180.0 / windows.to_float()));
reel - compound(cuts)
