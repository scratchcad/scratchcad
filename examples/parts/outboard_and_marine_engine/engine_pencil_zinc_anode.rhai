// Marine engine pencil zinc anode on a 1/2 in NPT brass plug, modelled as one piece: 22.2 mm (7/8 in) hex 8 mm tall, 21.3 mm tapered pipe thread 14 mm long (shown as a 1 in 16 taper), and a 15.9 mm (5/8 in) zinc pencil 38 mm long screwed into the end with a 1 mm tip chamfer
let pencil_d = 15.9; // [9.5, 19.0] Zinc pencil diameter (mm)
let pencil_len = 38.0; // [20.0, 60.0] Zinc pencil length (mm)
let hex_af = 22.2; // [17.5, 28.6] Plug hex across flats (mm)
const thread_len = 14.0;
const hex_h = 8.0;
let rc = hex_af / 2.0 / cos(30.0 * PI() / 180.0);
let pts = [];
for i in 0..6 {
    let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0;
    pts.push([rc * cos(a), rc * sin(a), 0.0]);
}
let hex = face(polygon(pts)).extrude([0, 0, hex_h]).translate([0, 0, -hex_h]);
let hex = hex.chamfer(0.8, hex.edges("<Z"));
let rt = max(21.3 / 2.0, pencil_d / 2.0 + 1.5);
let taper = cone(rt, rt - thread_len / 32.0, thread_len + 0.5).translate([0, 0, -0.5]);
let rp = min(pencil_d / 2.0, rt - 1.0);
let pencil = face(polygon([[0, 0, thread_len - 0.5], [rp, 0, thread_len - 0.5], [rp, 0, thread_len + pencil_len - 1.0], [rp - 1.0, 0, thread_len + pencil_len], [0, 0, thread_len + pencil_len]])).revolve("Z", 360.0);
fuse_all([hex, taper, pencil])
