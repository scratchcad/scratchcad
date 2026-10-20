// Hex bolt ISO 4017 M16 x 40 with a modelled helical thread: 24 mm across flats, 10 mm head, 2 mm pitch 60 deg thread lofted along 30 mm of the shank, 13.55 mm core
let diameter = 16.0; // [8.0, 30.0] Nominal diameter (mm)
let length = 40.0; // [20.0, 100.0] Length under head (mm)
let thread_length = 30.0; // [10.0, 80.0] Thread length (mm)
let pitch = 2.0; // [1.0, 3.5] Thread pitch (mm)
let across_flats = 24.0; // [13.0, 46.0] Across flats (mm)
let head_height = 10.0; // [5.0, 19.0] Head height (mm)
const per_turn = 16;
let r = diameter / 2.0;
let h = 0.6134 * pitch;
let rm = r - h;
let tl = min(thread_length, length - 2.0);
let turns = ((tl - pitch) / pitch).floor().to_int();
let core = cylinder(rm + 0.02, length + 0.01).chamfer(0.5, "<Z");
let sections = [];
for i in 0..=(turns * per_turn) {
    let u = i.to_float() / per_turn.to_float();
    let z = pitch * 0.5 + u * pitch;
    let tri = polygon([[rm - 0.1, 0, z - pitch * 0.42], [r, 0, z - pitch * 0.06], [r, 0, z + pitch * 0.06], [rm - 0.1, 0, z + pitch * 0.42]]);
    sections.push(tri.rotate("Z", u * 360.0));
}
let ridge = loft(sections, true);
let rc = across_flats / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let hex = polygon(hp).to_face().extrude(head_height).translate([0, 0, length]);
let rw = across_flats * 0.95 / 2.0;
let dz = (rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, length], [rc + 0.2, 0, length], [rc + 0.2, 0, length + head_height - dz], [rw, 0, length + head_height], [0, 0, length + head_height]]).to_face().revolve("Z", 360);
let shank = cylinder([0, 0, tl], "Z", r, length - tl + 0.01);
fuse_all([core, ridge, shank, hex & crown])
