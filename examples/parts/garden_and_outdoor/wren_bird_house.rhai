// House wren nest box: 100 x 100 mm floor inside, 15 mm boards, 28 mm (1-1/8 in) entrance 150 mm up, roof sloping back with 40 mm front overhang, drain and vent holes
let inside = 100.0; // [80.0, 150.0] Floor size inside (mm)
let front_height = 200.0; // [150.0, 300.0] Front height (mm)
let back_rise = 30.0; // [10.0, 60.0] Extra height at the back (mm)
let board = 15.0; // [9.0, 22.0] Board thickness (mm)
let hole_diameter = 28.0; // [25.0, 40.0] Entrance hole diameter (mm)
let hole_height = 150.0; // [80.0, 250.0] Entrance hole height (mm)
let overhang = 40.0; // [10.0, 80.0] Roof overhang at the front (mm)
let w = inside + 2.0 * board;
let body = polygon([[0, 0, 0], [0, w, 0], [0, w, front_height + back_rise], [0, 0, front_height]]).to_face().extrude([w, 0, 0]);
let cavity = polygon([[board, board, board], [board, w - board, board], [board, w - board, front_height + back_rise - board],
                      [board, board, front_height - board]]).to_face().extrude([inside, 0, 0]);
let slope = back_rise / w;
let y0 = -overhang;
let y1 = w + 15.0;
let roof = polygon([[-15.0, y0, front_height + slope * y0 - 0.5], [-15.0, y1, front_height + slope * y1 - 0.5],
                    [-15.0, y1, front_height + slope * y1 + board], [-15.0, y0, front_height + slope * y0 + board]]).to_face().extrude([w + 30.0, 0, 0]);
let house = fuse_all([body - cavity, roof]);
let hz = min(hole_height, front_height - board - hole_diameter);
let holes = [cylinder([w / 2.0, -1.0, hz], "Y", hole_diameter / 2.0, board + 2.0)];
for x in [-1.0, 1.0] {
    holes.push(cylinder([w / 2.0 + x * 25.0, w / 2.0, -1.0], "Z", 4.0, board + 2.0));
}
holes.push(cylinder([-1.0, w / 2.0, front_height - board - 15.0], "X", 5.0, w + 2.0));
house - compound(holes)
