// Field sample bag clip: 80 mm one-piece spring clip, 12 mm wide, 3 mm U-section with a 2.5 mm gap, a 3 mm living hinge loop 10 mm dia, and a 30 x 10 mm label flat
let length = 80.0; // [50.0, 120.0] Clip length (mm)
let gap = 2.5; // [1.5, 4.0] Jaw gap (mm)
const t = 3.0;
const w = 12.0;
let jaw_a = box_from_corners([0, 0, 0], [length, w, t]);
let jaw_b = box_from_corners([0, 0, t + gap], [length, w, 2.0 * t + gap]);
let hoop = cylinder([0, 0, t + gap / 2.0], "Y", t + gap / 2.0, w) - cylinder([0, -1.0, t + gap / 2.0], "Y", gap / 2.0, w + 2.0) - box_from_corners([0.01, -1.0, -5.0], [20.0, w + 1.0, 20.0]);
let label = box_from_corners([length - 30.0, 0, 2.0 * t + gap - 0.01], [length, w, 2.0 * t + gap + 1.0]);
jaw_a + jaw_b + hoop + label
