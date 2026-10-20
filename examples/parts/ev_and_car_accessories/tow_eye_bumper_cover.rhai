// Front bumper tow eye cover: 62 x 40 mm stadium flap 2.5 mm thick for a 56 x 34 mm opening, 7 mm locating rim 1.5 mm wall, 2 barbed spring clips 0.8 mm, tether hinge tab
let length = 62.0; // [50.0, 80.0] Cover length (mm)
let height = 40.0; // [30.0, 50.0] Cover height (mm)
let overlap = 3.0; // [2.0, 5.0] Overlap past the opening (mm)
let rim = 7.0; // [4.0, 10.0] Rim depth (mm)
let barb = 0.8; // [0.4, 1.2] Clip barb (mm)

const t = 2.5;
const rim_wall = 1.5;
let stadium = |l, h, z0, hz| {
    let r = h / 2.0;
    let a = l / 2.0 - r;
    sketch("XY").move_to(-a, -r).hline(2.0 * a).arc_to(a + r, 0, a, r).hline(-2.0 * a).arc_to(-a - r, 0, -a, -r).close().to_face().extrude([0, 0, hz]).translate([0, 0, z0])
};
let flap = stadium.call(length, height, 0.0, t);
flap = flap.chamfer(0.8, flap.edges("<Z"));
let ol = length - 2.0 * overlap - 0.6;
let oh = height - 2.0 * overlap - 0.6;
let rim_s = stadium.call(ol, oh, t - 0.5, rim + 0.5) - stadium.call(ol - 2.0 * rim_wall, oh - 2.0 * rim_wall, t, rim + 1.0);
// split the rim at the ends into spring clips with barbs
let gaps = [];
let clips = [];
for s in [-1.0, 1.0] {
    for y in [-6.0, 6.0] {
        gaps.push(box_centered(rim_wall * 4.0, 1.2, rim + 1.0).translate([s * (ol / 2.0 - rim_wall), y, t + rim / 2.0 + 0.5]));
    }
    clips.push(polygon([[s * (ol / 2.0 - 1.2), -4.0, t + rim - 3.5], [s * (ol / 2.0 + barb), -4.0, t + rim - 2.5], [s * (ol / 2.0 - 1.2), -4.0, t + rim - 0.5]]).to_face().extrude([0, 8.0, 0]));
}
rim_s = rim_s - fuse_all(gaps);
let hinge = box_from_corners([-8.0, height / 2.0 - 2.0, 0], [8.0, height / 2.0 + 8.0, 1.2]);
hinge = hinge.fillet(4.0, hinge.edges("|Z and >Y")) - cylinder([0, height / 2.0 + 4.0, -1.0], "Z", 2.0, 4.0);
fuse_all([flap, rim_s, compound(clips), hinge])
