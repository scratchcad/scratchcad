// Drip line end closure: sleeve-type end stop for 16 mm drip line folded back on itself, oval collar 20 mm long with 2.5 mm wall and a 25.6 x 12.8 mm opening that squeezes the doubled pipe shut, 6 grip ribs
// # Pipe
let pipe_od = 16.0; // [12.0, 20.0] Pipe outside diameter (mm)
let length = 20.0; // [14.0, 30.0] Collar length (mm)
let wall = 2.5; // [2.0, 4.0] Wall thickness (mm)
// # Detail
let grip_ribs = 3; // [0, 5] Number of grip ribs per side
let iw = 2.0 * pipe_od * 0.8;
let ih = pipe_od * 0.8;
let ow = iw + 2.0 * wall;
let oh = ih + 2.0 * wall;
let collar = box_centered(ow, oh, length).translate([0, 0, length / 2.0]).fillet(oh / 2.0 - 0.5, "|Z");
let hole = box_centered(iw, ih, length + 2.0).translate([0, 0, length / 2.0]).fillet(ih / 2.0 - 0.5, "|Z");
let flat = ow - oh - 2.0;
let rs = [];
for s in [-1.0, 1.0] {
    for i in 0..grip_ribs {
        let x = if grip_ribs > 1 { -flat / 2.0 + i.to_float() * flat / (grip_ribs - 1).to_float() } else { 0.0 };
        rs.push(box_centered(1.2, 1.2, length - 4.0).translate([x, s * (oh / 2.0 + 0.3), length / 2.0]));
    }
}
let body = collar - hole;
if grip_ribs > 0 { body + fuse_all(rs) } else { body }
