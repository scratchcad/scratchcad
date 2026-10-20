// Bain-marie drain plug: tapered rubber plug 22 mm to 19 mm over 20 mm for a 3/4 in drain outlet, 40 mm cap 5 mm thick, O-ring groove and a 30 x 6 x 12 mm T-handle
let top_d = 22.0; // [18.0, 28.0] Plug diameter at the cap (mm)
let taper = 3.0; // [1.0, 5.0] Taper over the plug length (mm)
let plug_len = 20.0; // [12.0, 30.0] Plug length (mm)
let cap_d = 40.0; // [32.0, 50.0] Cap diameter (mm)
const cap_t = 5.0;
let r_top = top_d / 2.0;
let r_tip = r_top - taper / 2.0;
let body = face(polygon([[0, 0, 0], [r_tip, 0, 0], [r_top, 0, plug_len], [cap_d / 2.0, 0, plug_len], [cap_d / 2.0, 0, plug_len + cap_t], [0, 0, plug_len + cap_t]])).revolve("Z", 360);
let zg = plug_len * 0.4;
let rg = r_tip + taper / 2.0 * 0.4 - 1.5;
let groove = cylinder([0, 0, zg - 1.25], "Z", r_top + 2.0, 2.5) - cylinder([0, 0, zg - 2.0], "Z", rg, 4.0);
let handle = box_centered(30.0, 6.0, 12.0);
handle = handle.fillet(2.0, handle.edges("|Y and >Z"));
body - groove + handle.translate([0, 0, plug_len + cap_t + 5.99])
