// Oldham coupling, 33 mm OD: two 12 mm hubs with 10 mm bores and 8 mm tongues, and a 10 mm acetal centre disc with crossed 8.2 mm slots
let outer_diameter = 33.0; // [16.0, 60.0] Outer diameter (mm)
let hub_length = 12.0; // [6.0, 25.0] Hub length (mm)
let bore = 10.0; // [3.0, 20.0] Bore diameter (mm)
let disc_thickness = 10.0; // [6.0, 16.0] Centre disc thickness (mm)
let tongue_width = 8.0; // [3.0, 14.0] Tongue width (mm)
let r = outer_diameter / 2.0;
let tw = min(tongue_width, r * 0.8);
let depth = disc_thickness * 0.42;
let core = disc_thickness - 2.0 * depth;
let b = min(bore, r * 1.2);
let disc = cylinder(r, disc_thickness)
    - box_centered(tw + 0.2, outer_diameter + 2.0, depth * 2.0).translate([0, 0, disc_thickness])
    - box_centered(outer_diameter + 2.0, tw + 0.2, depth * 2.0);
disc = disc.translate([0, 0, -disc_thickness / 2.0]);
let hub = cylinder(r, hub_length) + box_centered(tw, outer_diameter, depth - 0.2).translate([0, 0, hub_length + (depth - 0.2) / 2.0 - 0.01]);
hub = hub & cylinder([0, 0, -1], "Z", r, hub_length + depth + 2.0);
hub = hub - cylinder([0, 0, -1], "Z", b / 2.0, hub_length + depth + 2.0) - cylinder([0, 0, hub_length / 2.0], "X", 1.6, r + 1.0);
let top = hub.mirror("XY").translate([0, 0, disc_thickness / 2.0 + hub_length + depth]).rotate("Z", 0.0);
let bottom = hub.rotate("Z", 90.0).translate([0, 0, -disc_thickness / 2.0 - hub_length - depth]);
print(`disc core ${core}`);
compound([bottom, disc, top])
