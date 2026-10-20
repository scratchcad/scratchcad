// Spur gear blank for module 2, 30 teeth: 64 mm tip diameter, 20 mm face, 40 mm hub projecting 10 mm, web recess 5 mm deep each side, 20 mm bore with 6 mm keyway, 1 mm tip chamfers
let gear_module = 2.0; // [1.1, 6.0] Module (mm)
let teeth = 30; // [12, 120] Number of teeth
let face_width = 20.0; // [5.0, 60.0] Face width (mm)
let hub_diameter = 40.0; // [15.0, 100.0] Hub diameter (mm)
let hub_projection = 10.0; // [0.0, 30.0] Hub projection (mm)
let bore = 20.0; // [5.0, 50.0] Bore diameter (mm)
let rt = gear_module * (teeth.to_float() + 2.0) / 2.0;
let rroot = gear_module * (teeth.to_float() - 2.5) / 2.0;
let rh = min(max(hub_diameter / 2.0, bore / 2.0 + 4.0), rroot - 4.0);
let blank = cylinder(rt, face_width).chamfer(min(1.0, gear_module * 0.5), "%CIRCLE");
let rim_in = rroot - 2.0 * gear_module;
if rim_in > rh + 3.0 {
    let rec = cylinder([0, 0, -1], "Z", rim_in, 1.0 + face_width * 0.25) - cylinder([0, 0, -2], "Z", rh, face_width);
    blank = blank - rec - rec.mirror([0, 0, face_width / 2.0], "Z");
}
let hub = cylinder([0, 0, face_width - 0.01], "Z", rh, hub_projection + 0.01);
let part = if hub_projection > 0.0 { blank + hub } else { blank };
let total = face_width + hub_projection;
let key = box_from_corners([-3.0, 0, -1], [3.0, bore / 2.0 + 2.8, total + 1.0]);
part - fuse_all([cylinder([0, 0, -1], "Z", bore / 2.0, total + 2.0), key])
