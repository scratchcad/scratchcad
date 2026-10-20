// Under-chassis bracket for a 5-channel TCRT5000 line sensor board: 2 mm plate 60 x 16 mm with five 10.4 x 5.8 mm sensor windows on 10 mm pitch, two drop legs 10 mm tall with M3 chassis holes
let channels = 5; // [3, 8] Number of sensor channels
let pitch = 10.0; // [8.0, 15.0] Sensor pitch (mm)
let drop = 10.0; // [5.0, 25.0] Height of the drop legs (mm)
const t = 2.0;
let len = channels.to_float() * pitch + 10.0;
let p = box_centered(len, 16.0, t).translate([0, 0, t / 2.0]);
for i in 0..channels {
    let x = -len / 2.0 + 5.0 + pitch * (i.to_float() + 0.5);
    p -= box_centered(10.4, 5.8, 10.0).translate([x, 0, 0]);
}
let legs = [];
for s in [-1.0, 1.0] {
    let x = s * (len / 2.0 - t / 2.0);
    legs.push(box_centered(t, 16.0, drop).translate([x, 0, t + drop / 2.0 - 0.01]));
    legs.push((box_centered(10.0, 16.0, t).translate([x + s * (5.0 - t / 2.0), 0, t + drop - t / 2.0])) - cylinder([x + s * 5.0, 0, t + drop - 5.0], "Z", 1.6, 10.0));
}
let b = fuse_all([p] + legs);
b - cylinder([-len / 2.0 + 2.0, 0, -1], "Z", 0.01 + 1.1, 0.0 + 4.0) - cylinder([len / 2.0 - 2.0, 0, -1], "Z", 1.1, 4.0)
