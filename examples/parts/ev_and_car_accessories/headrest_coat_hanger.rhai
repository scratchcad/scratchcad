// Car headrest coat hanger: 380 mm shoulder frame 8 mm thick, 180 mm crossbar with two snap clips for 14 mm headrest posts at 150 mm centres, 11 mm clip mouth
let shoulders = 380.0; // [300.0, 440.0] Shoulder width (mm)
let post_d = 14.0; // [12.0, 16.0] Headrest post diameter (mm)
let post_spacing = 150.0; // [120.0, 180.0] Post spacing (mm)
let thickness = 8.0; // [6.0, 10.0] Frame thickness (mm)
let drop = 70.0; // [50.0, 90.0] Shoulder drop to the neck (mm)

const neck = 12.0;
const bar_h = 10.0;
let half = shoulders / 2.0;
let top = drop + 30.0;
let outline = polygon([[-half, 0, 0], [half, 0, 0], [half, 0, 10.0], [neck, 0, drop], [neck, 0, top], [-neck, 0, top], [-neck, 0, drop], [-half, 0, 10.0]]);
let frame = outline.to_face().extrude([0, thickness, 0]);
let slope = (drop - 10.0) / (half - neck);
let ix = half - 25.0;
let window = polygon([[-ix, 0, 8.0], [ix, 0, 8.0], [0, 0, drop - 10.0 - neck * slope - 9.0]]).to_face().extrude([0, thickness + 2.0, 0]).translate([0, -1.0, 0]);
frame = frame - window;
let bar_w = post_spacing / 2.0 + post_d / 2.0 + 8.0;
let bar = box_from_corners([-bar_w, 0, top - bar_h], [bar_w, thickness, top]);
let r_out = post_d / 2.0 + 3.0;
let yc = -post_d / 2.0 - 0.5;
let hanger = frame + bar;
for s in [-1.0, 1.0] {
    let x = s * post_spacing / 2.0;
    let clip = cylinder([x, yc, top - bar_h], "Z", r_out, bar_h) - cylinder([x, yc, top - bar_h - 1.0], "Z", post_d / 2.0, bar_h + 2.0);
    clip = clip - box_from_corners([x - post_d * 0.4, yc - r_out - 1.0, top - bar_h - 1.0], [x + post_d * 0.4, yc, top + 1.0]);
    hanger = hanger + clip;
}
hanger
