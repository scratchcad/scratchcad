// 150 mm round duct end cap: 151 mm ID socket 30 mm deep, 1.5 mm wall, 3 mm end plate with a cross of 4 mm stiffening ribs, 1.5 mm internal stop bead 8 mm in
let duct_d = 151.0; // [80.0, 250.0] Socket inside diameter (mm)
let depth = 30.0; // [15.0, 60.0] Socket depth (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let plate_t = 3.0; // [2.0, 6.0] End plate thickness (mm)
let rib_h = 4.0; // [0.0, 10.0] Stiffening rib height (mm)
let r = duct_d / 2.0;
let cap = cylinder(r + wall, depth + plate_t) - cylinder([0, 0, plate_t], "Z", r, depth + 1.0);
let bead = cylinder([0, 0, plate_t + 7.0], "Z", r + 0.5, 1.5) - cylinder([0, 0, plate_t + 6.0], "Z", r - 1.5, 4.0);
cap = cap + bead;
if rib_h > 0.1 {
    let ribs = fuse_all([box_centered(duct_d, 3.0, rib_h + 0.5), box_centered(3.0, duct_d, rib_h + 0.5)]).translate([0, 0, -rib_h / 2.0 + 0.25]);
    cap = cap + (ribs & cylinder([0, 0, -rib_h - 1.0], "Z", r - 10.0, rib_h + 2.0));
}
cap
