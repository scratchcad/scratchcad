// Regulation ice hockey puck: 76.2 mm (3 in) diameter, 25.4 mm (1 in) thick, knurled diamond band 13 mm tall around the edge with 48 grooves each way
let diameter = 76.2; // [60.0, 90.0] Diameter (mm)
let thickness = 25.4; // [18.0, 30.0] Thickness (mm)
let band = 13.0; // [6.0, 20.0] Knurl band height (mm)
let grooves = 48; // [24, 96] Number of knurl grooves
const depth = 0.8;
let r = diameter / 2.0;
let puck = cylinder(r, thickness);
let b = min(band, thickness - 4.0);
// two crossing sets of tilted grooves make the diamond knurl; neighbouring grooves overlap, so fuse each set
let set_a = [];
for i in 0..grooves {
    let a = i.to_float() * 360.0 / grooves.to_float();
    set_a.push(box_centered(1.0, 2.0 * depth, b * 1.6).rotate_y(30.0).translate([0, r, thickness / 2.0]).rotate_z(a));
}
let knurl_a = fuse_all(set_a);
let bandzone = cylinder([0, 0, (thickness - b) / 2.0], "Z", r + 1.0, b) - cylinder([0, 0, -1.0], "Z", r - 2.0, thickness + 2.0);
puck - (knurl_a & bandzone) - (knurl_a.mirror([0, 0, thickness / 2.0], [0, 0, 1]) & bandzone)
