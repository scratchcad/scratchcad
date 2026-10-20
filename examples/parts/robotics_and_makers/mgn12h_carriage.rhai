// MGN12H linear guide carriage on a 120 mm rail: 27 mm wide, 45.4 mm long block (32.4 mm steel body plus end caps with grease nipple), 10 mm tall, four M3 holes on a 20 x 20 mm pattern, 12 x 8 mm rail with M3 holes on 25 mm pitch
let rail_len = 120.0; // [40.0, 400.0] Rail length (mm)
let block_pos = 0.0; // [-40.0, 40.0] Carriage position along the rail (mm)
const rail_w = 12.0;
const rail_h = 8.0;
const block_w = 27.0;
const block_l = 32.4;
const cap_l = 6.5;
const h_total = 13.0;
const clearance = 3.0;
let rprof = polygon("YZ", [[-6.0, 0], [6.0, 0], [6.0, 3.0], [5.2, 3.7], [6.0, 4.4], [6.0, rail_h], [-6.0, rail_h], [-6.0, 4.4], [-5.2, 3.7], [-6.0, 3.0]]);
let rail = rprof.to_face().extrude([rail_len, 0, 0]).translate([-rail_len / 2.0, 0, 0]);
let n = (rail_len / 25.0).floor().to_int();
for i in 0..n {
    let x = -rail_len / 2.0 + 12.5 + i.to_float() * 25.0 + (rail_len - n.to_float() * 25.0) / 2.0;
    rail -= cylinder([x, 0, -1], "Z", 1.75, rail_h + 2.0) + cylinder([x, 0, rail_h - 3.5], "Z", 3.0, 4.0);
}
let bp = min(max(block_pos, -rail_len / 2.0 + 23.0), rail_len / 2.0 - 23.0);
let body = box_centered(block_l, block_w, h_total - clearance).translate([bp, 0, clearance + (h_total - clearance) / 2.0]);
let caps = box_centered(cap_l, block_w - 2.0, h_total - clearance - 1.5).translate([bp + block_l / 2.0 + cap_l / 2.0 - 0.01, 0, clearance + 0.5 + (h_total - clearance - 1.5) / 2.0])
         + box_centered(cap_l, block_w - 2.0, h_total - clearance - 1.5).translate([bp - block_l / 2.0 - cap_l / 2.0 + 0.01, 0, clearance + 0.5 + (h_total - clearance - 1.5) / 2.0]);
let nipple = cylinder([bp + block_l / 2.0 + cap_l - 0.01, 0, clearance + 4.5], "X", 1.5, 3.0) + sphere([bp + block_l / 2.0 + cap_l + 3.5, 0, clearance + 4.5], 1.8);
let block = fuse_all([body, caps, nipple]) - box_centered(block_l + 2.0 * cap_l + 2.0, rail_w + 0.4, 2.0 * rail_h).translate([bp, 0, 0]).translate([0, 0, rail_h - 0.3 - rail_h]);
for x in [-10.0, 10.0] { for y in [-10.0, 10.0] { block -= cylinder([bp + x, y, h_total - 5.0], "Z", 1.25, 6.0); } }
compound([rail, block])
