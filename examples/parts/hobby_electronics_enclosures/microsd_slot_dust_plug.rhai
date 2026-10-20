// Tethered dust plug for a microSD card slot in a 2 mm case wall: 14 x 4 mm cap 1.2 mm thick, 11.6 x 1.4 mm tongue 4 mm deep with 0.15 mm crush ribs, 25 mm strap 0.8 mm thick to a 3 mm peg
let slot_w = 11.6; // [8.0, 26.0] Slot width (mm)
let slot_h = 1.4; // [0.8, 3.0] Slot height (mm)
let depth = 4.0; // [2.0, 8.0] Tongue depth (mm)
let cap_t = 1.2; // [0.8, 2.0] Cap thickness (mm)
let strap = 25.0; // [10.0, 40.0] Strap length (mm)
let cap_w = slot_w + 2.4;
let cap_h = slot_h + 2.6;
let cap = box_centered(cap_w, cap_h, cap_t).translate([0, 0, cap_t / 2.0]);
let cap = cap.fillet(min(cap_h * 0.45, 1.5), cap.edges("|Z"));
let tongue = box_centered(slot_w - 0.1, slot_h - 0.1, depth + 0.5).translate([0, 0, cap_t + depth / 2.0 - 0.25]);
let parts = [cap, tongue];
for x in [-slot_w / 4.0, slot_w / 4.0] {
    parts.push(box_centered(0.6, slot_h + 0.2, depth * 0.6).translate([x, 0, cap_t + depth * 0.5]));
}
parts.push(box_from_corners([cap_w / 2.0 - 1.0, -1.0, 0], [cap_w / 2.0 + strap, 1.0, 0.8]));
parts.push(cylinder([cap_w / 2.0 + strap, 0, 0], "Z", 2.5, 0.8));
parts.push(cylinder([cap_w / 2.0 + strap, 0, 0.5], "Z", 1.5, 2.5));
parts.push(cylinder([cap_w / 2.0 + strap, 0, 2.6], "Z", 1.8, 0.6));
fuse_all(parts)
