// Touch-protection shroud for a pin-type comb busbar, 12 modules: 12 x 17.8 mm long, 11 mm wide 9 mm tall U cover in 1.2 mm PC with closed ends and a 4 x 2.5 mm pin window per module on 17.8 mm pitch
let modules = 12; // [2, 24] Number of modules
let width = 11.0; // [8.0, 16.0] Shroud width (mm)
let height = 9.0; // [6.0, 14.0] Shroud height (mm)
const pitch = 17.8;
const wall = 1.2;
let length = modules.to_float() * pitch;
let outer = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]);
let inner = box_from_corners([wall, -width / 2.0 + wall, -1.0], [length - wall, width / 2.0 - wall, height - wall]);
let windows = [];
for i in 0..modules {
    let x = pitch * (i.to_float() + 0.5);
    windows.push(box_centered(4.0, 2.5, 2.0 * wall).translate([x, width / 2.0 - wall - 1.75, height - wall / 2.0]));
}
outer - inner - fuse_all(windows)
