// Canon EF body cap (RF-3 style): 63 mm ribbed disc 3.5 mm thick, 53.9 mm spigot with three unequal bayonet tabs (64, 53 and 42 deg) on a 59 mm circle, alignment dot
let disc_diameter = 63.0; // [56.0, 70.0] Cap diameter (mm)
let disc_thickness = 3.5; // [2.0, 6.0] Disc thickness (mm)
let spigot_diameter = 53.9; // [40.0, 60.0] Spigot diameter (mm)
let tab_diameter = 59.0; // [45.0, 64.0] Diameter over the tabs (mm)
let tab_thickness = 1.6; // [1.0, 2.5] Tab thickness (mm)
let rib_count = 36; // [0, 72] Number of grip ribs
let rd = disc_diameter / 2.0;
let rs = spigot_diameter / 2.0;
let disc = cylinder(rd, disc_thickness).fillet(1.0, "%CIRCLE and >Z");
let ribs = [];
for i in 0..rib_count {
    ribs.push(box_centered(1.2, 1.6, disc_thickness - 1.0).translate([rd, 0, disc_thickness / 2.0 - 0.3]).rotate_z(i.to_float() * 360.0 / rib_count.to_float()));
}
if rib_count > 0 { disc = disc - compound(ribs); }
// spigot below the disc, hollowed, carrying the bayonet tabs at its bottom
let spigot = cylinder([0, 0, -4.0], "Z", rs, 4.1) - cylinder([0, 0, -5.0], "Z", rs - 1.5, 4.5);
let tabs = [];
let starts = [0.0, 120.0, 240.0];
let spans = [64.0, 53.0, 42.0];
for k in 0..3 {
    let half = spans[k] / 2.0;
    let wedge = polygon([[0, 0], [40.0 * (-half * PI() / 180.0).cos(), 40.0 * (-half * PI() / 180.0).sin()], [40.0, 0], [40.0 * (half * PI() / 180.0).cos(), 40.0 * (half * PI() / 180.0).sin()]])
        .to_face().extrude(tab_thickness).translate([0, 0, -4.0]);
    tabs.push(wedge.rotate_z(starts[k]));
}
let tab_ring = cylinder([0, 0, -4.0], "Z", tab_diameter / 2.0, tab_thickness) - cylinder([0, 0, -5.0], "Z", rs - 0.5, 4.0);
let cap = disc + spigot + (tab_ring & fuse_all(tabs));
// raised alignment dot on the rim
cap + sphere([0, rd - 3.0, disc_thickness - 0.6], 1.2).rotate_z(30.0)
