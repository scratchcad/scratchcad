// IV stand five-leg base hub: 70 mm hub 55 mm tall with a 25.4 mm pole socket 40 mm deep and five arms (36 mm diameter) sloping down 8 degrees with 25.4 mm sockets 40 mm deep for the leg tubes
let pole_d = 25.4; // [19.0, 28.0] Pole tube diameter (mm)
let leg_d = 25.4; // [19.0, 28.0] Leg tube diameter (mm)
let legs = 5; // [4, 6] Number of legs
let slope = 8.0; // [0.0, 15.0] Leg slope (degrees)
const hub_d = 70.0;
const hub_h = 55.0;
const arm_l = 80.0;
let solids = [cylinder([0, 0, 0], "Z", hub_d / 2.0, hub_h)];
let cuts = [cylinder([0, 0, hub_h - 40.0], "Z", pole_d / 2.0 + 0.2, 41.0)];
for i in 0..legs {
    let a = i.to_float() * 360.0 / legs.to_float();
    solids.push(cylinder([0, 0, 0], "X", leg_d / 2.0 + 5.0, arm_l).rotate_y(slope).translate([0, 0, 18.0]).rotate_z(a));
    cuts.push(cylinder([arm_l - 40.0, 0, 0], "X", leg_d / 2.0 + 0.2, 41.0).rotate_y(slope).translate([0, 0, 18.0]).rotate_z(a));
}
fuse_all(solids) - fuse_all(cuts)
