// Stainless PV cable clip for 1.5-4 mm panel frame flanges: 0.8 mm spring steel, 12 mm wide, frame jaw with a barb, two open loops holding 6 mm PV cables side by side
let width = 12.0; // [8.0, 20.0] Clip width (mm)
let cable_d = 6.0; // [4.0, 8.0] Cable diameter (mm)
let flange = 2.0; // [1.0, 4.0] Frame flange thickness (mm)
const t = 0.8;
let r = cable_d / 2.0 + 0.2;
let gap = flange - 0.3;
let x_left = -4.0 * r - 3.5 * t;
let jaw = polygon("XZ", [[0, 0], [12.0, 0], [12.0, t], [t, t], [t, gap + t], [10.0, gap + t], [11.5, gap + t + 1.2], [11.5, gap + 2.0 * t + 1.2], [10.0, gap + 2.0 * t], [x_left, gap + 2.0 * t], [x_left, gap + t], [0, gap + t]])
    .to_face().extrude([0, width, 0]);
let barb = polygon("XZ", [[5.0, t - 0.01], [6.5, t - 0.01], [6.5, t + 0.6]]).to_face().extrude([0, width, 0]);
let zc = gap + 2.0 * t + r - 0.3;
let loops = [];
for k in 0..2 {
    let xc = -r - t - k.to_float() * (2.0 * r + 1.5 * t);
    loops.push(cylinder([xc, 0, zc], "Y", r + t, width) - cylinder([xc, -1, zc], "Y", r, width + 2.0) - box_centered(r * 1.3, width + 2.0, 2.0 * r).translate([xc, width / 2.0, zc + r + 0.5]));
}
let cl = fuse_all([jaw, barb] + loops);
cl - cylinder([-r - t, -1, zc], "Y", r, width + 2.0) - cylinder([-3.0 * r - 2.5 * t, -1, zc], "Y", r, width + 2.0)
