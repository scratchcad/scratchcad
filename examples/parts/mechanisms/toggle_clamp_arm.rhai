// Horizontal toggle clamp arm: 90 mm, 16 mm wide U-section, 2 mm steel, 6 mm pivot holes, M6 spindle slot
let length = 90.0; // [60.0, 140.0] Length (mm)
let width = 16.0; // [10.0, 25.0] Width (mm)
let height = 14.0; // [10.0, 20.0] Side height (mm)
let t = 2.0; // [1.5, 3.0] Steel thickness (mm)
let u = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]) - box_from_corners([-1, -width / 2.0 + t, -1], [length + 1.0, width / 2.0 - t, height - t]);
let rounded = box_from_corners([height / 2.0, -width, -1], [length + 1.0, width, height + 1.0]) + cylinder([height / 2.0, -width, height / 2.0], "Y", height / 2.0, 2.0 * width);
let ends = u & rounded;
ends - cylinder([height / 2.0, -width, height / 2.0 - 1.0], "Y", 3.0, width * 2.0) - cylinder([22.0, -width, height / 2.0 - 1.0], "Y", 3.0, width * 2.0) - box_from_corners([length - 40.0, -3.2, height - t - 1.0], [length - 6.0, 3.2, height + 1.0])
