// NFT channel support cradle for 100 x 50 mm gully: a 4 mm U cradle 30 mm wide with 25 mm side walls and a 1.5 degree fall built into its floor, sitting on a 4 mm base 150 mm long with two 5 mm screw holes for the bench rail
let channel_w = 100.0; // [60.0, 150.0] Channel width (mm)
let wall_h = 25.0; // [15.0, 45.0] Side wall height (mm)
let width = 30.0; // [20.0, 50.0] Cradle width (mm)
let fall = 1.5; // [0.0, 3.0] Floor fall angle (degrees)
let base_len = 150.0; // [130.0, 220.0] Base length (mm)
const t = 4.0;
let iw = channel_w + 1.0;
let ow = iw + 2.0 * t;
let bl = max(base_len, ow + 30.0);
let rise = width * (fall * PI() / 180.0).tan();
let base = box_centered(bl, width, t).translate([0, 0, t / 2.0]);
let base = base.fillet(3.0, base.edges("|Z"));
let floor = face(polygon([[-ow / 2.0, 0, t - 0.5], [ow / 2.0, 0, t - 0.5], [ow / 2.0, 0, t + 2.0], [-ow / 2.0, 0, t + 2.0]])).extrude([0, width, 0]).translate([0, -width / 2.0, 0]);
let wedge = face(polygon([[0, -width / 2.0, t + 1.9], [0, width / 2.0, t + 1.9], [0, width / 2.0, t + 2.0 + rise + 0.05]])).extrude([iw, 0, 0]).translate([-iw / 2.0, 0, 0]);
let walls = [];
for s in [-1.0, 1.0] {
    walls.push(box_centered(t, width, wall_h + 2.0).translate([s * (iw / 2.0 + t / 2.0), 0, t + 2.0 + wall_h / 2.0 - 1.0]));
}
let body = fuse_all([base, floor, wedge] + walls);
let hx = (bl / 2.0 + ow / 2.0) / 2.0;
let cuts = [];
for s in [-1.0, 1.0] {
    cuts.push(cylinder([s * hx, 0, -1.0], "Z", 2.5, t + 2.0));
}
body - fuse_all(cuts)
