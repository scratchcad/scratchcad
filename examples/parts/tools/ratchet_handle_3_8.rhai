// 3/8 in drive ratchet: 40 mm round head 12 mm thick with 9.53 mm square drive and reversing lever, 200 mm handle with a hang hole
let len = 200.0; // [150.0, 300.0] Length (mm)
let head = cylinder([0, 0, -6.0], "Z", 20.0, 12.0).chamfer(1.0, ">Z or <Z");
let neck = polygon([[0, -14], [40, -9], [40, 9], [0, 14]]).to_face().extrude(10.0).translate([0, 0, -5.0]);
let handle = box_from_corners([38.0, -9.0, -6.0], [len, 9.0, 6.0]).fillet(4.0, "|X") - cylinder([len - 10.0, 0, -7.0], "Z", 4.0, 14.0);
let drive = box_centered(9.53, 9.53, 12.0).translate([0, 0, -12.0]).chamfer(0.5, "<Z");
let lever = box_from_corners([-4.0, -14.0, 6.0], [4.0, -2.0, 9.0]).fillet(1.0, "|Z");
fuse_all([head, neck, handle, drive, lever])
