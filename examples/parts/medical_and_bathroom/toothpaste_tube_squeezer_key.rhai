// Toothpaste tube squeezer key: 10 mm shaft 65 mm long with a 2.2 mm slot 55 mm long for the tube end, 40 mm wing handle
let shaft_diameter = 10.0; // [7.0, 15.0] Shaft diameter (mm)
let shaft_length = 65.0; // [40.0, 90.0] Shaft length (mm)
let slot_width = 2.2; // [1.2, 4.0] Slot width (mm)
let slot_length = 55.0; // [30.0, 80.0] Slot length (mm)
let handle_width = 40.0; // [25.0, 60.0] Handle width (mm)
let rs = shaft_diameter / 2.0;
let shaft = cylinder([0, 0, 0], "Z", rs, shaft_length).chamfer(0.8, "<Z");
let sl = min(slot_length, shaft_length - 6.0);
shaft -= box_centered(slot_width, 2.0 * rs + 2.0, sl + 1.0).translate([0, 0, (sl - 1.0) / 2.0]);
let hw = handle_width / 2.0;
let handle = sketch("XZ").move_to(-hw, shaft_length).arc_to(0, shaft_length - 4.0, hw, shaft_length).arc_to(hw + 2.0, shaft_length + 10.0, hw - 4.0, shaft_length + 18.0)
    .arc_to(0, shaft_length + 14.0, -hw + 4.0, shaft_length + 18.0).arc_to(-hw - 2.0, shaft_length + 10.0, -hw, shaft_length).close()
    .to_face().extrude([0, 6.0, 0]).translate([0, -3.0, -0.5]);
fuse_all([shaft, handle.fillet(1.5, "|Y")])
