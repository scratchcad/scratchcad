// Outboard transom saver yoke: 60 x 50 x 70 mm block with a 70 degree V notch 30 mm deep to cradle the lower unit, a 25.4 mm socket 30 mm deep underneath for the support bar with an M6 pin hole (6.4 mm), and 2 mm chamfers
let width = 60.0; // [45.0, 90.0] Yoke width (mm)
let notch_depth = 30.0; // [15.0, 40.0] Notch depth (mm)
let bar_d = 25.4; // [19.0, 32.0] Support bar diameter (mm)
let length = 50.0; // [30.0, 80.0] Yoke length (mm)
let height = notch_depth + bar_d + 15.0;
let block = box_centered(width, length, height).translate([0, 0, height / 2.0]);
let block = block.chamfer(2.0, block.edges("|Y"));
let half = min(notch_depth * tan(35.0 * PI() / 180.0), width / 2.0 - 6.0);
let v = face(polygon([[0, 0, height - notch_depth], [half + 10.0, 0, height + 10.0 * notch_depth / half], [-half - 10.0, 0, height + 10.0 * notch_depth / half]])).extrude([0, length + 2.0, 0]).translate([0, -length / 2.0 - 1.0, 0]);
let cuts = [v, cylinder([0, 0, -1.0], "Z", bar_d / 2.0 + 0.2, 31.0), cylinder([-width, 0, 15.0], "X", 3.2, 2.0 * width)];
block - fuse_all(cuts)
