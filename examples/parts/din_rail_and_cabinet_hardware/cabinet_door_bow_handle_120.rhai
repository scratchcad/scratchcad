// Bow pull handle for a cabinet door: 120 mm screw centres, 20 mm wide, 32 mm clearance behind the grip, 10 mm thick grip bar, 14 mm feet with M5 tapped holes (4.2 mm) 12 mm deep and 1.5 mm chamfered edges
let centres = 120.0; // [64.0, 200.0] Screw centres (mm)
let clearance = 32.0; // [22.0, 45.0] Hand clearance (mm)
let width = 20.0; // [14.0, 26.0] Handle width (mm)
const bar = 10.0;
const foot = 14.0;
let a = centres / 2.0 + foot / 2.0;
let b = centres / 2.0 - foot / 2.0;
let h = clearance + bar;
let side = polygon([
    [-a, 0, 0], [-b, 0, 0], [-b + 6.0, 0, clearance], [b - 6.0, 0, clearance], [b, 0, 0], [a, 0, 0],
    [a - 4.0, 0, h], [-a + 4.0, 0, h]]);
let handle = face(side).extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let handle = handle.chamfer(1.5, handle.edges("|Y and (>Z or (not <Z and not >Z))"));
let taps = cylinder([-centres / 2.0, 0, -1.0], "Z", 2.1, 13.0) + cylinder([centres / 2.0, 0, -1.0], "Z", 2.1, 13.0);
handle - taps
