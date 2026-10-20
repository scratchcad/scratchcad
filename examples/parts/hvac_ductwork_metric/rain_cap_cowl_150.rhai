// Chinese-hat rain cap for a 150 mm flue duct: 149 mm OD collar 60 mm long 1.5 mm wall, 250 mm conical hat 3 mm thick rising 45 mm, held 50 mm above the collar on 3 flat legs 2 x 20 mm
let collar_d = 149.0; // [100.0, 250.0] Collar outside diameter (mm)
let collar_l = 60.0; // [40.0, 100.0] Collar length (mm)
let hat_extra = 50.0; // [30.0, 80.0] Hat overhang beyond the collar (mm)
let hat_rise = 45.0; // [25.0, 80.0] Hat rise (mm)
let gap = 50.0; // [30.0, 90.0] Gap from collar top to hat rim (mm)
const wall = 1.5;
const hat_t = 3.0;
let rc = collar_d / 2.0;
let rh = rc + hat_extra;
let collar = cylinder(rc, collar_l) - cylinder([0, 0, -1], "Z", rc - wall, collar_l + 2.0);
let zh = collar_l + gap;
let hat = cone(rh, 6.0, hat_rise).translate([0, 0, zh]) - cone(rh, 6.0, hat_rise).translate([0, 0, zh - hat_t]);
// the underside of the hat at radius r sits at zh - hat_t + hat_rise * (rh - r) / (rh - 6)
let r_out = rc + 4.0;
let leg_top = zh - hat_t + hat_rise * (rh - r_out) / (rh - 6.0) + hat_t * 0.5;
let legs = [];
for k in 0..3 {
    legs.push(box_from_corners([rc - 1.0, -10.0, collar_l - 20.0], [r_out, 10.0, leg_top]).rotate_z(k.to_float() * 120.0));
}
fuse_all([collar, hat] + legs)
