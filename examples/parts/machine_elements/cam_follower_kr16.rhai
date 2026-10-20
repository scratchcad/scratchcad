// Stud-type track roller (cam follower) KR 16: 16 mm outer ring 11 mm wide, 6 mm stud M6x1 16 mm long, 12 mm flange, 3 mm hex socket in the stud end
let roller_diameter = 16.0; // [10.0, 52.0] Roller diameter (mm)
let roller_width = 11.0; // [7.0, 25.0] Roller width (mm)
let stud_diameter = 6.0; // [3.0, 20.0] Stud diameter (mm)
let stud_length = 16.0; // [8.0, 40.0] Stud length (mm)
const socket = 3.0;
let rr = roller_diameter / 2.0;
let rs = min(stud_diameter / 2.0, rr - 2.0);
let roller = cylinder(rr, roller_width).chamfer(min(0.6, rr * 0.08), "%CIRCLE");
let inner = cylinder([0, 0, roller_width], "Z", rr * 0.75, 0.6);
let flange = cylinder([0, 0, roller_width + 0.59], "Z", rr * 0.75, 1.0);
let stud = cylinder([0, 0, roller_width + 1.5], "Z", rs, stud_length).chamfer(0.5, ">Z");
let part = fuse_all([roller, inner, flange, stud]);
let hp = [];
for i in 0..6 {
    let a = i.to_float() * PI() / 3.0;
    hp.push([socket / sqrt(3.0) * a.cos(), socket / sqrt(3.0) * a.sin()]);
}
let sock = polygon(hp).to_face().extrude(4.0).translate([0, 0, roller_width + 1.5 + stud_length - 3.5]);
part - sock - sock.mirror("XY").translate([0, 0, 3.5]) 
