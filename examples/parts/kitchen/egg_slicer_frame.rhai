// Egg slicer: 120 x 75 mm base with an egg-shaped cradle 45 x 60 mm, 10 slots 6 mm apart, hinged lid frame strung with 10 stainless wires 0.3 mm, shown open 70 deg
let slot_count = 10; // [6, 14] Number of slices
let slice_pitch = 6.0; // [4.0, 8.0] Slice thickness (mm)
let egg_width = 45.0; // [38.0, 52.0] Egg width (mm)
let egg_length = 60.0; // [50.0, 70.0] Egg length (mm)
let open_angle = 70.0; // [0.0, 100.0] Lid opening angle (deg)
let span = (slot_count - 1).to_float() * slice_pitch;
let base = box_centered(120.0, 75.0, 22.0).translate([0, 0, 11.0]).fillet(10.0, "|Z").fillet(3.0, ">Z");
// cradle: an egg-shaped pocket from a sphere stretched by two spheres along X
let cradle = fuse_all([sphere([-egg_length / 2.0 + egg_width / 2.0, 0, 22.0 + 4.0], egg_width / 2.0), sphere([egg_length / 2.0 - egg_width / 2.0, 0, 22.0 + 4.0], egg_width / 2.0 - 2.0),
                       cylinder([-egg_length / 2.0 + egg_width / 2.0, 0, 26.0], "X", egg_width / 2.0 - 1.0, egg_length - egg_width)]);
base = base - cradle;
// slots for the wires, across the cradle
let slots = [];
for i in 0..slot_count {
    let y = -span / 2.0 + i.to_float() * slice_pitch;
    slots.push(box_centered(egg_length + 6.0, 1.0, 22.0).translate([0, y, 20.0]));
}
base = base - compound(slots);
// hinge knuckles on the -X end of the base and the lid frame with wires
const hx = -54.0;
let knuckles = cylinder([hx, -32.0, 24.0], "Y", 4.0, 10.0) + cylinder([hx, 22.0, 24.0], "Y", 4.0, 10.0);
base = base + knuckles;
let frame = (box_centered(egg_length + 20.0, span + 20.0, 6.0) - box_centered(egg_length + 6.0, span + 6.0, 8.0)).fillet(3.0, "|Z").translate([hx + 2.0 + (egg_length + 20.0) / 2.0, 0, 26.0]);
let wires = [];
for i in 0..slot_count {
    let y = -span / 2.0 + i.to_float() * slice_pitch;
    wires.push(cylinder([hx + 9.0, y, 27.0], "X", 0.3, egg_length + 10.0));
}
let lid = fuse_all([frame, cylinder([hx, -21.5, 24.0], "Y", 4.0, 43.0)] + wires).rotate([hx, 0, 24.0], "Y", -open_angle);
compound([base, lid])
