// Garden cane safety cap: eye-protector cap for 8 to 12 mm bamboo canes, 35 mm faceted ball-style head, 25 mm deep socket with 4 flexible grip fins, 2 mm netting groove around the head
// # Cane
let cane = 10.0; // [6.0, 16.0] Cane diameter (mm)
let socket_depth = 25.0; // [15.0, 35.0] Socket depth (mm)
// # Head
let head_d = 35.0; // [25.0, 50.0] Head diameter (mm)
let fins = 4; // [3, 6] Number of grip fins
let r = head_d / 2.0;
let head = sketch("XZ").move_to(0, 0).hline_to(cane / 2.0 + 3.0).line_to(r, r * 0.6).vline(r * 0.5).line_to(r * 0.6, r * 1.8).hline_to(0).close().to_face().revolve("Z", 360);
let groove = cylinder([0, 0, r * 0.75], "Z", r + 1.0, 2.0) - cylinder([0, 0, r * 0.75 - 1.0], "Z", r - 1.5, 4.0);
let socket = cylinder([0, 0, -1.0], "Z", cane / 2.0 + 1.0, min(socket_depth, r * 1.8 - 4.0) + 1.0);
let fs = [];
for i in 0..fins {
    fs.push(box_centered(cane + 3.0, 1.0, socket_depth).rotate_z(i.to_float() * 180.0 / fins.to_float()).translate([0, 0, socket_depth / 2.0]));
}
let fin_set = (fuse_all(fs) & cylinder([0, 0, 0], "Z", cane / 2.0 + 1.5, socket_depth)) - cylinder([0, 0, -1.0], "Z", cane / 2.0 - 0.4, socket_depth + 2.0);
head - groove - socket + fin_set
