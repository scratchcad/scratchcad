// Fixed hacksaw frame for 300 mm blades: 12 x 20 mm swept bar, 100 mm throat, 12 mm blade with 0.6 mm thickness, pistol grip
let blade_len = 300.0; // [250.0, 330.0] Blade length (mm)
let throat = 100.0; // [70.0, 130.0] Throat depth (mm)
let prof = polygon([[-6, -10, 0], [6, -10, 0], [6, 10, 0], [-6, 10, 0]]);
let frame = prof.to_face().sweep(polyline([[0, 0, 0], [0, 0, throat], [blade_len, 0, throat], [blade_len, 0, 0]]));
let blade = box_from_corners([-5.0, -0.3, -12.0], [blade_len + 5.0, 0.3, 0.0]);
let pins = [cylinder([0, -6.0, -6.0], "Y", 2.5, 12.0), cylinder([blade_len, -6.0, -6.0], "Y", 2.5, 12.0)];
let grip = polygon([[-6, 0, 30], [-6, 0, 90], [-50, 0, 70], [-60, 0, 20], [-40, 0, 10]]).to_face().extrude([0, 24.0, 0]).translate([0, -12.0, 0]).fillet(5.0, "|Y");
fuse_all([frame, blade, grip] + pins)
