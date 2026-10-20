// Foam soap cartridge nozzle collar: 38 mm ring 12 mm tall that clips the cartridge pump into the dispenser, a 26 mm bore with a 1.2 mm internal retaining lip 2 mm thick at the top, a 44 mm flange 2 mm thick at the base and two 6 x 4 mm bayonet lugs on the outside
let bore_d = 26.0; // [18.0, 34.0] Pump body diameter (mm)
let collar_h = 12.0; // [8.0, 20.0] Collar height (mm)
let flange_d = 44.0; // [36.0, 60.0] Flange diameter (mm)
let lugs = 2; // [2, 4] Number of bayonet lugs
const wall = 6.0;
const lip = 1.2;
let ri = bore_d / 2.0;
let ro = ri + wall;
let rf = max(flange_d / 2.0, ro + 3.0);
let pts = [[ri, 0, 0], [rf, 0, 0], [rf, 0, 2.0], [ro, 0, 2.0], [ro, 0, collar_h - 0.6], [ro - 0.6, 0, collar_h], [ri - lip, 0, collar_h], [ri - lip, 0, collar_h - 2.0], [ri, 0, collar_h - 2.0]];
let collar = face(polygon(pts)).revolve("Z", 360.0);
let parts = [collar];
for i in 0..lugs {
    parts.push(box_from_corners([ro - 1.0, -3.0, collar_h - 6.0], [ro + 3.0, 3.0, collar_h - 2.0]).rotate_z(i.to_float() * 360.0 / lugs.to_float() + 90.0));
}
fuse_all(parts)
