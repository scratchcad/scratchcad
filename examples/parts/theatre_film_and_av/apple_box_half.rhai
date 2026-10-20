// Half apple box: 20 x 12 x 4 in (508 x 305 x 102 mm) grip box, 19 mm (3/4 in) plywood walls, open-frame inside with one center brace, 100 x 32 mm hand holes in both ends
let length = 508.0; // [400.0, 600.0] Box length (mm)
let width = 305.0; // [250.0, 360.0] Box width (mm)
let height = 102.0; // [60.0, 210.0] Box height (mm)
let ply = 19.0; // [12.0, 25.0] Plywood thickness (mm)
let hand = 100.0; // [80.0, 130.0] Hand hole length (mm)
let outer = box_from_corners([0, 0, 0], [length, width, height]);
// the inside is closed top and bottom; cavities either side of the center brace
let cav = [];
for s in [0.0, 1.0] {
    let x0 = ply + s * (length - ply) / 2.0;
    cav.push(box_from_corners([x0, ply, ply], [x0 + (length - 3.0 * ply) / 2.0, width - ply, height - ply]));
}
let hh = height * 0.32;
let holes = [];
for x in [-1.0, length - ply - 1.0] {
    let h = box_from_corners([x, width / 2.0 - hand / 2.0, height / 2.0 - hh / 2.0], [x + ply + 2.0, width / 2.0 + hand / 2.0, height / 2.0 + hh / 2.0]);
    holes.push(h.fillet(hh / 2.0 - 0.5, h.edges("|X")));
}
outer - compound(cav) - compound(holes)
