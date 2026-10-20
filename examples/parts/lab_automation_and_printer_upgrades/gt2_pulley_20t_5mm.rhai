// GT2 timing pulley 20 teeth for a 6 mm belt on a 5 mm shaft: 12.22 mm tooth OD (12.73 mm pitch diameter), 7 mm toothed width between two 1 mm flanges 16 mm dia, 16 mm hub 7.5 mm long with an M3 grub screw hole
let teeth = 20; // [16, 40] Number of teeth
let bore = 5.0; // [3.0, 8.0] Bore diameter (mm)
let belt_w = 6.0; // [6.0, 10.0] Belt width (mm)
let hub_l = 7.5; // [5.0, 12.0] Hub length (mm)
const flange_t = 1.0;
let pd = teeth.to_float() * 2.0 / PI();
let r = pd / 2.0 - 0.254;
let tw = belt_w + 1.0;
let rf = r + 1.9;
// the hub matches the flanges unless the bore needs more wall
let rh = max(rf, bore / 2.0 + 3.0);
let grooves = [];
for k in 0..teeth {
    let a = k.to_float() * 2.0 * PI() / teeth.to_float();
    grooves.push(cylinder([(r - 0.15) * a.cos(), (r - 0.15) * a.sin(), -1.0], "Z", 0.6, tw + 2.0));
}
let toothed = cylinder(r, tw) - fuse_all(grooves);
let pulley = fuse_all([
    cylinder([0, 0, -hub_l], "Z", rh, hub_l),
    cylinder(rf, flange_t),
    toothed.translate([0, 0, flange_t]),
    cylinder([0, 0, flange_t + tw], "Z", rf, flange_t)]);
pulley = pulley - cylinder([0, 0, -hub_l - 1.0], "Z", bore / 2.0, hub_l + tw + 2.0 * flange_t + 2.0);
pulley - cylinder([0, 0, -hub_l / 2.0], "X", 1.5, rh + 1.0)
