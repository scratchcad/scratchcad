// Twin hydraulic hose clamp block half: 60 x 30 x 15 mm half block with two 20 mm hose saddles on 30 mm centres and an M8 clamp bolt hole between them (print two halves)
let hose = 20.0; // [12.0, 26.0] Hose OD (mm)
let pitch = 30.0; // [24.0, 40.0] Hose spacing (mm)
let length = pitch + hose + 10.0;
let b = box_centered(length, 30.0, 15.0).translate([0, 0, 7.5]);
let saddles = cylinder([-pitch / 2.0, -16.0, 15.0], "Y", hose / 2.0, 32.0) + cylinder([pitch / 2.0, -16.0, 15.0], "Y", hose / 2.0, 32.0);
b - saddles - cylinder([0, 0, -1.0], "Z", 4.25, 17.0) - cylinder([0, 0, -1.0], "Z", 7.0, 6.0)
