// Unvented cylinder tundish 15 x 22 mm: 15 mm inlet socket 16 mm deep on top, 40 mm body 60 mm tall with two 18 x 26 mm air-gap windows, conical drain floor, 22 mm outlet socket 18 mm deep below
let body_d = 40.0; // [32.0, 55.0] Body diameter (mm)
let body_h = 60.0; // [45.0, 80.0] Body height (mm)
let inlet = 15.0; // [10.0, 22.0] Inlet pipe size (mm)
let outlet = 22.0; // [15.0, 28.0] Outlet pipe size (mm)
let window_w = 18.0; // [10.0, 24.0] Window width (mm)
let window_h = 26.0; // [15.0, 35.0] Window height (mm)
let rb = body_d / 2.0;
let ro = min(outlet / 2.0 + 0.1, rb - 4.0);
let ri = min(inlet / 2.0 + 0.1, rb - 5.0);
const wall = 2.0;
let outer = polygon([[0, 0, 0], [ro + wall, 0, 0], [ro + wall, 0, 18.0], [rb, 0, 26.0], [rb, 0, 26.0 + body_h], [ri + wall + 3.0, 0, 30.0 + body_h], [ri + wall, 0, 30.0 + body_h], [ri + wall, 0, 46.0 + body_h], [0, 0, 46.0 + body_h]]).to_face().revolve("Z", 360);
let inner = polygon([[0, 0, -1], [ro, 0, -1], [ro, 0, 18.0], [ro - 1.5, 0, 19.0], [ro - 1.5, 0, 22.0], [rb - wall, 0, 26.0 + wall], [rb - wall, 0, 26.0 + body_h - wall], [0, 0, 26.0 + body_h - wall]]).to_face().revolve("Z", 360);
let inlet_bore = cylinder([0, 0, 26.0 + body_h - wall - 1.0], "Z", ri - 2.0, 30.0) + cylinder([0, 0, 30.0 + body_h], "Z", ri, 17.0);
let ww = min(window_w, rb * 1.2);
let wh = min(window_h, body_h - 12.0);
let win = box_centered(ww, body_d + 2.0, wh).translate([0, 0, 26.0 + body_h / 2.0]);
let win = win.fillet(min(ww, wh) * 0.3, win.edges("|Y"));
outer - inner - inlet_bore - win
