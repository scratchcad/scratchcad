// Washing machine (appliance) valve lever, 15 mm x 3/4 in: 42 mm tapered lever 4 mm thick, 12 mm hub 8 mm tall, 4 x 4 mm square drive bore, 2.5 mm retaining screw hole, finger dimple
let lever = 42.0; // [30.0, 60.0] Lever length (mm)
let root_w = 12.0; // [8.0, 16.0] Lever width at the hub (mm)
let tip_w = 16.0; // [10.0, 22.0] Lever width at the tip (mm)
let thick = 4.0; // [3.0, 6.0] Lever thickness (mm)
let hub_d = 12.0; // [10.0, 16.0] Hub diameter (mm)
let hub_h = 8.0; // [5.0, 12.0] Hub height (mm)
let drive = 4.0; // [3.0, 6.0] Square drive size (mm)
let hd = max(hub_d, drive * 1.42 + 4.0);
let hub = cylinder(hd / 2.0, hub_h);
let arm = polygon([[0, -root_w / 2.0, 0], [lever, -tip_w / 2.0, 0], [lever, tip_w / 2.0, 0], [0, root_w / 2.0, 0]]).to_face().extrude([0, 0, thick]).translate([0, 0, hub_h - thick]);
let arm = arm.fillet(min(tip_w * 0.3, 5.0), arm.edges("|Z and >X"));
let dimple = sphere([lever - tip_w * 0.45, 0, hub_h + 6.0], 7.0);
hub + arm - dimple - box_centered(drive, drive, (hub_h - 1.5) * 2.0) - cylinder([0, 0, hub_h - 3.0], "Z", 1.25, 5.0)
