// Crank puller forcing screw: M14 x 1.25 shank (plain 14 mm cylinder) 55 mm long, 19 mm across flats hex head 10 mm high with a 1 mm chamfer, 12 mm diameter push tip 4 mm long for square-taper spindles
let shank_len = 55.0; // [40.0, 80.0] Shank length (mm)
let shank_d = 14.0; // [12.0, 16.0] Shank diameter (mm)
let head_af = 19.0; // [17.0, 24.0] Head across flats (mm)
let tip_d = 12.0; // [8.0, 12.0] Push tip diameter (mm)
const head_h = 10.0;
const tip_len = 4.0;
let r = head_af / sqrt(3.0);
let pts = [];
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    pts.push([r * cos(a), r * sin(a), 0.0]);
}
let head = polygon(pts).to_face().extrude([0, 0, head_h]);
let head = head & cylinder([0, 0, 0], "Z", r, head_h).chamfer(r - head_af / 2.0 + 0.8, ">Z or <Z");
let shank = cylinder([0, 0, head_h - 0.5], "Z", shank_d / 2.0, shank_len + 0.5);
let tip = cylinder([0, 0, head_h + shank_len - 0.5], "Z", tip_d / 2.0, tip_len + 0.5);
let tip = tip.chamfer(0.8, tip.edges(">Z"));
fuse_all([head, shank, tip])
