// MGN12 linear guide: 12 x 8 mm rail 100 mm long with M3 holes at 25 mm pitch, and an MGN12H carriage 27 x 45.4 x 10 mm
let rail_length = 100.0; // [50.0, 400.0] Rail length (mm)
let hole_pitch = 25.0; // [20.0, 40.0] Rail hole pitch (mm)
let carriage_pos = 0.0; // [-30.0, 30.0] Carriage position (mm)
let rail = box_centered(rail_length, 12.0, 8.0).translate([0, 0, 4.0]);
let groove = box_centered(rail_length + 2.0, 1.6, 1.2).translate([0, 6.0, 5.5]);
rail = rail - groove - groove.mirror("XZ");
let holes = [];
let n = (rail_length / hole_pitch).floor().to_int();
for i in 0..n {
    let x = -rail_length / 2.0 + hole_pitch / 2.0 + i.to_float() * hole_pitch;
    holes.push(cylinder([x, 0, -1], "Z", 1.75, 10.0));
    holes.push(cylinder([x, 0, 4.5], "Z", 3.0, 5.0));
}
rail = rail - fuse_all(holes);
let carriage = box_centered(45.4, 27.0, 10.0 - 3.0).translate([carriage_pos, 0, 3.0 + 3.5]);
carriage = carriage - box_centered(50.0, 12.6, 8.4).translate([carriage_pos, 0, 4.0]);
for sx in [-1, 1] { for sy in [-1, 1] { carriage -= cylinder([carriage_pos + sx * 10.0, sy * 10.0, 5.0], "Z", 1.25, 6.0); } }
[rail, carriage]
