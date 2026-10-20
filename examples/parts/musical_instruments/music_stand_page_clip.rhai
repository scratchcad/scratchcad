// Music stand page clip: grips a 2 mm shelf lip, 60 mm spring arm, 25 mm wide, 2 mm thick
let lip = 2.0; // [1.0, 5.0] Shelf lip thickness (mm)
let arm = 60.0; // [40.0, 90.0] Arm length (mm)
let width = 25.0; // [15.0, 35.0] Width (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let back = box_from_corners([0, 0, 0], [t, width, 20.0]);
let top = box_from_corners([0, 0, 20.0 - t], [t * 2.0 + lip, width, 20.0]);
let front = box_from_corners([t + lip, 0, 10.0], [t * 2.0 + lip, width, 20.0]);
let page_arm = box_from_corners([0, 0, -arm], [t, width, 0.01]).rotate([t, 0, 0], "Y", -6.0);
back + top + front + page_arm
