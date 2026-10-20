// Tea urn tap butterfly handle: 18 mm hub 20 mm tall with an 8 mm double-D spindle bore (6 mm across flats), two 22 mm wings 6 mm thick and a 3 mm M4 cap screw hole on top
let wing_span = 62.0; // [40.0, 80.0] Wing span (mm)
let spindle = 8.0; // [6.0, 10.0] Spindle diameter (mm)
let flats = 6.0; // [4.0, 6.0] Spindle across the flats (mm)
const hub_d = 18.0;
const hub_h = 20.0;
const wing_t = 6.0;
let wing = face(polygon([[0, -6.0, 0], [wing_span / 2.0, -11.0, 0], [wing_span / 2.0, 11.0, 0], [0, 6.0, 0]])).extrude([0, 0, 14.0]);
wing = wing.fillet(3.0, wing.edges("|Z and >X"));
let wings = wing + wing.rotate_z(180.0);
wings = wings.intersect(box_centered(wing_span + 2.0, 30.0, wing_t).translate([0, 0, hub_h - 7.0])) + (wings & box_centered(wing_span + 2.0, 3.0, 14.0).translate([0, 0, 7.0]));
let h = cylinder([0, 0, 0], "Z", hub_d / 2.0, hub_h) + wings;
let bore = cylinder([0, 0, -1.0], "Z", spindle / 2.0, 15.0) & box_centered(flats, spindle + 2.0, 40.0);
h - bore - cylinder([0, 0, 10.0], "Z", 2.0, hub_h)
