// Window squeegee channel end cap: push-in cap for a 22 x 10 mm squeegee channel, a 25 x 13 mm end plate 2.5 mm thick with 1 mm rounded corners, and a 10 mm plug 18.6 x 6.6 mm split by a 2 mm slot down the middle that grips the rubber blade
let channel_w = 22.0; // [14.0, 30.0] Channel width (mm)
let channel_h = 10.0; // [7.0, 16.0] Channel height (mm)
let plug_len = 10.0; // [5.0, 20.0] Plug length (mm)
let blade_slot = 2.0; // [1.0, 3.5] Blade slot width (mm)
const t = 2.5;
const wall = 1.2;
let pw = channel_w - 2.0 * wall - 1.0;
let ph = channel_h - 2.0 * wall - 1.0;
let plate = box_centered(channel_w + 3.0, channel_h + 3.0, t).translate([0, 0, t / 2.0]);
let plate = plate.fillet(1.0, plate.edges("|Z"));
let plug = box_centered(pw, ph, plug_len + 0.5).translate([0, 0, t + plug_len / 2.0 - 0.25]);
let plug = plug.chamfer(0.5, plug.edges(">Z"));
let bs = min(blade_slot, ph - 2.0);
(plate + plug) - box_from_corners([-pw / 2.0 - 1.0, -bs / 2.0, t + 1.0], [pw / 2.0 + 1.0, bs / 2.0, t + plug_len + 1.0])
