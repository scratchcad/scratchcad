// 250 ml (1 metric cup) measuring cup: 70 mm inside diameter, 65 mm to the 250 ml line plus 5 mm freeboard, 2 mm wall, pouring lip, 25 mm loop handle, raised 50 ml graduation ribs
let capacity = 250.0; // [100.0, 1000.0] Capacity to the top line (ml)
let inside_diameter = 70.0; // [50.0, 120.0] Inside diameter (mm)
let wall = 2.0; // [1.5, 4.0] Wall thickness (mm)
let freeboard = 5.0; // [2.0, 15.0] Height above the top line (mm)
let ri = inside_diameter / 2.0;
let fill_height = capacity * 1000.0 / (PI() * ri * ri);
let h = fill_height + freeboard + wall;
print(`fill height ${fill_height} mm`);
let cup = cylinder(ri + wall, h).fillet(3.0, "%CIRCLE and <Z");
// pouring lip: a wedge raised on the rim opposite the handle
let lip = polygon("XZ", [[ri - 1.0, h - 6.0], [ri + wall + 6.0, h + 1.0], [ri + wall + 6.0, h + 2.5], [ri - 1.0, h]]).to_face().extrude([0, 16.0, 0]).translate([0, -8.0, 0]);
cup = cup + (lip & cylinder(ri + wall + 6.0, h + 3.0));
cup -= cylinder([0, 0, wall], "Z", ri, h + 5.0);
cup = cup.fillet(1.5, cup.edges("%CIRCLE").filter(|e| (e.radius() - ri).abs() < 0.01 && e.center().z < wall + 0.1));
// loop handle on the -X side
let hx = -(ri + wall);
let handle = box_from_corners([hx - 28.0, -6.0, h - 48.0], [hx + 1.0, 6.0, h - 4.0]) - box_from_corners([hx - 22.0, -7.0, h - 42.0], [hx - 0.5, 7.0, h - 10.0]);
handle = handle.fillet(2.0, "|Y");
cup = cup + handle;
// graduation ribs every 50 ml on the inside wall facing the handle
let n = (capacity / 50.0).floor().to_int();
for i in 1..=n {
    let z = wall + i.to_float() * 50000.0 / (PI() * ri * ri);
    cup += box_centered(1.2, 10.0, 0.8).translate([-ri + 0.4, 0, z]);
}
cup
