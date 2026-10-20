// Camera top handle grip for 100 mm mounting centres: 130 mm long bow, 26 mm wide, 30 mm hand clearance under a 22 mm deep grip bar with 6 mm chamfers along its top, 30 mm long feet with 1/4-20 clearance holes (6.5 mm) on 100 mm centres and 3 mm locating pin holes 15 mm off each
let centres = 100.0; // [70.0, 160.0] Mounting hole centres (mm)
let rise = 30.0; // [20.0, 50.0] Hand clearance (mm)
let width = 26.0; // [20.0, 34.0] Handle width (mm)
const bar = 22.0;
const foot = 30.0;
let a = centres / 2.0 + foot / 2.0;
let b = centres / 2.0 - foot / 2.0;
let h = rise + bar;
let side = polygon([
    [-a, 0, 0], [-b, 0, 0], [-b + 8.0, 0, rise], [b - 8.0, 0, rise], [b, 0, 0], [a, 0, 0],
    [a, 0, 12.0], [a - 16.0, 0, h], [-a + 16.0, 0, h], [-a, 0, 12.0]]);
let handle = face(side).extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let handle = handle.chamfer(6.0, handle.edges("|X and >Z"));
let cuts = [];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * centres / 2.0, 0, -1.0], "Z", 3.25, 16.0));
    cuts.push(cylinder([s * centres / 2.0, 0, 10.0], "Z", 6.0, h));
    cuts.push(cylinder([s * (centres / 2.0 - 15.0) , 0, -1.0], "Z", 1.5, 5.0));
}
handle - fuse_all(cuts)
