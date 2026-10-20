// Gravity gate latch, assembled: 200 mm x 25 mm x 5 mm drop bar on a pinned 60 x 40 mm pivot plate, U keeper with a lead-in ramp, thumb knob
let bar_length = 200.0; // [120.0, 300.0] Bar length (mm)
let bar_width = 25.0; // [18.0, 35.0] Bar width (mm)
let bar_thickness = 5.0; // [3.0, 8.0] Bar thickness (mm)
let pin_diameter = 10.0; // [6.0, 14.0] Pivot pin diameter (mm)
const plate_t = 4.0;
let hw = bar_width / 2.0;
let z0 = plate_t + 2.0;
let z1 = z0 + bar_thickness;
let rp = pin_diameter / 2.0;
// pivot plate with pin and head
let plate = box_from_corners([-30.0, -20.0, 0], [30.0, 20.0, plate_t]).fillet(4.0, "|Z");
plate -= cylinder([-20.0, 0, -1.0], "Z", 2.5, plate_t + 2.0);
plate -= cylinder([20.0, 0, -1.0], "Z", 2.5, plate_t + 2.0);
let pivot = fuse_all([plate, cylinder([0, 0, plate_t - 0.1], "Z", rp, z1 + 1.1 - plate_t), cylinder([0, 0, z1 + 1.0], "Z", rp + 3.0, 2.0)]);
// drop bar with knob
let bar = box_from_corners([-15.0, -hw, z0], [bar_length, hw, z1]).fillet(hw * 0.9, "|Z and <X");
bar -= cylinder([0, 0, z0 - 1.0], "Z", rp + 0.6, bar_thickness + 2.0);
bar += cylinder([bar_length - 50.0, 0, z1 - 0.1], "Z", 6.0, 20.0).fillet(2.0, ">Z");
// keeper: plate and a U hook around the bar end
let kx = bar_length - 25.0;
let hook = polygon([[kx, -hw - 8.0, 0], [kx, hw + 12.0, 0], [kx, hw + 12.0, z0 - 1.0], [kx, -hw - 1.0, z0 - 1.0], [kx, -hw - 1.0, z1 + 1.0],
                    [kx, hw + 5.0, z1 + 1.0], [kx, hw + 12.0, z1 + 7.0], [kx, hw + 12.0, z1 + 10.0], [kx, hw + 3.5, z1 + 5.0],
                    [kx, -hw - 8.0, z1 + 5.0]]).to_face().extrude([12.0, 0, 0]);
let kplate = box_from_corners([kx - 8.0, -hw - 25.0, 0], [kx + 20.0, hw + 25.0, plate_t]).fillet(3.0, "|Z");
let keeper = fuse_all([kplate, hook]) - cylinder([kx + 6.0, -hw - 17.0, -1.0], "Z", 2.5, plate_t + 2.0) - cylinder([kx + 6.0, hw + 18.0, -1.0], "Z", 2.5, plate_t + 2.0);
compound([pivot, bar, keeper])
