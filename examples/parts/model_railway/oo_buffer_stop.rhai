// OO scale (1:76) rail-built buffer stop: 30 mm wide, 18 mm tall beam, two 3 mm buffers, raking struts
let width = 30.0; // [25.0, 40.0] Width (mm)
let height = 18.0; // [12.0, 25.0] Beam height (mm)
let beam = box_from_corners([-width / 2.0, 0, height - 4.0], [width / 2.0, 3.0, height]);
let posts = box_from_corners([-12.0, 0, 0], [-10.0, 3.0, height]) + box_from_corners([10.0, 0, 0], [12.0, 3.0, height]);
let struts = [];
for x in [-11.0, 11.0] { struts.push(box_from_corners([x - 1.0, 0, -1.0], [x + 1.0, 2.0, height * 1.3]).rotate([x, 0, 0], "X", -35.0) & box_from_corners([-width, 0, 0], [width, 30.0, height])); }
let buffers = cylinder([-8.5, -3.0, height - 2.0], "Y", 1.5, 3.01) + cylinder([8.5, -3.0, height - 2.0], "Y", 1.5, 3.01) + cylinder([-8.5, -3.6, height - 2.0], "Y", 2.0, 0.6) + cylinder([8.5, -3.6, height - 2.0], "Y", 2.0, 0.6);
beam + posts + fuse_all(struts) + buffers
