// Duct test port plug for 13 mm access holes: 28 mm cap 3 mm thick, 10 mm stem 18 mm long with 3 conical sealing fins 13 to 16 mm, 45 mm tether strap 6 x 1.5 mm with a 6 mm eyelet
let hole_d = 13.0; // [8.0, 20.0] Port hole diameter (mm)
let cap_d = 28.0; // [22.0, 40.0] Cap diameter (mm)
let stem_l = 18.0; // [12.0, 30.0] Stem length (mm)
let tether = 45.0; // [25.0, 80.0] Tether length (mm)
const cap_t = 3.0;
let rs = hole_d / 2.0 - 1.5;
let rcap = max(cap_d / 2.0, hole_d / 2.0 + 5.0);
let cap = cylinder(rcap, cap_t).chamfer(0.8, ">Z");
let stem = cylinder([0, 0, -stem_l], "Z", rs, stem_l + 0.5);
let fins = [];
let pitch = (stem_l - 2.0) / 3.0;
for i in 0..3 {
    let z = -stem_l + 1.0 + i.to_float() * pitch;
    fins.push(cone(hole_d / 2.0 - 0.5, hole_d / 2.0 + 1.5, pitch * 0.8).translate([0, 0, z]));
}
let strap = box_from_corners([rcap - 2.0, -3.0, 0], [rcap + tether, 3.0, 1.5]);
let eye = cylinder([rcap + tether, 0, 0], "Z", 6.0, 1.5) - cylinder([rcap + tether, 0, -1], "Z", 3.0, 3.5);
let plug = fuse_all([cap, stem, eye] + fins);
plug + (strap - cylinder([rcap + tether, 0, -1], "Z", 3.0, 3.5))
