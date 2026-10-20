// Cistern siphon diaphragm support plate (5.5 in flap valve): 100 mm disc 2 mm thick, 12 x 9 mm flow holes on 72 mm PCD, 6 x 6 mm on 40 mm PCD, 14 mm hub 8 mm tall with 5 mm lift-rod bore, 1.5 mm rim
let diameter = 100.0; // [70.0, 140.0] Plate diameter (mm)
let thick = 2.0; // [1.5, 3.5] Plate thickness (mm)
let outer_holes = 12; // [6, 16] Number of outer flow holes
let outer_hole = 9.0; // [5.0, 12.0] Outer hole diameter (mm)
let inner_holes = 6; // [0, 10] Number of inner flow holes
let rod = 5.0; // [3.0, 7.0] Lift rod bore (mm)
let r = diameter / 2.0;
let plate = cylinder(r, thick) + (cylinder(r, thick + 1.5) - cylinder([0, 0, -1], "Z", r - 1.5, thick + 3.0));
let hub = cylinder(7.0, 8.0);
let holes = [];
let pcd = min(r * 0.72, r - outer_hole / 2.0 - 3.0);
for k in 0..outer_holes {
    let a = k.to_float() * 2.0 * PI() / outer_holes.to_float();
    holes.push(cylinder([pcd * a.cos(), pcd * a.sin(), -1], "Z", outer_hole / 2.0, thick + 2.0));
}
let pcd2 = r * 0.4;
for k in 0..inner_holes {
    let a = (k.to_float() + 0.5) * 2.0 * PI() / inner_holes.to_float();
    holes.push(cylinder([pcd2 * a.cos(), pcd2 * a.sin(), -1], "Z", 3.0, thick + 2.0));
}
plate + hub - fuse_all(holes) - cylinder([0, 0, -1], "Z", rod / 2.0, 10.0)
