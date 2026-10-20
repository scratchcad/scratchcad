// Titanium camping spork: 170 mm long, 40 x 60 mm bowl 8 mm deep with three tines, 12 mm flat handle 1.6 mm thick with a lanyard hole
let length = 170.0; // [140.0, 230.0] Overall length (mm)
let bowl_width = 40.0; // [30.0, 55.0] Bowl width (mm)
let bowl_length = 60.0; // [45.0, 80.0] Bowl length (mm)
let thickness = 1.6; // [1.0, 2.5] Thickness (mm)
let handle_width = 12.0; // [8.0, 18.0] Handle width (mm)
let bw = bowl_width / 2.0;
let bl = bowl_length / 2.0;
let pts = [];
for i in 0..24 {
    let a = i.to_float() * 2.0 * PI() / 24.0;
    let k = if a.sin() > 0.0 { 1.0 } else { 0.85 };
    pts.push([bw * a.cos() * k, bl * a.sin(), 0]);
}
let outline = wire([spline(pts, true)]).to_face();
let R = (bw * bw + bl * bl) / 16.0;
let depth = R - (R * R - bl * bl).sqrt();
let outer = outline.extrude(depth + 2.0) & sphere([0, 0, R], R);
let inner = outline.extrude(depth + 4.0).translate([0, 0, thickness]) & sphere([0, 0, R + thickness], R);
let bowl = outer - inner;
let tines = [];
for x in [-0.25, 0.25] {
    tines.push(box_from_corners([x * bw - 1.0, bl * 0.55, -1.0], [x * bw + 1.0, bl + 2.0, depth + 3.0]));
}
bowl -= compound(tines);
let hl = length - bowl_length;
let zh = depth - thickness * 0.5;
let handle = box_from_corners([-handle_width / 2.0, -bl - hl, zh], [handle_width / 2.0, -bl + 4.0, zh + thickness]).fillet(handle_width * 0.45, "|Z and <Y");
handle -= cylinder([0, -bl - hl + handle_width * 0.5, zh - 1.0], "Z", 2.5, thickness + 2.0);
fuse_all([bowl, handle])
