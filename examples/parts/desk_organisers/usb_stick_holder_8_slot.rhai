// USB flash drive holder, 8 slots: 12.4 x 4.8 mm USB-A sockets 12 mm deep in a wedge whose top slopes 20 degrees toward the user, 2 rows of 4 at 20 mm pitch, 34 mm tall at the back
let rows = 2; // [1, 3] Number of rows
let per_row = 4; // [2, 8] Slots per row
let pitch = 20.0; // [16.0, 30.0] Slot pitch (mm)
let slope = 20.0; // [0.0, 30.0] Top slope (degrees)
let plug_w = 12.4; // [12.2, 13.0] USB-A plug width (mm)
let back_h = 34.0; // [20.0, 50.0] Back height (mm)

const plug_t = 4.8;
const plug_d = 12.0;
const row_pitch = 18.0;
const margin = 10.0;
let width = per_row * pitch;
let depth = rows * row_pitch + margin;
let a = slope * PI() / 180.0;
let bh = max(back_h, depth * tan(a) + plug_d + 4.0);
let front_h = bh - depth * tan(a);
let wedge = polygon([[0, 0, 0], [0, depth, 0], [0, depth, bh], [0, 0, front_h]]).to_face().extrude([width, 0, 0]);
wedge = wedge.fillet(3.0, wedge.edges("|Y"));
let cuts = [];
for r in 0..rows {
    let y = margin / 2.0 + row_pitch / 2.0 + r * row_pitch;
    let zt = front_h + y * tan(a);
    for i in 0..per_row {
        let x = (i + 0.5) * pitch;
        cuts.push(box_centered(plug_w, plug_t, 2.0 * plug_d).rotate_x(slope).translate([x, y, zt]));
    }
}
wedge - compound(cuts)
