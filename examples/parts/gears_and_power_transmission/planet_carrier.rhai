// Planetary gear carrier: 50 mm disk 5 mm thick, 3 planet pins of 5 mm on a 30 mm circle, 10 mm output shaft
let disk_d = 50.0; // [30.0, 120.0] Disk diameter (mm)
let disk_t = 5.0; // [3.0, 12.0] Disk thickness (mm)
let pin_circle = 30.0; // [16.0, 51.6] Planet pin circle (mm)
let pin_d = 5.0; // [3.0, 12.0] Pin diameter (mm)
let pin_l = 12.0; // [6.0, 30.0] Pin length (mm)
let planets = 3; // [2, 6] Planets
let shaft_d = 10.0; // [5.0, 25.0] Output shaft diameter (mm)
let parts = [cylinder(disk_d / 2.0, disk_t), cylinder([0, 0, -20.0], "Z", shaft_d / 2.0, 20.01)];
for i in 0..planets { parts.push(cylinder([pin_circle / 2.0, 0, disk_t - 0.01], "Z", pin_d / 2.0, pin_l).rotate_z(i.to_float() * 360.0 / planets.to_float())); }
let carrier = fuse_all(parts);
for i in 0..planets { carrier -= cylinder([pin_circle / 2.0, 0, 0], "Z", disk_d * 0.1, disk_t * 2.0).rotate_z(i.to_float() * 360.0 / planets.to_float() + 180.0 / planets.to_float()).translate([0, 0, -1]); }
carrier
