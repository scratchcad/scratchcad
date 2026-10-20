// Payload bay tube coupler for BT-50: 24.0 mm OD 60 mm long, 1 mm wall, 5 mm stop band at the middle
let id_body = 24.1; // [18.0, 66.0] Body tube ID (mm)
let od_body = 24.8; // [18.6, 67.0] Body tube OD (mm)
let length = 60.0; // [30.0, 120.0] Coupler length (mm)
let wall = 1.0; // [0.6, 2.0] Wall (mm)
let c = cylinder(id_body / 2.0 - 0.05, length) - cylinder([0, 0, -1], "Z", id_body / 2.0 - 0.05 - wall, length + 2.0);
let band = cylinder([0, 0, length / 2.0 - 2.5], "Z", od_body / 2.0, 5.0) - cylinder([0, 0, length / 2.0 - 3.5], "Z", id_body / 2.0 - 0.06, 7.0);
c + band
