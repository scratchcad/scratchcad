// Faucet aerator, female M22 x 1: 24.5 mm housing 14 mm tall with a cut internal thread, 17 mm outlet with two hex screens (separate insert)
let housing_diameter = 24.5; // [24.0, 28.0] Housing diameter (mm)
let housing_height = 14.0; // [10.0, 20.0] Housing height (mm)
let outlet = 17.0; // [12.0, 19.0] Outlet diameter (mm)
let thread_length = 8.0; // [5.0, 10.0] Thread length (mm)
const major = 22.0;
const pitch = 1.0;
let r_maj = major / 2.0;
let r_min = r_maj - 0.54 * pitch;
let tan30 = (30.0 * PI() / 180.0).tan();
let R = housing_diameter / 2.0;
let H = housing_height;
let tl = min(thread_length, H - 4.0);
// housing: open at the top (z = H), lip at the bottom
let housing = cylinder(R, H) - cylinder([0, 0, H - tl], "Z", r_min, tl + 1.0) - cylinder([0, 0, 1.5], "Z", r_min - 0.8, H) - cylinder([0, 0, -1.0], "Z", outlet / 2.0, 3.0);
let w = pitch / 16.0 + (r_maj + 0.05 - (r_min - 0.05)) * tan30;
let section = polygon([[r_min - 0.5, 0, -w], [r_min - 0.05, 0, -w], [r_maj + 0.05, 0, -pitch / 16.0], [r_maj + 0.05, 0, pitch / 16.0], [r_min - 0.05, 0, w], [r_min - 0.5, 0, w]]);
let turns = (tl / pitch).ceiling().to_int() + 2;
let secs = [];
for i in 0..=(turns * 12) {
    let t = i.to_float() / 12.0;
    secs.push(section.rotate_z(t * 360.0).translate([0, 0, H - tl - pitch + t * pitch]));
}
housing -= loft(secs, true) & cylinder([0, 0, H - tl], "Z", r_maj + 1.0, tl + 1.0);
let flats = [];
for i in 0..12 {
    flats.push(box_centered(1.2, 2.0, H - 4.0).translate([R, 0, H / 2.0]).rotate_z(i.to_float() * 30.0));
}
housing -= compound(flats);
// screen insert sitting on the lip
let ri = r_min - 1.0;
let insert = cylinder([0, 0, 1.6], "Z", ri, 4.0) - cylinder([0, 0, 2.6], "Z", ri - 1.0, 4.0);
let holes = [];
const s = 1.8;
for i in -5..=5 {
    for j in -5..=5 {
        let x = i.to_float() * s + if j % 2 == 0 { 0.0 } else { s / 2.0 };
        let y = j.to_float() * s * 0.866;
        if x * x + y * y < (ri - 1.8) * (ri - 1.8) { holes.push(cylinder([x, y, 1.0], "Z", 0.6, 3.0)); }
    }
}
compound([housing, insert - compound(holes)])
