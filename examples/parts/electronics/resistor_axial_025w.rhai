// 1/4 W axial resistor: 6.3 x 2.4 mm body with end caps, 0.6 mm leads bent down at 10.16 mm pitch, 4 colour bands
let body_l = 6.3; // [3.0, 12.0] Body length (mm)
let body_d = 2.4; // [1.5, 5.0] Body diameter (mm)
let pitch = 10.16; // [7.62, 20.32] Lead pitch (mm)
let lead_d = 0.6; // [0.4, 0.8] Lead diameter (mm)
let z = 3.0;
let body = cylinder([-body_l / 2.0, 0, z], "X", body_d / 2.0 * 0.9, body_l) + cylinder([-body_l / 2.0, 0, z], "X", body_d / 2.0, 1.2) + cylinder([body_l / 2.0 - 1.2, 0, z], "X", body_d / 2.0, 1.2);
let bands = [];
for i in 0..4 { bands.push(cylinder([-1.6 + i.to_float() * 0.9, 0, z], "X", body_d / 2.0 * 0.93, 0.4)); }
let lead = |x| { let path = wire([line([x * body_l / 2.0, 0, z], [x * (pitch / 2.0 - 0.6), 0, z]), arc([x * (pitch / 2.0 - 0.6), 0, z], [x * (pitch / 2.0 - 0.6 + 0.6 * 0.7071), 0, z - 0.6 + 0.6 * 0.7071], [x * pitch / 2.0, 0, z - 0.6]), line([x * pitch / 2.0, 0, z - 0.6], [x * pitch / 2.0, 0, -3.0])]); circle([x * body_l / 2.0, 0, z], "X", lead_d / 2.0).to_face().sweep(path) };
fuse_all([body] + bands + [lead.call(1.0), lead.call(-1.0)])
