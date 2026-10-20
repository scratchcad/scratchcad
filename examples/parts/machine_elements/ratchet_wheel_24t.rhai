// Ratchet wheel, 24 saw teeth: 60 mm tip diameter, 4 mm tooth depth with radial locking faces, 8 mm thick, 25 mm hub 4 mm proud, 12 mm bore with flats
let teeth = 24; // [8, 60] Number of teeth
let tip_diameter = 60.0; // [20.0, 200.0] Tip diameter (mm)
let tooth_depth = 4.0; // [1.5, 10.0] Tooth depth (mm)
let thickness = 8.0; // [3.0, 25.0] Wheel thickness (mm)
let bore = 12.0; // [4.0, 30.0] Bore diameter (mm)
let ro = tip_diameter / 2.0;
let rr = ro - min(tooth_depth, ro * 0.3);
let pts = [];
for i in 0..teeth {
    let a = i.to_float() * 2.0 * PI() / teeth.to_float();
    pts.push([ro * a.cos(), ro * a.sin()]);
    pts.push([rr * a.cos(), rr * a.sin()]);
}
let wheel = polygon(pts).to_face().extrude(thickness);
let hub = cylinder([0, 0, thickness - 0.01], "Z", min(12.5, rr - 3.0), 4.01);
let part = wheel + hub;
let hole = cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 6.0) & box_centered(bore * 0.85, bore + 2.0, 2.0 * thickness + 20.0);
part - hole
