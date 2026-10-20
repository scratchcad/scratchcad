// Dishwasher lower rack wheel: 25 mm wheel 10 mm wide with a 4 mm axle snap and 2 mm wire clip slot
let diameter = 25.0; // [18.0, 35.0] Wheel diameter (mm)
let width = 10.0; // [6.0, 14.0] Width (mm)
let axle = 4.0; // [3.0, 6.0] Axle diameter (mm)
let w = cylinder(diameter / 2.0, width);
let ww = w.fillet(1.5, w.edges("%CIRCLE").filter(|e| e.radius() > diameter / 2.0 - 0.01));
let hub_recess = cylinder([0, 0, width - 2.0], "Z", diameter / 2.0 - 3.0, 3.0) - cylinder([0, 0, width - 3.0], "Z", axle / 2.0 + 2.0, 5.0);
let back = cylinder([0, 0, -1], "Z", diameter / 2.0 - 3.0, 3.0) - cylinder([0, 0, -2], "Z", axle / 2.0 + 2.0, 5.0);
ww - hub_recess - back - cylinder([0, 0, -1], "Z", axle / 2.0, width + 2.0)
