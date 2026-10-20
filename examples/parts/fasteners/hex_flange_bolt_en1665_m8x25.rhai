// Hex flange bolt EN 1665 M8 x 25: 13 mm across flats, 17.5 mm flange, 8.5 mm overall head height with 1.6 mm flange, plain shank with 0.8 mm tip chamfer
let diameter = 8.0; // [5.0, 20.0] Nominal diameter (mm)
let length = 25.0; // [10.0, 120.0] Length under head (mm)
let across_flats = 13.0; // [8.0, 30.0] Across flats (mm)
let flange_diameter = 17.5; // [10.0, 42.0] Flange diameter (mm)
let head_height = 8.5; // [5.0, 20.0] Head height (mm)
let r = diameter / 2.0;
let s = max(across_flats, diameter * 1.3);
let rf = max(flange_diameter / 2.0, s * 0.6);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let ft = head_height * 0.19;
let hex = polygon(hp).to_face().extrude(head_height - ft).translate([0, 0, length + ft - 0.01]);
let rw = s * 0.95 / 2.0;
let dz = (rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, length], [rc + 0.2, 0, length], [rc + 0.2, 0, length + head_height - dz], [rw, 0, length + head_height], [0, 0, length + head_height]]).to_face().revolve("Z", 360);
let flange = polygon([[0, 0, length], [rf, 0, length], [rf, 0, length + ft * 0.5], [rc * 0.95, 0, length + ft + 0.4], [0, 0, length + ft + 0.4]]).to_face().revolve("Z", 360);
let shank = cylinder(r, length + 0.01).chamfer(min(0.8, r * 0.25), "<Z");
fuse_all([shank, hex & crown, flange])
