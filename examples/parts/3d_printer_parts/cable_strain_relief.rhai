// Bed cable strain relief: 30 x 20 x 3 mm plate with 2 M3 holes and a 6 mm cable saddle 10 mm tall with zip-tie slots
let width = 30.0; // [20.0, 50.0] Plate width (mm)
let length = 20.0; // [15.0, 40.0] Plate length (mm)
let cable = 6.0; // [3.0, 12.0] Cable diameter (mm)
let plate = box_centered(width, length, 3.0).translate([0, 0, 1.5]).fillet(3.0, "|Z");
let saddle = box_centered(cable + 6.0, length, cable / 2.0 + 4.0).translate([0, 0, (cable / 2.0 + 4.0) / 2.0 + 2.99]);
let part = (plate + saddle) - cylinder([0, -length, cable / 2.0 + 5.0], "Y", cable / 2.0, length * 2.0);
for y in [-length * 0.25, length * 0.25] { part -= box_centered(cable + 10.0, 3.5, 1.5).translate([0, y, 4.0]); }
for s in [-1, 1] { part -= cylinder([s * (width / 2.0 - 4.0), 0, -1], "Z", 1.6, 5.0); }
part
