// Heart cookie cutter: 64 mm wide, 60 mm tall, two 16.5 mm lobes and a pointed tip, 0.8 mm wall 18 mm tall, 3 mm pressing rim on top
let lobe_radius = 16.5; // [8.0, 30.0] Lobe radius (mm)
let lobe_spacing = 15.0; // [5.0, 25.0] Lobe centre offset from the middle (mm)
let tip_depth = 32.0; // [20.0, 60.0] Tip below the lobe centres (mm)
let height = 18.0; // [10.0, 30.0] Cutter height (mm)
let wall = 0.8; // [0.5, 1.5] Wall thickness (mm)
let rim_width = 3.0; // [1.5, 6.0] Rim width (mm)
let rl = max(lobe_radius, lobe_spacing + 1.0);
let c = lobe_spacing;
// tangent from the tip (0, -tip_depth) to the left lobe circle at (-c, 0), on its outer side
let dx = -c;
let dy = tip_depth;
let l = sqrt(dx * dx + dy * dy);
let a = (rl / l).asin();
let lt = sqrt(l * l - rl * rl);
let ux = (dx * a.cos() - dy * a.sin()) / l;
let uy = (dx * a.sin() + dy * a.cos()) / l;
let tx = ux * lt;
let ty = -tip_depth + uy * lt;
let dip = sqrt(rl * rl - c * c);
let edge = sketch().move_to(0, -tip_depth).line_to(tx, ty).arc_to(-c, rl, 0, dip).arc_to(c, rl, -tx, ty).close();
let cutter = face(edge.offset(wall), [edge]).extrude([0, 0, height]);
let rim = face(edge.offset(wall + rim_width), [edge]).extrude([0, 0, 1.5]).translate([0, 0, height - 1.5]);
cutter + rim
