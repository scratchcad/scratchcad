// Hex flange nut DIN 6923 M8 with serrated bearing face: 13 mm across flats, 17.9 mm flange, 8 mm overall height, 24 radial serrations 0.3 mm deep
let diameter = 8.0; // [5.0, 20.0] Thread size (mm)
let across_flats = 13.0; // [8.0, 30.0] Across flats (mm)
let flange_diameter = 17.9; // [11.0, 42.0] Flange diameter (mm)
let height = 8.0; // [5.0, 20.0] Overall height (mm)
const serrations = 24;
let s = max(across_flats, diameter * 1.4);
let rf = max(flange_diameter / 2.0, s * 0.6);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let ft = height * 0.25;
let hex = polygon(hp).to_face().extrude(height - ft + 0.01).translate([0, 0, ft - 0.01]);
let rw = s * 0.95 / 2.0;
let dz = (rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, 0], [rc + 0.2, 0, 0], [rc + 0.2, 0, height - dz], [rw, 0, height], [0, 0, height]]).to_face().revolve("Z", 360);
let flange = polygon([[0, 0, 0], [rf, 0, 0], [rf, 0, ft * 0.4], [rc * 0.95, 0, ft + 0.3], [0, 0, ft + 0.3]]).to_face().revolve("Z", 360);
let nut = (hex & crown) + flange;
let teeth = [];
for i in 0..serrations {
    let a = i.to_float() * 360.0 / serrations.to_float();
    teeth.push(polygon([[0, 0, 0], [rf + 1.0, -0.6, 0], [rf + 1.0, 0.6, 0]]).to_face().extrude(0.3).translate([0, 0, -0.01]).rotate("Z", a));
}
nut = nut - compound(teeth);
let rm = diameter * 0.84 / 2.0;
nut - cylinder([0, 0, -1], "Z", rm, height + 2.0) - cone(diameter / 2.0 + 0.3, rm - 0.01, 0.8).translate([0, 0, -0.01]) - cone(rm - 0.01, diameter / 2.0 + 0.3, 0.8).translate([0, 0, height - 0.79])
