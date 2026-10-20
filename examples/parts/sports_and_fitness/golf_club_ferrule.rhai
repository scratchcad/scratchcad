// Iron golf club ferrule for 0.355 in (9.0 mm) tip shafts: 25 mm long, 9.0 mm bore, 13.5 mm base tapering to 9.9 mm at the top, two 0.4 mm trim rings
let bore_d = 9.0; // [8.4, 9.4] Shaft bore (mm)
let length = 25.0; // [15.0, 35.0] Length (mm)
let base_d = 13.5; // [11.0, 16.0] Base diameter (mm)
let top_d = 9.9; // [9.6, 12.0] Top diameter (mm)
let rings = 2; // [0, 4] Number of trim rings
let rt = max(top_d, bore_d + 0.6) / 2.0;
let rb = max(base_d, top_d) / 2.0;
let prof = [[bore_d / 2.0, 0.0], [rb - 0.3, 0.0], [rb, 0.3], [rt, length - 0.3], [rt - 0.3, length], [bore_d / 2.0, length]];
let ferrule = polygon("XZ", prof).to_face().revolve("Z", 360);
for i in 0..rings {
    let z = 3.0 + i.to_float() * 1.6;
    ferrule = ferrule - (cylinder([0, 0, z], "Z", rb + 1.0, 0.8) - cylinder([0, 0, z - 1.0], "Z", rb - 0.4 - (rb - rt) * (z + 1.0) / length, 3.0));
}
ferrule
