// Engine hook for 18 mm motors: 70 mm spring steel style strip 6 mm wide 0.8 mm, 3 mm lip at the aft end
let length = 70.0; // [50.0, 100.0] Hook length (mm)
let width = 6.0; // [4.0, 8.0] Width (mm)
let t = 0.8; // [0.5, 1.5] Thickness (mm)
let strip = box_from_corners([0, -width / 2.0, 0], [t, width / 2.0, length]);
let lip = box_from_corners([0, -width / 2.0, -t], [4.0, width / 2.0, 0.01]);
let tab = box_from_corners([-3.0, -width / 2.0, length - t], [0.01, width / 2.0, length]);
strip + lip + tab
