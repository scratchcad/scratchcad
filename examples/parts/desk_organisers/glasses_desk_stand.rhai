// Desk glasses stand: nose-bridge upright 120 mm tall and 14 mm thick tapering from 40 mm to an 18 mm rounded top, on an 80 x 60 x 6 mm base, 4 mm edge rounds so frames don't scratch
let height = 120.0; // [80.0, 160.0] Stand height (mm)
let bottom_w = 40.0; // [30.0, 60.0] Upright width at the base (mm)
let top_w = 18.0; // [12.0, 26.0] Nose bridge width (mm)
let thick = 14.0; // [10.0, 20.0] Upright thickness (mm)
let base_w = 80.0; // [60.0, 120.0] Base width (mm)

const base_d = 60.0;
const base_t = 6.0;
let tw = min(top_w, bottom_w - 6.0);
let r_top = tw / 2.0;
let up = sketch("XZ").move_to(-bottom_w / 2.0, 0).line_to(-tw / 2.0, height - r_top).arc_to(0, height, tw / 2.0, height - r_top).line_to(bottom_w / 2.0, 0).close();
let upright = up.to_face().extrude([0, thick, 0]).translate([0, -thick / 2.0, 0]);
upright = upright.fillet(min(4.0, thick / 2.0 - 1.0), upright.edges("not |Y").filter(|e| e.center().z > 0.5));
let base = box_centered(max(base_w, bottom_w + 20.0), base_d, base_t).translate([0, 0, base_t / 2.0]);
base = base.fillet(10.0, base.edges("|Z"));
base = base.fillet(2.0, base.edges(">Z"));
base + upright.translate([0, 0, base_t - 1.0])
