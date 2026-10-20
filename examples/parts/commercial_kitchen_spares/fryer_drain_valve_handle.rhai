// Fryer drain valve lever handle: 110 mm tapered lever 14 mm thick, 24 mm boss with a 9.5 mm square drive socket for the ball valve stem and a 5 mm cross hole for the retaining pin
let length = 110.0; // [70.0, 150.0] Lever length (mm)
let drive = 9.5; // [6.0, 12.0] Square drive across flats (mm)
let thick = 14.0; // [10.0, 20.0] Lever thickness (mm)
const boss_d = 24.0;
let r = boss_d / 2.0;
let lever = face(polygon([[0, -r + 2.0, 0], [length, -8.0, 0], [length, 8.0, 0], [0, r - 2.0, 0]])).extrude([0, 0, thick * 0.6]);
lever = lever.fillet(4.0, lever.edges("|Z and >X"));
let h = lever + cylinder([0, 0, 0], "Z", r, thick);
h = h - box_centered(drive, drive, thick * 2.0).translate([0, 0, thick * 0.5 + 2.0]);
h - cylinder([-r - 1.0, 0, thick - 4.0], "X", 2.5, boss_d + 2.0) - cylinder([length - 10.0, 0, -1.0], "Z", 3.0, thick + 2.0)
