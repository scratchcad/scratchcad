// Centrefeed paper roll core adapter: a 60 mm flange 3 mm thick on a 3 mm walled plug 30 mm long with a 1 mm lead-in that pushes into a 50 mm roll core, four 2 mm crush ribs on the plug, and a 22 mm hub hole with a 4 mm collar 5 mm tall for the dispenser spigot
let core_id = 50.0; // [38.0, 76.0] Roll core inside diameter (mm)
let plug_len = 30.0; // [15.0, 50.0] Plug length (mm)
let hub_hole = 22.0; // [10.0, 34.0] Hub hole diameter (mm)
let ribs = 4; // [3, 8] Number of crush ribs
const t = 3.0;
const wall = 3.0;
let rp = core_id / 2.0 - 0.5;
let rf = rp + 5.5;
let rh = min(hub_hole / 2.0, rp - wall - 4.0);
let pts = [[rh, 0, 0], [rf, 0, 0], [rf, 0, t], [rp, 0, t], [rp, 0, t + plug_len - 1.0], [rp - 1.0, 0, t + plug_len], [rp - wall, 0, t + plug_len], [rp - wall, 0, t], [rh + 4.0, 0, t], [rh + 4.0, 0, t + 5.0], [rh, 0, t + 5.0]];
let body = face(polygon(pts)).revolve("Z", 360.0);
let parts = [body];
for i in 0..ribs {
    parts.push(box_from_corners([rp - 0.5, -1.0, t + 3.0], [rp + 0.6, 1.0, t + plug_len - 4.0]).rotate_z(i.to_float() * 360.0 / ribs.to_float()));
}
fuse_all(parts)
