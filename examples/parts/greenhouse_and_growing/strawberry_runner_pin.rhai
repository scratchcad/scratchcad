// Strawberry runner pin: U-pin that pegs a runner plantlet onto a 9 cm pot, 70 mm legs 3 mm square with barbed tips, 20 mm wide arched bridge 4 mm thick
// # Pin
let leg_length = 70.0; // [40.0, 100.0] Leg length (mm)
let span = 20.0; // [12.0, 30.0] Gap between legs (mm)
let leg = 3.0; // [2.0, 5.0] Leg section (mm)
let bridge_t = 4.0; // [3.0, 6.0] Bridge thickness (mm)
let barbs = 2; // [0, 4] Number of barbs per leg
let ri = span / 2.0;
let arch = (cylinder([0, -leg / 2.0, 0], "Y", ri + bridge_t, leg) - cylinder([0, -leg, 0], "Y", ri, leg * 2.0)) - box_from_corners([-ri * 2.0, -leg, -ri * 2.0], [ri * 2.0, leg, 0]);
let parts = [arch];
for s in [-1.0, 1.0] {
    let x0 = s * (ri + bridge_t / 2.0);
    let xin = x0 - leg / 2.0;
    parts.push(polygon("XZ", [[xin, 0.01], [xin + leg, 0.01], [xin + leg, -leg_length + 8.0], [x0, -leg_length], [xin, -leg_length + 8.0]]).to_face().extrude([0, leg, 0]).translate([0, -leg / 2.0, 0]));
    for i in 0..barbs {
        let z = -leg_length + 14.0 + i.to_float() * 12.0;
        let side = -s;
        let bx = x0 + side * leg / 2.0;
        parts.push(polygon("XZ", [[bx - side * 0.5, z + 4.0], [bx - side * 0.5, z], [bx + side * 1.5, z + 4.0]]).to_face().extrude([0, leg, 0]).translate([0, -leg / 2.0, 0]));
    }
}
fuse_all(parts)
