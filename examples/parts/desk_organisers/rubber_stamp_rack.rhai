// Rubber stamp rack: 2 stepped tiers of 5 holes 30 mm across for mounted stamp handles, 40 mm tier step, 25 mm deep holes, 200 x 90 mm footprint, label ledge in front of each tier
let holes = 5; // [3, 8] Holes per tier
let hole_d = 30.0; // [20.0, 45.0] Hole diameter (mm)
let hole_depth = 25.0; // [15.0, 40.0] Hole depth (mm)
let step = 40.0; // [20.0, 60.0] Tier step height (mm)
let gap = 8.0; // [5.0, 15.0] Gap between holes (mm)

const front_h = 35.0;
const ledge = 8.0;
let pitch = hole_d + gap;
let length = holes * pitch + gap;
let tier_d = hole_d + 2.0 * gap + ledge;
let front = box_from_corners([0, 0, 0], [length, tier_d, front_h]);
let back = box_from_corners([0, tier_d, 0], [length, 2.0 * tier_d, front_h + step]);
let rack = front + back;
rack = rack.fillet(4.0, rack.edges("|Z").filter(|e| e.center().y < 0.01 || e.center().y > 2.0 * tier_d - 0.01));
let cuts = [];
for t in 0..2 {
    let z_top = front_h + t * step;
    let yc = t * tier_d + ledge + gap + hole_d / 2.0;
    for i in 0..holes {
        let x = gap + hole_d / 2.0 + i * pitch;
        cuts.push(cylinder([x, yc, z_top - min(hole_depth, front_h - 5.0)], "Z", hole_d / 2.0, hole_depth + 1.0));
    }
}
rack = rack - compound(cuts);
// sloped label ledge on the front of each tier
for t in 0..2 {
    let z_top = front_h + t * step;
    let y0 = t * tier_d;
    rack = rack - polygon([[-1.0, y0 - 0.01, z_top - 6.0], [-1.0, y0 + ledge, z_top + 0.01], [-1.0, y0 - 0.01, z_top + 0.01]]).to_face().extrude([length + 2.0, 0, 0]);
}
rack
