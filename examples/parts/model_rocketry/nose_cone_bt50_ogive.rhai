// Model rocket nose cone for BT-50 (24.8 mm OD, 24.1 mm ID): 3:1 tangent ogive 75 mm, 20 mm shoulder, 1.2 mm wall, eyelet
let od = 24.8; // [18.0, 66.0] Body tube OD (mm)
let id = 24.1; // [17.0, 65.0] Body tube ID (mm)
let length = 75.0; // [40.0, 200.0] Nose length (mm)
let shoulder = 20.0; // [10.0, 40.0] Shoulder length (mm)
let wall = 1.2; // [0.8, 2.0] Wall (mm)
let R = od / 2.0;
let rho = (R * R + length * length) / (2.0 * R);
let pts = [];
for i in 0..=20 {
    let z = length * i.to_float() / 20.0;
    let y = (rho * rho - z * z).sqrt() + R - rho;
    pts.push([y.max(0.0), 0, z]);
}
let prof = [[0.0, 0, -shoulder]];
prof.push([id / 2.0 - 0.05, 0, -shoulder]);
prof.push([id / 2.0 - 0.05, 0, 0]);
for p in pts { prof.push(p); }
let solid_ = polygon(prof).to_face().revolve("Z", 360);
let cavity = cylinder([0, 0, -shoulder - 1.0], "Z", id / 2.0 - 0.05 - wall, shoulder + 9.0);
let eye = cylinder([0, -1.5, 6.0], "Y", 3.0, 3.0) - cylinder([0, -2.0, 6.0], "Y", 1.5, 4.0);
solid_ - cavity + (eye & cylinder([0, 0, -shoulder - 1.0], "Z", id / 2.0 - 0.06, shoulder))
