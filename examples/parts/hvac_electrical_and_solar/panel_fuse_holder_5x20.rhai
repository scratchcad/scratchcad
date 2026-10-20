// Panel-mount 5 x 20 mm fuse holder: M12 x 0.75 body 30 mm long, 15 mm flange collar, 11 mm hex panel nut, 13 mm knurled bayonet cap with screwdriver slot, two solder tags
let body_d = 12.0; // [10.0, 16.0] Body thread diameter (mm)
let body_len = 30.0; // [20.0, 40.0] Body length behind the panel (mm)
let cap_d = 13.0; // [10.0, 18.0] Cap diameter (mm)
let panel = 2.0; // [0.5, 5.0] Panel thickness (mm)
const flange_d = 15.0;
let r = body_d / 2.0;
let body = cylinder([0, 0, -body_len], "Z", r, body_len) + cylinder(flange_d / 2.0, 1.5);
let grooves = [];
for i in 0..20 { grooves.push(torus(r + 0.2, 0.32).translate([0, 0, -panel - 1.0 - i.to_float() * 0.75])); }
body -= fuse_all(grooves) & cylinder([0, 0, -body_len + 6.0], "Z", r + 1.0, body_len - 6.0);
let rc = 15.0 / 2.0 / (30.0 * PI() / 180.0).cos();
let hp = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let nut = polygon(hp).to_face().extrude([0, 0, 3.0]).translate([0, 0, -panel - 3.0]) - cylinder([0, 0, -panel - 4.0], "Z", r - 0.3, 5.0);
let cap = cylinder([0, 0, 1.5], "Z", cap_d / 2.0, 10.0).fillet(1.0, ">Z");
let knurl = [];
for i in 0..18 { knurl.push(cylinder([cap_d / 2.0 + 0.1, 0, 2.5], "Z", 0.45, 10.0).rotate_z(i.to_float() * 20.0)); }
cap = cap - fuse_all(knurl) - box_centered(cap_d * 0.6, 1.2, 2.0).translate([0, 0, 11.5]);
let tags = [];
for x in [-1.0, 1.0] { tags.push(box_centered(3.0, 0.5, 8.0).translate([x * 3.0, 0, -body_len - 3.5]) - cylinder([x * 3.0, -1, -body_len - 5.0], "Y", 0.8, 2.0)); }
compound([fuse_all([body] + tags), nut, cap])
