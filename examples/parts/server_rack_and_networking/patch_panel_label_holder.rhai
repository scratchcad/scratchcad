// Patch panel label strip holder: 440 x 12 mm clip-on channel for a 0.5 mm label strip 9 mm tall, 1 mm walls with 0.8 mm retaining lips, snapping onto a 1.5 mm panel edge
let length = 440.0; // [200.0, 460.0] Holder length (mm)
let label = 9.0; // [6.0, 12.0] Label height (mm)
const t = 1.0;
let back = box_from_corners([0, 0, 0], [length, t, label + 2.0 * t]);
let lips = box_from_corners([0, -1.0, 0], [length, t, t]) + box_from_corners([0, -1.0, label + t], [length, t, label + 2.0 * t]) + box_from_corners([0, -1.0, 0], [length, -0.5, 0.8 + t]) + box_from_corners([0, -1.0, label + t - 0.8], [length, -0.5, label + 2.0 * t]);
let clip = box_from_corners([0, t - 0.01, label + 2.0 * t - t], [length, t + 1.5 + t, label + 2.0 * t]) + box_from_corners([0, t + 1.5, label - 3.0], [length, t + 1.5 + t, label + 2.0 * t]);
back + lips + clip
