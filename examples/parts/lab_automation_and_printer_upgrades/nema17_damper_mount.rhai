// NEMA 17 stepper vibration damper: two 42 x 42 x 2 mm plates bonded to a 34 mm OD x 24 mm ID rubber ring 10 mm thick, 22.5 mm pilot holes, motor plate with 4 x M3 countersunk holes on the 31 mm square, frame plate with 4 x M3 holes on a 26 mm square
let plate = 42.0; // [40.0, 60.0] Plate size (mm)
let rubber_t = 10.0; // [5.0, 15.0] Rubber thickness (mm)
let rubber_od = 34.0; // [30.0, 35.0] Rubber outside diameter (mm)
let pilot = 22.5; // [16.0, 23.0] Pilot hole diameter (mm)
let frame_holes = 26.0; // [18.0, 30.0] Frame hole square (mm)
const t = 2.0;
const motor_holes = 31.0;
let ro = rubber_od / 2.0;
let pd = min(pilot, rubber_od - 6.0);
let motor_plate = box_centered(plate, plate, t).translate([0, 0, t / 2.0]).fillet(3.0, "|Z");
let frame_plate = motor_plate.translate([0, 0, t + rubber_t]);
let rubber = cylinder([0, 0, t - 0.5], "Z", ro, rubber_t + 1.0);
let damper = fuse_all([motor_plate, rubber, frame_plate]) - cylinder([0, 0, -1], "Z", pd / 2.0, 2.0 * t + rubber_t + 2.0);
let holes = [];
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        let m = motor_holes / 2.0;
        holes.push(cylinder([sx * m, sy * m, -1], "Z", 1.6, t + 2.0) + cone(3.0, 1.6, 1.4).translate([sx * m, sy * m, -0.01]));
        // frame holes on a smaller square, kept just outside the rubber
        let f = max(frame_holes / 2.0, (ro + 2.0) / 1.4142);
        holes.push(cylinder([sx * f, sy * f, t + rubber_t - 1.0], "Z", 1.6, t + 2.0));
    }
}
damper - fuse_all(holes)
