// Broom and mop gripper: 3 spring-cam slots for 20 to 32 mm handles, 260 x 45 x 20 mm rail, 2 screw holes
let slots = 3; // [2, 6] Number of grips
let pitch = 80.0; // [60.0, 100.0] Grip pitch (mm)
let handle = 32.0; // [20.0, 40.0] Max handle diameter (mm)
let length = slots.to_float() * pitch + 20.0;
let rail = box_from_corners([0, 0, 0], [length, 45.0, 20.0]);
let r = rail.fillet(6.0, rail.edges("|Y"));
let cuts = [];
for i in 0..slots {
    let x = 10.0 + pitch / 2.0 + i.to_float() * pitch;
    cuts.push(cylinder([x, handle / 2.0 + 8.0, -1], "Z", handle / 2.0, 22.0) + box_from_corners([x - handle * 0.35, handle / 2.0 + 8.0, -1], [x + handle * 0.35, 46.0, 21.0]));
}
r - fuse_all(cuts) - cylinder([15.0, 6.0, -1], "Z", 2.2, 22.0) - cylinder([length - 15.0, 6.0, -1], "Z", 2.2, 22.0)
