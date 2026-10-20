// OBD-II (SAE J1962) port dust cover: trapezoid plug 37 mm wide at the top, 31 mm at the bottom, 14.5 mm tall, 9 mm deep, hollow 1.5 mm wall, 44 x 21 x 2.5 mm flange, latch bump and pull tab
let top_w = 37.0; // [35.0, 39.0] Plug width at the top (mm)
let bottom_w = 31.0; // [28.0, 34.0] Plug width at the bottom (mm)
let plug_h = 14.5; // [13.0, 16.0] Plug height (mm)
let depth = 9.0; // [6.0, 14.0] Plug depth (mm)
let wall = 1.5; // [1.2, 2.2] Plug wall (mm)

const flange_t = 2.5;
const corner = 2.0;
let trap = |tw, bw, h, z0, hz| {
    let t = polygon([[-bw / 2.0, -h / 2.0, 0], [bw / 2.0, -h / 2.0, 0], [tw / 2.0, h / 2.0, 0], [-tw / 2.0, h / 2.0, 0]]).to_face().extrude([0, 0, hz]).translate([0, 0, z0]);
    t.fillet(min(corner, h / 4.0), t.edges("|Z"))
};
let flange = trap.call(top_w + 7.0, bottom_w + 7.0, plug_h + 6.5, 0.0, flange_t);
let plug = trap.call(top_w, bottom_w, plug_h, flange_t - 0.5, depth + 0.5);
let hollow = trap.call(top_w - 2.0 * wall, bottom_w - 2.0 * wall, plug_h - 2.0 * wall, flange_t, depth + 1.0);
let bump = box_centered(8.0, 1.2, 3.0).translate([0, plug_h / 2.0 + 0.3, flange_t + depth - 3.0]);
bump = bump.chamfer(0.5, bump.edges(">Z and >Y"));
let tab = box_from_corners([-6.0, -plug_h / 2.0 - 3.25 - 10.0, 0], [6.0, -plug_h / 2.0 - 2.0, flange_t]);
tab = tab.fillet(5.0, tab.edges("|Z and <Y")) - cylinder([0, -plug_h / 2.0 - 3.25 - 5.0, -1.0], "Z", 2.5, flange_t + 2.0);
fuse_all([flange, plug, bump, tab]) - hollow
