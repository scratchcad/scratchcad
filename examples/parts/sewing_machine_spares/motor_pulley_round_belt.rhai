// Sewing machine motor pulley for a round belt: 22 mm pulley 10 mm wide with a 45 degree V groove 3 mm deep to a 1.6 mm flat bottom, 12 mm hub 6 mm long, 5 mm D-bore (4.5 mm across the flat), M3 set screw hole (2.5 mm) through the hub onto the flat
let pulley_d = 22.0; // [20.0, 40.0] Pulley diameter (mm)
let width = 10.0; // [7.0, 14.0] Pulley width (mm)
let groove_depth = 3.0; // [2.0, 4.0] Groove depth (mm)
let shaft_d = 5.0; // [4.0, 8.0] Shaft diameter (mm)
const hub_d = 12.0;
const hub_len = 6.0;
let ro = pulley_d / 2.0;
let rh = max(hub_d / 2.0, shaft_d / 2.0 + 3.0);
let rg = max(ro - groove_depth, rh + 1.0);
let g = (ro - rg) * tan(22.5 * PI() / 180.0);
let wc = width / 2.0;
let profile = polygon([
    [0, 0, -hub_len], [rh, 0, -hub_len], [rh, 0, 0], [ro, 0, 0], [ro, 0, wc - g - 0.8],
    [rg, 0, wc - 0.8], [rg, 0, wc + 0.8], [ro, 0, wc + g + 0.8], [ro, 0, width], [0, 0, width]
]);
let pulley = profile.to_face().revolve("Z", 360.0);
let bore = cylinder([0, 0, -hub_len - 1.0], "Z", shaft_d / 2.0, hub_len + width + 2.0) - box_from_corners([shaft_d / 2.0 - 0.5, -shaft_d, -hub_len - 2.0], [shaft_d, shaft_d, width + 2.0]);
pulley - fuse_all([bore, cylinder([0, 0, -hub_len / 2.0], "X", 1.25, rh + 1.0)])
