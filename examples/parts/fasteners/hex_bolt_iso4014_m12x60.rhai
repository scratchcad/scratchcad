// Hex head bolt ISO 4014 M12 x 60, partly threaded: 18 mm across flats, 7.5 mm head with 30 deg chamfers, 30 mm thread length (1.75 mm pitch rings), plain 12 mm shank
let diameter = 12.0; // [5.0, 30.0] Nominal diameter (mm)
let length = 60.0; // [25.0, 200.0] Length under head (mm)
let thread_length = 30.0; // [10.0, 80.0] Thread length (mm)
let pitch = 1.75; // [0.8, 3.5] Thread pitch (mm)
let across_flats = 18.0; // [8.0, 46.0] Across flats (mm)
let head_height = 7.5; // [3.5, 19.0] Head height (mm)
let r = diameter / 2.0;
let rm = r - 0.6134 * pitch;
let s = max(across_flats, diameter * 1.4);
let tl = min(thread_length, length - 2.0);
let rings = (tl / pitch).floor().to_int();
let p = [[0.0, 0.0, 0.0], [rm, 0.0, 0.0]];
for i in 0..rings {
    let z = i.to_float() * pitch;
    p.push([r, 0.0, z + pitch * 0.4]);
    p.push([r, 0.0, z + pitch * 0.6]);
    p.push([rm, 0.0, z + pitch]);
}
p.push([r, 0.0, rings.to_float() * pitch + (r - rm)]);
p.push([r, 0.0, length + 0.01]);
p.push([0.0, 0.0, length + 0.01]);
let shank = polygon(p).to_face().revolve("Z", 360);
let rc = s / sqrt(3.0);
let hp = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    hp.push([rc * a.cos(), rc * a.sin()]);
}
let hex = polygon(hp).to_face().extrude(head_height).translate([0, 0, length]);
let rw = s * 0.95 / 2.0;
let dz = (rc + 0.2 - rw) * (30.0 * PI() / 180.0).tan();
let crown = polygon([[0, 0, length], [rw, 0, length], [rc + 0.2, 0, length + 0.5], [rc + 0.2, 0, length + head_height - dz], [rw, 0, length + head_height], [0, 0, length + head_height]]).to_face().revolve("Z", 360);
shank + (hex & crown)
