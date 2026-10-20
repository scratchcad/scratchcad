// Slotted kitchen turner (fish slice): 90 x 110 mm blade 2 mm thick with five 6 mm slots and a 1 mm bevelled front, 40 mm neck rising 15 deg, 150 mm handle 24 x 12 mm with a 6 mm hanging hole
let blade_width = 90.0; // [60.0, 120.0] Blade width (mm)
let blade_length = 110.0; // [80.0, 150.0] Blade length (mm)
let blade_thickness = 2.0; // [1.0, 3.0] Blade thickness (mm)
let slot_count = 5; // [0, 8] Number of slots
let neck_angle = 15.0; // [0.0, 30.0] Neck rise (deg)
let handle_length = 150.0; // [100.0, 220.0] Handle length (mm)
let bw = blade_width / 2.0;
let blade = box_from_corners([0, -bw, 0], [blade_length, bw, blade_thickness]).fillet(12.0, "|Z and >X").fillet(4.0, "|Z and <X");
blade = blade.chamfer(1.0, blade.edges(">Z").filter(|e| e.center().x > blade_length - 15.0));
// slots: rounded, running front to back
let n = slot_count;
for i in 0..n {
    let y = (i.to_float() - (n - 1).to_float() / 2.0) * (blade_width - 24.0) / (n - 1).max(1).to_float();
    blade -= face(rect(blade_length - 40.0, 0.1).offset(3.0)).extrude([0, 0, blade_thickness + 2.0]).translate([blade_length / 2.0 + 4.0, y, -1.0]);
}
// neck: a bar from the back of the blade rising at the neck angle
const neck_len = 40.0;
let a = neck_angle * PI() / 180.0;
let neck = box_from_corners([-neck_len - 2.0, -8.0, 0], [6.0, 8.0, blade_thickness + 1.0]).rotate([0, 0, 0], "Y", neck_angle);
let hx = -neck_len * a.cos() - 2.0;
let hz = neck_len * a.sin();
let handle = box_from_corners([-handle_length, -12.0, -6.0], [0, 12.0, 6.0]).fillet(5.5, "|X").fillet(4.0, "<X");
handle = handle - cylinder([-handle_length + 14.0, 0, -8.0], "Z", 3.0, 16.0);
let placed = handle.rotate("Y", neck_angle).translate([hx + 6.0, 0, hz + 1.5]);
fuse_all([blade, neck, placed])
