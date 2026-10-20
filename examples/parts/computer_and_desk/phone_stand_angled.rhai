// Desk phone stand: 70 mm wide, 65 degree back, 12 mm phone ledge 10 mm lip, charging cable slot
let width = 70.0; // [50.0, 100.0] Width (mm)
let angle = 65.0; // [50.0, 80.0] Back angle (degrees)
let back_l = 100.0; // [70.0, 140.0] Back length (mm)
let t = 5.0; // [3.0, 8.0] Thickness (mm)
let a = angle * PI() / 180.0;
let top = [back_l * a.cos(), back_l * a.sin()];
let profile = polygon([[0, 0], [top[0] + 50.0, 0], [top[0] + 50.0, t], [top[0] + t, t], [top[0] + t, top[1]], [top[0], top[1]], [t / a.sin() * 0.5, t], [-16.0, t], [-16.0, 14.0], [-16.0 - t, 14.0], [-16.0 - t, 0]]);
let s = profile.to_face().extrude([0, 0, width]).rotate_x(90.0).translate([0, width / 2.0, 0]);
s - box_centered(12.0, 8.0, 30.0).translate([-8.0, 0, 0])
