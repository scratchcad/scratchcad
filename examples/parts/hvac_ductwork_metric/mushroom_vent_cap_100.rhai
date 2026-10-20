// Mushroom vent cap for 100 mm pipe: 99 mm OD spigot 50 mm with 2 mm wall, 150 mm domed cap 3 mm thick rising 20 mm, held 25 mm above the spigot rim on 4 posts 8 mm square
let spigot_d = 99.0; // [50.0, 160.0] Spigot outside diameter (mm)
let spigot_l = 50.0; // [30.0, 100.0] Spigot length (mm)
let cap_extra = 25.5; // [15.0, 50.0] Cap overhang beyond the spigot (mm)
let rise = 20.0; // [10.0, 35.0] Dome rise (mm)
let gap = 25.0; // [15.0, 50.0] Air gap under the cap (mm)
const wall = 2.0;
const cap_t = 3.0;
let rs = spigot_d / 2.0;
let rc = rs + cap_extra;
// sphere through the rim circle (radius rc) and the crown (rise above the rim)
let rr = (rc * rc + rise * rise) / (2.0 * rise);
let z_rim = spigot_l + gap;
let zc = z_rim + rise - rr;
let dome = (sphere([0, 0, zc], rr) - sphere([0, 0, zc - cap_t], rr)) & cylinder([0, 0, z_rim - cap_t], "Z", rc, rise + cap_t + 1.0);
let spigot = cylinder(rs, spigot_l) - cylinder([0, 0, -1], "Z", rs - wall, spigot_l + 2.0);
let posts = [];
let rp = rs - wall / 2.0;
// underside of the cap at the post's outer edge
let ro = rp + 4.0;
let top = zc - cap_t + (rr * rr - ro * ro).sqrt() + cap_t * 0.5;
for k in 0..4 {
    posts.push(box_centered(8.0, 8.0, top - spigot_l + 5.0).translate([rp, 0, (top + spigot_l - 5.0) / 2.0]).rotate_z(45.0 + k.to_float() * 90.0));
}
fuse_all([spigot, dome] + posts)
