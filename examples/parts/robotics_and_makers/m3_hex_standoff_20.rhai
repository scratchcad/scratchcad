// M3 x 20 mm brass hex standoff, male-female: 5.5 mm across flats, 6 mm M3 male stud with thread grooves, 2.5 mm tap-drill bore 8 mm deep in the female end, chamfered hex
let length = 20.0; // [5.0, 50.0] Body length (mm)
let af = 5.5; // [4.5, 8.0] Hex across flats (mm)
let stud = 6.0; // [0.0, 10.0] Male stud length (mm)
let bore_depth = 8.0; // [3.0, 15.0] Female thread depth (mm)
const m = 3.0;
const pitch = 0.5;
let rc = af / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(hp).to_face().extrude([0, 0, length]);
let cham = cone(af / 2.0 - 0.2, rc + 0.6, 0.8) + cylinder([0, 0, 0.8], "Z", rc + 0.6, length - 1.6) + cone(rc + 0.6, af / 2.0 - 0.2, 0.8).translate([0, 0, length - 0.8]);
let s = hex & cham;
if stud > 0.0 {
    let p = [[0, 0, length - 0.5], [m / 2.0 - 0.3, 0, length - 0.5]];
    let n = (stud / pitch).floor().to_int() - 1;
    for i in 0..n {
        let z = length + i.to_float() * pitch;
        p += [[m / 2.0 - 0.3, 0, z + 0.05], [m / 2.0, 0, z + 0.2], [m / 2.0, 0, z + 0.3], [m / 2.0 - 0.3, 0, z + 0.45]];
    }
    p += [[m / 2.0 - 0.3, 0, length + stud - 0.3], [m / 2.0 - 0.6, 0, length + stud], [0, 0, length + stud]];
    s += polygon(p).to_face().revolve("Z", 360);
}
s - cylinder([0, 0, -1], "Z", 1.25, min(bore_depth, length - 1.0) + 1.0) - cone(1.8, 1.25, 0.55).translate([0, 0, -0.01])
