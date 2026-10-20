// 35 mm film core: 2 in (50.8 mm) plastic core 35 mm wide, 25.4 mm (1 in) bore with a 6 x 3 mm drive keyway in a 5 mm hub, 3 mm web between inner and outer rings, film slot 1.2 mm wide 10 mm deep
let od = 50.8; // [40.0, 76.2] Core outside diameter (mm)
let width = 35.0; // [16.0, 70.0] Core width (mm)
let bore = 25.4; // [20.0, 30.0] Center bore (mm)
let web = 3.0; // [2.0, 6.0] Web thickness (mm)
let outer_ring = cylinder(od / 2.0, width) - cylinder([0, 0, -1.0], "Z", od / 2.0 - 2.5, width + 2.0);
let inner_ring = cylinder(bore / 2.0 + 5.0, width) - cylinder([0, 0, -1.0], "Z", bore / 2.0, width + 2.0);
let w = cylinder([0, 0, (width - web) / 2.0], "Z", od / 2.0 - 2.4, web);
let key = box_from_corners([-3.0, bore / 2.0 - 1.0, -1.0], [3.0, bore / 2.0 + 3.0, width + 1.0]);
let slot = box_from_corners([od / 2.0 - 10.0, -0.6, -1.0], [od / 2.0 + 1.0, 0.6, width + 1.0]).rotate_z(20.0);
let c = (outer_ring + inner_ring + w) - cylinder([0, 0, -1.0], "Z", bore / 2.0, width + 2.0);
c - key - slot
