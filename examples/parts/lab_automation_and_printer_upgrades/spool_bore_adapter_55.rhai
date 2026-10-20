// Spool bore adapter: fits a 55 mm spool hole (54.5 mm OD ring, 2 mm wall, 15 mm wide) onto a 30 mm holder rod (30.5 mm hub bore, 3 mm wall), 6 spokes 3 mm thick, 65 mm retaining flange 2 mm
let spool_bore = 54.5; // [40.0, 80.0] Spool hole fit diameter (mm)
let rod = 30.5; // [8.0, 32.0] Holder rod bore (mm)
let width = 15.0; // [8.0, 30.0] Adapter width (mm)
let spoke_count = 6; // [3, 10] Number of spokes
const wall = 2.0;
const hub_wall = 3.0;
const flange_extra = 5.0;
let ro = spool_bore / 2.0;
let rr = min(rod / 2.0, ro - wall - hub_wall - 3.0);
let ring = cylinder(ro, width) - cylinder([0, 0, -1], "Z", ro - wall, width + 2.0);
let flange = cylinder(ro + flange_extra, 2.0) - cylinder([0, 0, -1], "Z", ro - wall, 4.0);
let hub = cylinder(rr + hub_wall, width) - cylinder([0, 0, -1], "Z", rr, width + 2.0);
let spokes = [];
for k in 0..spoke_count {
    spokes.push(box_from_corners([rr + hub_wall - 0.5, -1.5, 0], [ro - wall + 0.5, 1.5, width]).rotate_z(k.to_float() * 360.0 / spoke_count.to_float()));
}
fuse_all([ring, flange, hub] + spokes)
