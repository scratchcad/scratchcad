// Mushroom head square neck carriage bolt DIN 603 M8 x 40: 20 mm domed head 4.4 mm tall, 8 mm square neck 5 mm deep, 22 mm of 1.25 mm pitch thread rings
let diameter = 8.0; // [5.0, 20.0] Nominal diameter (mm)
let length = 40.0; // [16.0, 150.0] Length under head (mm)
let thread_length = 22.0; // [10.0, 60.0] Thread length (mm)
let head_diameter = 20.0; // [12.0, 50.0] Head diameter (mm)
let head_height = 4.4; // [2.5, 12.0] Head height (mm)
const pitch = 1.25;
let r = diameter / 2.0;
let rm = r - 0.6134 * pitch;
let rk = max(head_diameter / 2.0, r * 1.8);
let neck = r;
let tl = min(thread_length, length - neck - 2.0);
let p = [[0.0, 0.0, 0.0], [rm, 0.0, 0.0]];
let z = 0.0;
while z + pitch < tl {
    p.push([r, 0.0, z + pitch * 0.4]);
    p.push([r, 0.0, z + pitch * 0.6]);
    p.push([rm, 0.0, z + pitch]);
    z += pitch;
}
p.push([r, 0.0, z + (r - rm)]);
p.push([r, 0.0, length - neck + 0.01]);
p.push([0.0, 0.0, length - neck + 0.01]);
let shank = polygon(p).to_face().revolve("Z", 360);
let square = box_centered(diameter, diameter, neck + 0.02).translate([0, 0, length - neck / 2.0]);
let hh = min(head_height, rk * 0.6);
let c = (rk * rk + 0.25 - hh * hh) / (2.0 * (0.5 - hh));
let rr = hh - c;
let am = (rk / rr).asin() / 2.0;
let head = sketch("XZ").move_to(0.0, length).hline_to(rk).vline(0.5).arc_to(rr * am.sin(), length + c + rr * am.cos(), 0.0, length + hh).close().to_face().revolve("Z", 360);
fuse_all([shank, square, head])
