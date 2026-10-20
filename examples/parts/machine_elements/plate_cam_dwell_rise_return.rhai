// Plate cam, 50 mm base circle: 10 mm cycloidal rise over 120 deg, 60 deg dwell, 120 deg return, 60 deg dwell; 12 mm thick, 32 mm hub, 12 mm bore with 4 mm keyway
let base_diameter = 50.0; // [20.0, 120.0] Base circle diameter (mm)
let lift = 10.0; // [2.0, 30.0] Lift (mm)
let rise_angle = 120.0; // [60.0, 160.0] Rise angle (degrees)
let dwell_angle = 60.0; // [0.0, 90.0] High dwell angle (degrees)
let return_angle = 120.0; // [60.0, 160.0] Return angle (degrees)
let thickness = 12.0; // [5.0, 30.0] Cam thickness (mm)
let bore = 12.0; // [5.0, 25.0] Bore diameter (mm)
const steps = 120;
let rb = base_diameter / 2.0;
let pts = [];
for i in 0..steps {
    let th = i.to_float() * 360.0 / steps.to_float();
    let s = 0.0;
    if th < rise_angle {
        let u = th / rise_angle;
        s = lift * (u - (2.0 * PI() * u).sin() / (2.0 * PI()));
    } else if th < rise_angle + dwell_angle {
        s = lift;
    } else if th < rise_angle + dwell_angle + return_angle {
        let u = (th - rise_angle - dwell_angle) / return_angle;
        s = lift * (1.0 - (u - (2.0 * PI() * u).sin() / (2.0 * PI())));
    }
    let a = th * PI() / 180.0;
    pts.push([(rb + s) * a.cos(), (rb + s) * a.sin()]);
}
let cam = face(wire([spline(pts, true)])).extrude(thickness);
let rh = min(16.0, rb - 2.0);
let hub = cylinder([0, 0, thickness - 0.01], "Z", max(rh, bore / 2.0 + 3.0), 8.0);
cam = cam + hub;
let key = box_from_corners([-2.0, 0, -1], [2.0, bore / 2.0 + 1.8, thickness + 10.0]);
cam - fuse_all([cylinder([0, 0, -1], "Z", bore / 2.0, thickness + 10.0), key])
