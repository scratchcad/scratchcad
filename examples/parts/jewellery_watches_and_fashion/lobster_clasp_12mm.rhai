// Lobster claw clasp, 12 mm: 8 mm round claw 2.5 mm thick on a tapered stem, 2.4 mm inner opening, spring gate as a separate part in a 2 mm gap, 3 mm attachment loop
let claw_diameter = 8.0; // [6.0, 14.0] Claw diameter (mm)
let opening_diameter = 4.8; // [3.0, 9.0] Inner opening diameter (mm)
let thickness = 2.5; // [1.5, 4.0] Thickness (mm)
let stem_length = 4.0; // [2.0, 7.0] Stem length (mm)
let gate_gap = 2.0; // [1.2, 3.0] Gate opening (mm)
let ro = claw_diameter / 2.0;
let ri = min(opening_diameter / 2.0, ro - 0.8);
let stem = polygon([[-1.6, 0], [1.6, 0], [1.0, -stem_length], [-1.0, -stem_length]]).to_face().extrude([0, 0, thickness]);
let claw = cylinder([0, ro - 0.5, 0], "Z", ro, thickness) + stem;
claw = claw - cylinder([0, ro - 0.5, -1], "Z", ri, thickness + 2.0);
// the gate gap on the +X side of the claw
let yc = ro - 0.5;
let gap_cut = box_from_corners([ri - 0.5, yc - gate_gap / 2.0, -1], [ro + 1.0, yc + gate_gap / 2.0, thickness + 1.0]);
claw = claw - gap_cut;
let loop_ring = cylinder([0, -stem_length - 1.2, 0], "Z", 1.8, thickness * 0.6) - cylinder([0, -stem_length - 1.2, -1], "Z", 0.9, thickness + 2.0);
let body = claw + loop_ring;
// gate: the missing arc of the claw, 0.1 mm clear of it all round
let gate = (cylinder([0, yc, 0.3], "Z", ro - 0.1, thickness - 0.6) - cylinder([0, yc, -1], "Z", ri + 0.1, thickness + 2.0)) & box_from_corners([ri - 0.5, yc - gate_gap / 2.0 + 0.1, -1], [ro + 1.0, yc + gate_gap / 2.0 - 0.1, thickness + 1.0]);
[body, gate]
