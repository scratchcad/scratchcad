// Slide-in T-nut for 2020 aluminium extrusion (6 mm slot), M5: 10 mm long, 10 mm wide wings 1.8 mm thick, 6 mm neck, 4 mm overall height, 45 deg undercut flanks
let length = 10.0; // [6.0, 30.0] Length along the slot (mm)
let wing_width = 10.0; // [8.0, 16.0] Wing width (mm)
let neck_width = 5.8; // [4.0, 8.0] Neck width for the slot (mm)
let height = 4.0; // [3.0, 8.0] Overall height (mm)
let thread_diameter = 5.0; // [3.0, 6.0] Thread size (mm)
let wy = wing_width / 2.0;
let ny = min(neck_width / 2.0, wy - 1.0);
let wing_top = height * 0.55;
let flank = min(wy - ny, wing_top);
let profile = polygon([[0, -ny, height], [0, ny, height], [0, ny, wing_top], [0, wy, wing_top], [0, wy, wing_top - 0.5], [0, wy - flank, 0], [0, -wy + flank, 0], [0, -wy, wing_top - 0.5], [0, -wy, wing_top], [0, -ny, wing_top]]);
let nut = profile.to_face().extrude([length, 0, 0]);
let tap = thread_diameter * 0.84;
nut - cylinder([length / 2.0, 0, -1], "Z", tap / 2.0, height + 2.0) - cone(thread_diameter / 2.0 + 0.2, tap / 2.0, 0.5).translate([length / 2.0, 0, height - 0.49]).mirror([length / 2.0, 0, height - 0.245], "Z")
