// 15 A stage pin plug body: 2P&E stage pin connector 50 x 30 x 60 mm, three 7.9 mm (5/16 in) pin bores on 19 mm centers with the earth pin offset 3 mm, 12 mm cable entry, 2 mm grip ribs
let width = 50.0; // [40.0, 60.0] Body width (mm)
let depth = 30.0; // [25.0, 40.0] Body depth (mm)
let height = 60.0; // [45.0, 80.0] Body height (mm)
let pin = 7.9; // [6.0, 9.0] Pin bore diameter (mm)
let cable = 12.0; // [8.0, 16.0] Cable entry diameter (mm)
let body = box_centered(width, depth, height).translate([0, 0, height / 2.0]);
let b = body.fillet(4.0, body.edges("|Z"));
let bores = [];
for x in [-19.0, 0.0, 19.0] {
    let y = if x == 0.0 { 3.0 } else { 0.0 };
    bores.push(cylinder([x, y, -1.0], "Z", pin / 2.0, 25.0));
}
let cavity = box_centered(width - 8.0, depth - 8.0, height - 30.0).translate([0, 0, 22.0 + (height - 30.0) / 2.0]);
let entry = cylinder([0, 0, height - 10.0], "Z", cable / 2.0, 11.0);
let ribs = [];
for i in 0..6 { ribs.push(box_centered(width + 2.0, 2.0, 1.0).translate([0, depth / 2.0, height - 8.0 - i.to_float() * 4.0])); ribs.push(box_centered(width + 2.0, 2.0, 1.0).translate([0, -depth / 2.0, height - 8.0 - i.to_float() * 4.0])); }
b - fuse_all(bores) - cavity - entry - compound(ribs)
