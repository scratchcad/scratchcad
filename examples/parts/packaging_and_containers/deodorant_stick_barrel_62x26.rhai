// Twist-up deodorant stick container: 62 x 26 mm oval barrel 80 mm tall with 1.5 mm walls and a 6 mm spindle hole in the floor, plus the elevator platform (0.3 mm clearance) with a 6 mm product-gripping rim and a 5 mm threaded boss
let barrel_length = 62.0; // [40.0, 80.0] Barrel length (mm)
let barrel_width = 26.0; // [18.0, 40.0] Barrel width (mm)
let height = 80.0; // [50.0, 120.0] Barrel height (mm)
let wall = 1.5; // [1.0, 2.5] Wall thickness (mm)
let spindle = 6.0; // [4.0, 10.0] Spindle hole diameter (mm)
let w = min(barrel_width, barrel_length - 2.0);
fn stadium(l, w, z) {
    face(rect(l - w, 0.01).offset(w / 2.0)).translate([0, 0, z])
}
let barrel = stadium(barrel_length, w, 0).extrude([0, 0, height]) - stadium(barrel_length - 2.0 * wall, w - 2.0 * wall, 2.0).extrude([0, 0, height]);
barrel = barrel - cylinder([0, 0, -1], "Z", spindle / 2.0, 4.0);
// elevator, shown 20 mm up inside the barrel
let li = barrel_length - 2.0 * wall - 0.6;
let wi = w - 2.0 * wall - 0.6;
let plate = stadium(li, wi, 20.0).extrude([0, 0, 1.5]);
let rim = stadium(li, wi, 21.4).extrude([0, 0, 6.0]) - stadium(li - 2.4, wi - 2.4, 21.0).extrude([0, 0, 7.0]);
let boss = cylinder([0, 0, 21.4], "Z", 4.5, 8.0) - cylinder([0, 0, 19.0], "Z", 2.5, 12.0);
let elevator = fuse_all([plate, rim, boss]) - cylinder([0, 0, 19.0], "Z", 2.5, 12.0);
[barrel, elevator]
