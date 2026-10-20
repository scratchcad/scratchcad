// Cross-recessed pan head screw ISO 7045 M4 x 10, type H No. 2: 8 mm head 3.1 mm tall with rounded top, cross recess 4.6 mm across with 1.0 mm wings, plain shank
let diameter = 4.0; // [2.0, 10.0] Nominal diameter (mm)
let length = 10.0; // [3.0, 60.0] Length under head (mm)
let head_diameter = 8.0; // [4.0, 20.0] Head diameter (mm)
let head_height = 3.1; // [1.3, 7.5] Head height (mm)
let recess_width = 4.6; // [1.9, 10.0] Cross recess span (mm)
let r = diameter / 2.0;
let rk = max(head_diameter / 2.0, r + 1.0);
let hh = min(head_height, rk);
let x1 = rk * 0.93;
let y1 = hh * 0.65;
let c = (hh * hh - x1 * x1 - y1 * y1) / (2.0 * (hh - y1));
let rr = hh - c;
let am = (x1 / rr).asin() / 2.0;
let head = sketch("XZ").move_to(0.0, length).hline_to(rk).line_to(x1, length + y1).arc_to(rr * am.sin(), length + c + rr * am.cos(), 0.0, length + hh).close().to_face().revolve("Z", 360);
let screw = cylinder(r, length + 0.01).chamfer(min(0.4, r * 0.3), "<Z") + head;
let rw = min(recess_width, rk * 1.3);
let wing = rw * 0.22;
let ztop = length + hh;
let depth = hh * 0.7;
let cross = fuse_all([box_centered(rw, wing, depth * 2.0).translate([0, 0, ztop]), box_centered(wing, rw, depth * 2.0).translate([0, 0, ztop]), cone(0.0, rw * 0.35, depth).translate([0, 0, ztop - depth + 0.01])]);
screw - cross
