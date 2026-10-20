// XLR cable strain relief boot: 60 mm tapered boot from a 14 mm socket (connector tail) to a 7 mm cable bore, 1.5 mm wall at the tip, 8 flex grooves 1 mm deep
let length = 60.0; // [35.0, 90.0] Boot length (mm)
let base = 14.0; // [10.0, 20.0] Connector end bore (mm)
let cable = 7.0; // [4.0, 10.0] Cable bore (mm)
let grooves = 8; // [3, 12] Number of flex grooves
let rb = base / 2.0 + 2.0;
let rt = cable / 2.0 + 1.5;
let outer = polygon("XZ", [[cable / 2.0, 0], [rb, 0], [rb, 12.0], [rt, length], [cable / 2.0, length]]).to_face().revolve([0, 0, 0], "Z", 360);
let socket = cylinder([0, 0, -1.0], "Z", base / 2.0, 13.0);
let cuts = [];
for i in 0..grooves {
    let z = 16.0 + i.to_float() * (length - 20.0) / grooves.to_float();
    let rz = rb + (rt - rb) * (z - 12.0) / (length - 12.0);
    cuts.push(cylinder([0, 0, z], "Z", rz + 1.0, 1.2) - cylinder([0, 0, z - 1.0], "Z", rz - 1.0, 4.0));
}
outer - socket - compound(cuts)
