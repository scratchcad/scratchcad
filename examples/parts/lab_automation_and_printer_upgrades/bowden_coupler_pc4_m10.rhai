// Bowden tube coupler for two PC4-M10 push fittings: 17 mm hex body 26 mm long, M10 x 1 tapped sockets 9 mm deep (8.5 mm tap drill with a 1 mm lead-in chamfer) at both ends, 4.2 mm PTFE through bore, mounting groove for a 1.5 mm clip
let hex_af = 17.0; // [14.0, 22.0] Hex across flats (mm)
let length = 26.0; // [20.0, 40.0] Body length (mm)
let socket_depth = 9.0; // [6.0, 12.0] Socket depth (mm)
let bore = 4.2; // [2.0, 4.5] Through bore (mm)
const tap = 8.5;
let r = hex_af / 2.0 / (30.0 * PI() / 180.0).cos();
let pts = [];
for k in 0..6 {
    let a = (30.0 + k.to_float() * 60.0) * PI() / 180.0;
    pts.push([r * a.cos(), r * a.sin(), 0.0]);
}
let body = polygon(pts).to_face().extrude([0, 0, length]);
// chamfer the hex corners like bar stock: intersect with a double cone
body = body & (cone(hex_af / 2.0 - 0.5, r + 2.0, 2.5).translate([0, 0, 0]) + cylinder([0, 0, 2.5], "Z", r + 2.0, length - 5.0) + cone(r + 2.0, hex_af / 2.0 - 0.5, 2.5).translate([0, 0, length - 2.5]));
let sd = min(socket_depth, length / 2.0 - 2.0);
let cuts = fuse_all([
    cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0),
    cylinder([0, 0, -1], "Z", tap / 2.0, sd + 1.0),
    cylinder([0, 0, length - sd], "Z", tap / 2.0, sd + 1.0),
    cone(tap / 2.0 + 1.0, tap / 2.0, 1.0).translate([0, 0, -0.01]),
    cone(tap / 2.0, tap / 2.0 + 1.0, 1.0).translate([0, 0, length - 0.99])]);
let groove = cylinder([0, 0, length / 2.0 - 0.75], "Z", r + 1.0, 1.5) - cylinder([0, 0, length / 2.0 - 1.0], "Z", hex_af / 2.0 - 1.0, 2.0);
body - cuts - groove
