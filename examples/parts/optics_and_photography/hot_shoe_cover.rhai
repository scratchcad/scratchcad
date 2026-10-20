// ISO 518 hot-shoe cover: 18.4 mm wide, 1.9 mm thick insert tongue 17 mm long, 12 mm neck, 20 x 15 mm cap 5 mm tall with grip ribs and a pull lip
let tongue_width = 18.4; // [17.5, 18.6] Tongue width (mm)
let tongue_length = 17.0; // [12.0, 18.0] Tongue length (mm)
let tongue_thickness = 1.9; // [1.5, 2.0] Tongue thickness (mm)
let cap_height = 5.0; // [3.0, 8.0] Cap height (mm)
let rib_count = 5; // [0, 8] Number of grip ribs
let tongue = box_from_corners([-tongue_width / 2.0, 0, 0], [tongue_width / 2.0, tongue_length, tongue_thickness]).chamfer(0.3, "|Z and <Y");
let neck = box_from_corners([-6.0, 0, tongue_thickness - 0.1], [6.0, tongue_length, tongue_thickness + 1.6]);
let cap = box_from_corners([-10.0, -1.0, tongue_thickness + 1.5], [10.0, tongue_length + 1.0, tongue_thickness + 1.5 + cap_height]).fillet(1.5, "|Z").fillet(0.8, ">Z");
let lip = box_from_corners([-8.0, -2.5, tongue_thickness + 1.5 + cap_height - 2.0], [8.0, -0.5, tongue_thickness + 1.5 + cap_height]).fillet(0.6, "|Z and <Y");
let cover = fuse_all([tongue, neck, cap, lip]);
let top = tongue_thickness + 1.5 + cap_height;
let grooves = [];
for i in 0..rib_count {
    grooves.push(box_centered(14.0, 0.8, 1.0).translate([0, 3.0 + i.to_float() * 2.4, top]));
}
if rib_count > 0 { cover = cover - compound(grooves); }
cover
