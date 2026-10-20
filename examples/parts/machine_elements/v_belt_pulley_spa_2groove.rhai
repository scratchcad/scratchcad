// SPA V-belt pulley, two grooves, 125 mm datum diameter: 38 deg grooves 11 mm wide at datum, 2.75 mm above and 11 mm below, 15 mm pitch, 35 mm face, 25 mm bore with 8 mm keyway
let datum_diameter = 125.0; // [90.0, 400.0] Datum diameter (mm)
let grooves = 2; // [1, 6] Number of grooves
let bore = 25.0; // [12.0, 60.0] Bore diameter (mm)
let hub_diameter = 48.0; // [25.0, 100.0] Hub diameter (mm)
const datum_width = 11.0;
const above = 2.75;
const below = 11.0;
const pitch = 15.0;
const edge = 10.0;
let angle = if datum_diameter <= 118.0 { 34.0 } else { 38.0 };
let t = (angle / 2.0 * PI() / 180.0).tan();
let rd = datum_diameter / 2.0;
let ro = rd + above;
let face = 2.0 * edge + (grooves - 1).to_float() * pitch;
let body = cylinder(ro, face);
let cuts = [];
for g in 0..grooves {
    let zc = edge + g.to_float() * pitch;
    let wt = datum_width / 2.0 + (above + 1.0) * t;
    let wb = datum_width / 2.0 - below * t;
    cuts.push(polygon([[rd - below, 0, zc - wb], [ro + 1.0, 0, zc - wt], [ro + 1.0, 0, zc + wt], [rd - below, 0, zc + wb]]).to_face().revolve("Z", 360));
}
body = body - compound(cuts);
let rh = min(max(hub_diameter / 2.0, bore / 2.0 + 5.0), rd - below - 6.0);
let web = face * 0.3;
let recess = cylinder([0, 0, -1], "Z", rd - below - 4.0, (face - web) / 2.0 + 1.0) - cylinder([0, 0, -2], "Z", rh, face + 4.0);
body = body - recess - recess.mirror([0, 0, face / 2.0], "Z");
body = body.chamfer(0.8, "%CIRCLE and (>Z or <Z)");
let key = box_from_corners([-4.0, 0, -1], [4.0, bore / 2.0 + 3.3, face + 1.0]);
body - fuse_all([cylinder([0, 0, -1], "Z", bore / 2.0, face + 2.0), key])
