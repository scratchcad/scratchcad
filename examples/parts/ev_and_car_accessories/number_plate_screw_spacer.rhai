// Number plate standoff spacer for a curved bumper: 22 mm ribbed spacer 12 mm tall with a 5.2 mm hole for a No.10 plate screw, 8 mm locating spigot into the plate hole, 4 stiffening ribs
let height = 12.0; // [5.0, 25.0] Standoff height (mm)
let outer_d = 22.0; // [16.0, 30.0] Outer diameter (mm)
let hole = 5.2; // [4.0, 5.5] Screw hole (mm)
let spigot_d = 8.0; // [7.0, 10.0] Spigot diameter (mm)
let ribs = 4; // [3, 8] Number of ribs

const spigot_h = 2.0;
const shell = 1.6;
let r = outer_d / 2.0;
let body = cylinder(r, height) - cylinder([0, 0, -1.0], "Z", r - shell, height - 1.0);
let core = cylinder([0, 0, 0], "Z", hole / 2.0 + 2.0, height);
let rs = [];
for i in 0..ribs {
    rs.push(box_from_corners([hole / 2.0 + 1.0, -0.8, 0], [r - shell + 0.5, 0.8, height - 0.5]).rotate_z(i * 360.0 / ribs));
}
let spigot = cylinder([0, 0, height - 0.5], "Z", spigot_d / 2.0, spigot_h + 0.5);
let spacer = fuse_all([body, core, fuse_all(rs), spigot]);
spacer = spacer.chamfer(0.5, spacer.edges(">Z"));
spacer - cylinder([0, 0, -1.0], "Z", hole / 2.0, height + spigot_h + 2.0)
