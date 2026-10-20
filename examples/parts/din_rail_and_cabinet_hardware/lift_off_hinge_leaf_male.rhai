// Lift-off cabinet door hinge, pin half: 40 x 30 x 3 mm leaf with two 5.5 mm countersunk holes on 20 mm, 10 mm knuckle 20 mm tall on the leaf edge, 6 mm pin standing 15 mm proud with a 1 mm chamfer
let leaf_h = 40.0; // [25.0, 80.0] Leaf height (mm)
let leaf_w = 30.0; // [20.0, 50.0] Leaf width (mm)
let pin_d = 6.0; // [4.0, 7.0] Pin diameter (mm)
let pin_len = 15.0; // [8.0, 25.0] Pin length (mm)
const t = 3.0;
const knuckle_d = 10.0;
let knuckle_h = leaf_h / 2.0;
let leaf = box_from_corners([0, -t, 0], [leaf_w, 0, leaf_h]);
let leaf = leaf.fillet(3.0, leaf.edges("|Y and >X"));
let knuckle = cylinder([-knuckle_d / 2.0 + 0.5, -t / 2.0, 0], "Z", knuckle_d / 2.0, knuckle_h);
let web = box_from_corners([-knuckle_d / 2.0 + 0.5, -t, 0], [1.0, 0, knuckle_h]);
let pin = cylinder([-knuckle_d / 2.0 + 0.5, -t / 2.0, knuckle_h - 0.5], "Z", pin_d / 2.0, pin_len + 0.5);
let pin = pin.chamfer(1.0, pin.edges(">Z"));
let holes = [];
for z in [leaf_h / 2.0 - 10.0, leaf_h / 2.0 + 10.0] {
    let x = leaf_w / 2.0 + 3.0;
    // countersink on the outer (y = 0) face
    holes.push(cylinder([x, 1.0, z], "-Y", 2.75, t + 2.0) + cone(2.75, 5.75, 3.0).rotate_x(-90.0).translate([x, -2.75, z]));
}
leaf + web + knuckle + pin - fuse_all(holes)
