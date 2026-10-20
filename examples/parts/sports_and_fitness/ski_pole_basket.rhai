// Powder ski pole basket: 100 mm disc 3 mm thick with six spoke windows, 16 mm hub 22 mm tall with a 9.5 mm bore for the pole tip, 10 degree dished cone
let diameter = 100.0; // [60.0, 130.0] Basket diameter (mm)
let disc_t = 3.0; // [2.0, 5.0] Disc thickness (mm)
let hub_d = 16.0; // [12.0, 22.0] Hub diameter (mm)
let hub_height = 22.0; // [12.0, 35.0] Hub height (mm)
let bore_d = 9.5; // [6.0, 12.0] Pole bore (mm)
let windows = 6; // [3, 10] Number of windows
const dish = 10.0;
let r = diameter / 2.0;
let drop = (r - hub_d / 2.0) * (dish * PI() / 180.0).tan();
let prof = [[hub_d / 2.0 - 0.5, drop], [r, 0.0], [r, disc_t], [hub_d / 2.0 - 0.5, drop + disc_t]];
let disc = polygon("XZ", prof).to_face().revolve("Z", 360);
let rim = cylinder(r, disc_t + 1.5) - cylinder([0, 0, -1.0], "Z", r - 3.0, disc_t + 4.0);
let hub = cylinder([0, 0, drop - 6.0], "Z", hub_d / 2.0, hub_height).chamfer(1.0, ">Z");
let basket = fuse_all([disc, rim, hub]);
let cuts = [];
for i in 0..windows {
    let a = (i.to_float() + 0.5) * 360.0 / windows.to_float();
    let win = sketch("XY").move_to(hub_d / 2.0 + 6.0, -2.0).line_to(r - 7.0, -(r - 7.0) * (PI() / windows.to_float()).tan() * 0.55)
        .line_to(r - 7.0, (r - 7.0) * (PI() / windows.to_float()).tan() * 0.55).line_to(hub_d / 2.0 + 6.0, 2.0).close();
    cuts.push(win.to_face().extrude([0, 0, drop + disc_t + 4.0]).translate([0, 0, -2.0]).rotate_z(a));
}
basket = basket - compound(cuts);
basket - cylinder([0, 0, drop - 4.0], "Z", bore_d / 2.0, hub_height)
