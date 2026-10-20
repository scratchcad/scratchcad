// Hair comb slide, 70 mm wide: 8 mm spine 3 mm thick, 17 teeth 32 mm long tapering from 2.2 to 1.2 mm, 2 mm thick teeth
let comb_width = 70.0; // [40.0, 110.0] Comb width (mm)
let spine_height = 8.0; // [5.0, 14.0] Spine height (mm)
let tooth_length = 32.0; // [15.0, 50.0] Tooth length (mm)
let teeth = 17; // [6, 30] Number of teeth
let tooth_root = 2.2; // [1.2, 3.5] Tooth width at the root (mm)
let thickness = 3.0; // [2.0, 5.0] Spine thickness (mm)
let pitch = comb_width / teeth.to_float();
let tw = min(tooth_root, pitch * 0.8);
let tip = tw * 0.55;
// outline: spine along the top, teeth hanging down (-Y)
let pts = [[comb_width / 2.0, spine_height], [-comb_width / 2.0, spine_height]];
for i in 0..teeth {
    let xc = -comb_width / 2.0 + pitch * (i.to_float() + 0.5);
    pts.push([xc - tw / 2.0, 0]);
    pts.push([xc - tip / 2.0, -tooth_length]);
    pts.push([xc + tip / 2.0, -tooth_length]);
    pts.push([xc + tw / 2.0, 0]);
}
let outline = [];
for p in pts { outline.push([p[0], p[1], 0]); }
let comb = polygon(outline).to_face().extrude([0, 0, thickness]);
// teeth are thinner than the spine
comb - box_from_corners([-comb_width, -tooth_length - 1.0, 2.0], [comb_width, -1.0, thickness + 1.0])
