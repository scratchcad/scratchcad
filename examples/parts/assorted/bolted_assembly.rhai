// M8 bolt, two washers and a nut clamping two plates, exploded along the bolt
let explode = 10.0; // [0.0, 30.0] Explode distance (mm)
let plate_t = 10.0; // [3.0, 20.0] Plate thickness (mm)
let bolt_length = 40.0; // [25.0, 80.0] Bolt length (mm)
let tan30 = (30.0 * PI() / 180.0).tan();
fn hex(af, h) {
    let rc = af / sqrt(3.0); let pts = [];
    for i in 0..6 { let a = (i * 60 + 30).to_float() * PI() / 180.0; pts.push([rc * a.cos(), rc * a.sin()]); }
    polygon(pts).to_face().extrude(h).chamfer(0.5, ">Z or <Z")
}
let plate = box_centered(60, 40, plate_t).translate([0, 0, plate_t / 2.0]) - cylinder([0, 0, -1], "Z", 4.5, plate_t + 2.0);
let washer = cylinder(8.0, 1.6) - cylinder([0, 0, -1], "Z", 4.2, 3.6);
let bolt = hex(13.0, 5.3).translate([0, 0, -5.3]) + cylinder([0, 0, -0.1], "Z", 4.0, bolt_length + 0.1).chamfer(0.8, ">Z");
let nut = hex(13.0, 6.5) - cylinder([0, 0, -1], "Z", 3.4, 8.5);
let z = 0.0; let e = explode;
let parts = [];
parts.push(bolt.translate([0, 0, -e * 2.0]));
parts.push(washer.translate([0, 0, -e]));
z += 1.6;
parts.push(plate.translate([0, 0, z]));
parts.push(plate.translate([0, 0, z + plate_t + e]));
z += 2.0 * plate_t;
parts.push(washer.translate([0, 0, z + 2.0 * e]));
parts.push(nut.translate([0, 0, z + 1.6 + 3.0 * e]));
compound(parts)
