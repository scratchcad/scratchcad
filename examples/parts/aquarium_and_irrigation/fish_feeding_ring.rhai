// Floating fish feeding ring: 80 mm square, 15 mm frame, 12 mm thick with closed hollow float
let size = 80.0; // [50.0, 120.0] Outside size (mm)
let frame = 15.0; // [10.0, 20.0] Frame width (mm)
let thickness = 12.0; // [8.0, 20.0] Thickness (mm)
let outer = box_centered(size, size, thickness);
let o = outer.fillet(frame / 2.0, outer.edges("|Z"));
let inner = box_centered(size - 2.0 * frame, size - 2.0 * frame, thickness + 2.0);
let ring = o - inner;
let cavity = box_centered(size - 3.0, size - 3.0, thickness - 3.0) - box_centered(size - 2.0 * frame + 3.0, size - 2.0 * frame + 3.0, thickness);
ring - cavity
