// Long-handled bath sponge mount: head that fixes a 100 x 70 mm bath sponge to a 22 mm reach handle, 80 x 60 mm backing plate 4 mm thick with 12 x 4 mm grip spikes, 30 degree angled 22 mm handle socket 35 mm deep with an M5 grub screw
// # Plate
let plate_l = 80.0; // [60.0, 110.0] Plate length (mm)
let plate_w = 60.0; // [40.0, 80.0] Plate width (mm)
let plate_t = 4.0; // [3.0, 6.0] Plate thickness (mm)
let spikes = 4; // [2, 6] Number of spike rows
// # Handle
let handle = 22.0; // [16.0, 28.0] Handle diameter (mm)
let socket_depth = 35.0; // [20.0, 50.0] Socket depth (mm)
let angle = 30.0; // [0.0, 45.0] Socket angle (degrees)
let plate = box_centered(plate_l, plate_w, plate_t).translate([0, 0, plate_t / 2.0]).fillet(10.0, "|Z");
let ss = [];
for i in 0..spikes {
    for j in 0..3 {
        let x = (i.to_float() - (spikes - 1).to_float() / 2.0) * (plate_l - 20.0) / max(spikes - 1, 1).to_float();
        let y = (j.to_float() - 1.0) * (plate_w - 24.0) / 2.0;
        ss.push(cone(2.0, 0.5, 12.0).translate([x, y, -11.99]));
    }
}
let rs = handle / 2.0 + 3.5;
let sock = cylinder([0, 0, -rs], "Z", rs, socket_depth + rs).rotate_y(-angle).translate([0, 0, plate_t + rs * 0.9]);
let bore = cylinder([0, 0, 2.0], "Z", handle / 2.0 + 0.2, socket_depth + rs).rotate_y(-angle).translate([0, 0, plate_t + rs * 0.9]);
let grub = cylinder([0, -rs - 2.0, socket_depth * 0.6], "Y", 2.1, rs + 2.0).rotate_y(-angle).translate([0, 0, plate_t + rs * 0.9]);
let sock_trim = sock - box_centered(plate_l * 3.0, plate_w * 3.0, 20.0).translate([0, 0, -10.0]);
(plate + sock_trim + compound(ss)) - bore - grub
