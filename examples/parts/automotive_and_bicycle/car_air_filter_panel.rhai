// Panel engine air filter 250 x 180 x 44 mm: 3 mm frame, 6 mm gasket flange, 85 pleats 2.75 mm apart and 38 mm deep
let pitch = 2.75; // [2.0, 4.0] Pleat pitch (mm)
let wall = box_centered(234.0, 164.0, 44.0).translate([0, 0, 22.0]) - box_centered(228.0, 158.0, 50.0).translate([0, 0, 22.0]);
let gasket = box_centered(250.0, 180.0, 6.0).translate([0, 0, 41.0]) - box_centered(228.0, 158.0, 10.0).translate([0, 0, 41.0]);
let n = (231.0 / pitch).to_int() + 1;
let top = [];
let bottom = [];
for i in 0..n {
    let x = -114.5 + i.to_float() * pitch;
    let z = if i % 2 == 0 { 3.0 } else { 40.0 };
    top.push([x, 0, z + 0.8]);
    bottom.push([x, 0, z]);
}
top.reverse();
let pleats = polygon(bottom + top).to_face().extrude([0, 158.4, 0]).translate([0, -79.2, 0]);
fuse_all([wall, gasket, pleats])
