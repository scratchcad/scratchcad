// Z-clip tabletop fastener: 32 x 19 mm, 1.6 mm steel, 6 mm offset, 4.5 mm screw slot 10 mm long
let width = 19.0; // [15.0, 25.0] Width (mm)
let t = 1.6; // [1.2, 2.5] Thickness (mm)
let offset = 6.0; // [4.0, 10.0] Step height (mm)
let top = box_from_corners([0, 0, offset], [16.0, width, offset + t]) - box_from_corners([4.0, width / 2.0 - 2.25, offset - 1.0], [14.0, width / 2.0 + 2.25, offset + t + 1.0]);
let web = box_from_corners([16.0 - t, 0, 0], [16.0, width, offset + t]);
let foot = box_from_corners([16.0 - t, 0, 0], [26.0, width, t]);
top + web + foot
