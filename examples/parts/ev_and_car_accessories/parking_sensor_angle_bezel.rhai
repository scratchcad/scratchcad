// Parking sensor angled bezel: 18.2 mm bore for an 18 mm ultrasonic sensor, 22 mm spigot 8 mm into the bumper hole, 30 mm flange wedged 10 degrees to aim the sensor level on a sloped bumper, 2 retaining barbs
let sensor = 18.2; // [16.0, 22.5] Sensor bore (mm)
let hole = 22.0; // [19.0, 26.0] Bumper hole (mm)
let flange = 30.0; // [26.0, 38.0] Flange diameter (mm)
let wedge = 10.0; // [0.0, 20.0] Wedge angle (degrees)
let spigot = 8.0; // [5.0, 12.0] Spigot length (mm)

const min_t = 2.0;
let hd = max(hole, sensor + 2.4);
let fd = max(flange, hd + 6.0);
let rise = fd * tan(wedge * PI() / 180.0);
let h = min_t + rise;
let body = cylinder([0, 0, 0], "Z", fd / 2.0, h + 1.0);
let cutter = box_centered(fd * 3.0, fd * 3.0, fd * 2.0).translate([0, 0, fd]).rotate_x(-wedge).translate([0, 0, min_t + rise / 2.0]);
body = body - cutter;
let sp = cylinder([0, 0, -spigot], "Z", hd / 2.0, spigot + 0.5);
let barbs = [];
for s in [-1.0, 1.0] {
    barbs.push(polygon([[s * (hd / 2.0 - 0.6), -2.5, -spigot + 1.0], [s * (hd / 2.0 + 0.7), -2.5, -spigot + 3.5], [s * (hd / 2.0 - 0.6), -2.5, -spigot + 3.5]]).to_face().extrude([0, 5.0, 0]));
}
let bezel = fuse_all([body, sp, compound(barbs)]);
bezel = bezel - cylinder([0, 0, -spigot - 1.0], "Z", sensor / 2.0, spigot + h + 5.0);
for s in [-1.0, 1.0] {
    bezel = bezel - box_from_corners([s * hd / 2.0 - 3.0, -4.0, -spigot - 1.0], [s * hd / 2.0 + 3.0, -3.0, -1.0]) - box_from_corners([s * hd / 2.0 - 3.0, 3.0, -spigot - 1.0], [s * hd / 2.0 + 3.0, 4.0, -1.0]);
}
bezel
