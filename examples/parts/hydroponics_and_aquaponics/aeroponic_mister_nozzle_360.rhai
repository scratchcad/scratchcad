// Aeroponic 360 degree mister nozzle: 8 mm hex body 5 mm tall on a 10-32 (4.8 mm) threaded stem 6 mm long with a 1.5 mm feed bore, a 6 mm cone head 5 mm tall with six 0.8 mm radial jets and a 0.8 mm top jet
let hex_af = 8.0; // [6.0, 12.0] Hex across flats (mm)
let stem_len = 6.0; // [4.0, 10.0] Stem length (mm)
let jets = 6; // [3, 12] Number of side jets
let jet_d = 0.8; // [0.4, 1.2] Jet diameter (mm)
const head_h = 5.0;
const hex_h = 5.0;
let hr = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let hpts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hpts.push([hr * cos(a), hr * sin(a), 0]);
}
let hex = face(polygon(hpts)).extrude([0, 0, hex_h]);
let stem = cylinder([0, 0, -stem_len], "Z", 2.4, stem_len + 0.5);
let head = cone(3.0, 1.2, head_h).translate([0, 0, hex_h - 0.5]);
let body = fuse_all([hex, stem, head]);
let jz = hex_h + 1.2;
let cuts = [cylinder([0, 0, -stem_len - 1.0], "Z", 0.75, stem_len + jz + 0.75), cylinder([0, 0, jz], "Z", jet_d / 2.0, head_h + 2.0)];
for i in 0..jets {
    cuts.push(cylinder([0, 0, jz], "X", jet_d / 2.0, 4.0).rotate_z(i.to_float() * 360.0 / jets.to_float()));
}
body - fuse_all(cuts)
