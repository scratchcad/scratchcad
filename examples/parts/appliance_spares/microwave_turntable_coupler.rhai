// Microwave turntable coupler: 22 mm tall, 3-lobe Y drive top for the glass tray, 7 x 4.5 mm D socket underneath
let height = 22.0; // [15.0, 30.0] Height (mm)
let lobe = 15.0; // [10.0, 20.0] Lobe radius (mm)
let core = cylinder(6.0, height);
let lobes = [];
for k in 0..3 { lobes.push(box_from_corners([0, -2.5, height - 8.0], [lobe, 2.5, height]).rotate_z(k.to_float() * 120.0)); }
let socket = cylinder([0, 0, -1], "Z", 3.5, 12.0) - box_from_corners([1.0, -4, -2], [4, 4, 12.0]);
core + fuse_all(lobes) - socket
