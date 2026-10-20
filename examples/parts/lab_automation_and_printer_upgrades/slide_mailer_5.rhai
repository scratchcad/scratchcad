// Microscope slide mailer for 5 slides 76 x 26 x 1 mm: 82 x 20.5 x 30 mm box, 1.5 mm walls, slides stand on edge in 5 grooves 1.4 mm wide at 3.5 mm pitch formed by ribs on both end walls, 3 mm lid step
let slides = 5; // [2, 10] Number of slides
let groove = 1.4; // [1.2, 2.0] Groove width (mm)
let pitch = 3.5; // [3.0, 6.0] Groove pitch (mm)
let height = 30.0; // [28.0, 40.0] Box height (mm)
const wall = 1.5;
const slide_l = 76.0;
const rib_d = 1.5;
let gw = min(groove, pitch - 0.8);
let inner_l = slide_l + 2.0 * rib_d + 1.0;
let inner_w = slides.to_float() * pitch;
let ol = inner_l + 2.0 * wall;
let ow = inner_w + 2.0 * wall;
let body = box_centered(ol, ow, height).translate([0, 0, height / 2.0]);
body = body.fillet(2.0, "|Z");
body = body - box_centered(inner_l, inner_w, height).translate([0, 0, height / 2.0 + wall]);
// a step around the top for the lid to sit over
body = body - (box_centered(ol + 2.0, ow + 2.0, 3.0).translate([0, 0, height - 1.5]) - box_centered(inner_l + wall, inner_w + wall, 4.0).translate([0, 0, height - 1.5]));
// ribs sit between the grooves; the end ones run into the side walls
let rib_h = height - wall - 4.0;
let ribs = [];
for i in 0..(slides + 1) {
    let y = (i.to_float() - slides.to_float() / 2.0) * pitch;
    for sx in [-1.0, 1.0] {
        ribs.push(box_centered(rib_d + 0.5, pitch - gw, rib_h + 0.5).translate([sx * (inner_l / 2.0 - rib_d / 2.0 + 0.25), y, wall + rib_h / 2.0 - 0.25]));
    }
}
body + (fuse_all(ribs) & box_centered(inner_l + 1.0, inner_w + wall, height * 2.0))
