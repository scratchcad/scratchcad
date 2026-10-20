// Wildlife escape ramp for a pond edge: 250 x 100 mm ribbed ramp 4 mm thick at 30 degrees with 10 cross ribs 3 mm tall and a 60 mm hook-over lip for a 40 mm edging stone
let length = 250.0; // [150.0, 400.0] Ramp length (mm)
let width = 100.0; // [60.0, 160.0] Ramp width (mm)
let ribs = 10; // [5, 20] Number of grip ribs
const t = 4.0;
let r = box_from_corners([0, 0, 0], [length, width, t]);
let rs = [];
for i in 0..ribs { rs.push(box_from_corners([10.0 + i.to_float() * (length - 20.0) / ribs.to_float(), 0, t - 0.01], [13.0 + i.to_float() * (length - 20.0) / ribs.to_float(), width, t + 3.0])); }
let ramp = (r + fuse_all(rs)).rotate_y(-30.0);
let top_x = length * cos(30.0 * PI() / 180.0);
let top_z = length * sin(30.0 * PI() / 180.0);
let lip = box_from_corners([top_x - 5.0, 0, top_z - 2.0], [top_x + 45.0, width, top_z + t - 2.0]) + box_from_corners([top_x + 41.0, 0, top_z - 60.0], [top_x + 45.0, width, top_z + t - 2.0]);
ramp + lip
