// Shower hose filter washer, 1/2 in BSP: 23 mm x 2.5 mm flat washer, 12 mm bore, domed 12 mm screen 3 mm high with 7 x 1.5 mm holes
let od = 23.0; // [18.0, 30.0] Washer outside diameter (mm)
let bore = 12.0; // [8.0, 16.0] Washer bore (mm)
let t = 2.5; // [1.5, 4.0] Washer thickness (mm)
let dome_h = 3.0; // [1.5, 5.0] Screen dome height (mm)
let hole_d = 1.5; // [0.8, 2.5] Screen hole diameter (mm)
let rb = bore / 2.0;
let rd = rb + 1.0;
let sr = (rd * rd + dome_h * dome_h) / (2.0 * dome_h);
let washer = cylinder(od / 2.0, t) - cylinder([0, 0, -1], "Z", rb, t + 2.0);
let dome = (sphere([0, 0, t + dome_h - sr], sr) - sphere([0, 0, t + dome_h - sr], sr - 0.8)) & cylinder([0, 0, t * 0.5], "Z", rd + 0.5, dome_h + t);
let holes = [cylinder([0, 0, 0], "Z", hole_d / 2.0, t + dome_h + 2.0)];
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    holes.push(cylinder([rb * 0.55 * a.cos(), rb * 0.55 * a.sin(), 0], "Z", hole_d / 2.0, t + dome_h + 2.0));
}
washer + dome - compound(holes)
