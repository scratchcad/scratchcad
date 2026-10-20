// Y hose splitter: 3/4 in GHT female inlet 30 mm body, two 16 mm outlets at 30 degrees, 12 mm bore
let inlet_d = 30.0; // [25.0, 40.0] Inlet body diameter (mm)
let outlet_d = 16.0; // [12.0, 22.0] Outlet diameter (mm)
let bore = 12.0; // [8.0, 16.0] Bore (mm)
let spread = 30.0; // [15.0, 45.0] Outlet angle from axis (degrees)
let inlet = cylinder([0, 0, -25.0], "Z", inlet_d / 2.0, 25.0) - cylinder([0, 0, -26.0], "Z", inlet_d / 2.0 - 3.0, 18.0);
let hub = sphere([0, 0, 0], outlet_d / 2.0 + 3.0);
let arm = cylinder([0, 0, 0], "Z", outlet_d / 2.0, 45.0);
let arms = arm.rotate_y(spread) + arm.rotate_y(-spread);
let bores = cylinder([0, 0, -10.0], "Z", bore / 2.0, 12.0) + cylinder([0, 0, 0], "Z", bore / 2.0 - 2.0, 46.0).rotate_y(spread) + cylinder([0, 0, 0], "Z", bore / 2.0 - 2.0, 46.0).rotate_y(-spread);
inlet + hub + arms - bores - cylinder([0, 0, -26.0], "Z", bore / 2.0, 26.0)
