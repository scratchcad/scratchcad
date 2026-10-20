// EV Type 2 (IEC 62196-2) plug wall holster: 64 mm bore x 55 mm deep sleeve tilted 20 degrees down, 100 x 130 x 5 mm wall plate, 4 countersunk 5 mm screws, latch notch 14 mm, drain hole
let bore = 64.0; // [56.0, 72.0] Plug body diameter (mm)
let depth = 55.0; // [40.0, 80.0] Sleeve depth (mm)
let tilt = 20.0; // [0.0, 35.0] Downward tilt (degrees)
let wall = 3.0; // [2.0, 5.0] Sleeve wall (mm)
let notch = 14.0; // [8.0, 20.0] Latch notch width (mm)

const plate_w = 100.0;
const plate_h = 130.0;
const plate_t = 5.0;
const zc = 75.0;
let r_out = bore / 2.0 + wall;
let tr = tilt * PI() / 180.0;

let plate = box_from_corners([-plate_w / 2.0, 0, 0], [plate_w / 2.0, plate_t, plate_h]);
plate = plate.fillet(8.0, plate.edges("|Y"));

// sleeve along +Y, tilted down about X, trimmed at the wall
let keep = box_from_corners([-100, 0, -100], [100, 300, 300]);
let sleeve = cylinder([0, -40.0, 0], "Y", r_out, depth + 40.0).rotate_x(-tilt).translate([0, 0, zc]) & keep;
let l = depth * 0.8;
let rib_low = max(zc - r_out - 30.0, 6.0);
let rib = polygon([[-wall / 2.0, 1.0, rib_low], [-wall / 2.0, 1.0, zc], [-wall / 2.0, l, zc - l * tan(tr)]]).to_face().extrude([wall, 0, 0]);
let body = fuse_all([plate, sleeve, rib]);

let in_front = box_from_corners([-100, plate_t, -100], [100, 300, 300]);
let bore_cut = cylinder([0, -40.0, 0], "Y", bore / 2.0, depth + 60.0).rotate_x(-tilt).translate([0, 0, zc]) & in_front;
let notch_cut = box_from_corners([-notch / 2.0, depth - 18.0, 0], [notch / 2.0, depth + 5.0, r_out + 5.0]).rotate_x(-tilt).translate([0, 0, zc]);
body = body - bore_cut - notch_cut;

// drain hole at the bottom of the cup and screw holes
body = body - cylinder([0, -1.0, zc - bore / 2.0 + 6.0], "Y", 4.0, plate_t + 2.0);
let screws = [];
for x in [-40.0, 40.0] {
    for z in [12.0, plate_h - 12.0] {
        screws.push(cylinder([x, -1.0, z], "Y", 2.6, plate_t + 2.0));
        screws.push(cone(2.6, 5.4, 2.8).rotate_x(-90.0).translate([x, plate_t - 2.7, z]));
    }
}
body - fuse_all(screws)
