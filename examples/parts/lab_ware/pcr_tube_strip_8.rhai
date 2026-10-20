// 0.2 ml PCR 8-tube strip: tubes on a 9 mm pitch, 6 mm body 8 mm tall over a 12 mm conical tip, 0.4 mm wall, connecting web
let n = 8; // [2, 12] Tubes
const pitch = 9.0;
let outer = [];
let inner = [];
for i in 0..n {
    let x = i.to_float() * pitch;
    outer.push(cylinder([x, 0, 12.0], "Z", 3.0, 9.0) + cone(1.0, 3.0, 12.0).translate([x, 0, 0]) + cylinder([x, 0, 20.0], "Z", 3.6, 1.0));
    inner.push(cylinder([x, 0, 12.0], "Z", 2.6, 10.0) + cone(0.6, 2.6, 11.6).translate([x, 0, 0.4]));
}
let web = box_from_corners([0, -0.5, 20.0], [(n - 1).to_float() * pitch, 0.5, 21.0]);
fuse_all(outer + [web]) - fuse_all(inner)
