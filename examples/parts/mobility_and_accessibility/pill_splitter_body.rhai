// Pill splitter body: 70 x 35 x 14 mm base with a 90 degree V-cradle 6 mm deep for tablets up to 12 mm, a 0.8 mm blade slot across the middle and a 20 mm thumb recess
// # Body
let length = 70.0; // [55.0, 90.0] Body length (mm)
let width = 35.0; // [28.0, 45.0] Body width (mm)
let height = 14.0; // [10.0, 20.0] Body height (mm)
// # Cradle
let v_depth = 6.0; // [3.0, 8.0] V-cradle depth (mm)
let blade_slot = 0.8; // [0.5, 1.5] Blade slot width (mm)
let base = box_centered(length, width, height).translate([0, 0, height / 2.0]).fillet(4.0, "|Z");
let vee = polygon("YZ", [[-v_depth - 1.0, height + 1.0], [0.0, height - v_depth], [v_depth + 1.0, height + 1.0]]).to_face().extrude([length * 0.7, 0, 0]).translate([-length * 0.35, 0, 0]);
let slot = box_centered(blade_slot, width + 2.0, height).translate([0, 0, height - 1.5]);
let thumb = cylinder([length / 2.0 - 2.0, 0, height + 6.0], "Y", 12.0, width + 2.0).translate([0, -width / 2.0 - 1.0, 0]);
base - vee - slot - thumb
