// Adhesive cable tie mount: 20 x 20 mm base 1.5 mm thick with a cross-shaped tie tunnel 5 mm wide
let size = 20.0; // [10.0, 40.0] Base size (mm)
let base_t = 1.5; // [1.0, 3.0] Base thickness (mm)
let tunnel_w = 5.0; // [2.5, 9.0] Tie width (mm)
let tunnel_h = 1.8; // [1.0, 3.0] Tie thickness (mm)
let dome_h = 5.0; // [3.5, 10.0] Mount height (mm)
let base = box_centered(size, size, base_t).translate([0, 0, base_t / 2.0]).chamfer(1.0, "|Z");
let dome = (sphere(size * 0.38) & box_centered(size, size, dome_h).translate([0, 0, dome_h / 2.0])).scale([0, 0, 0], 1.0);
let mount = base + (dome & box_centered(size, size, dome_h * 2.0).translate([0, 0, dome_h]));
let tunnel = box_centered(size + 2, tunnel_w, tunnel_h).translate([0, 0, base_t + tunnel_h / 2.0 + 0.3]);
mount - tunnel - tunnel.rotate_z(90)
