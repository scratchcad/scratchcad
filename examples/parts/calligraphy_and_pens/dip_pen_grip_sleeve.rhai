// Dip pen cork-style grip sleeve: 45 mm long, 14 mm waist and 16 mm front bulge (straight-segment profile), 8 mm bore for a straight holder
let length = 45.0; // [30.0, 60.0] Grip length (mm)
let bulge = 16.0; // [13.0, 20.0] Front bulge diameter (mm)
let bore = 8.0; // [6.0, 10.0] Holder bore (mm)
let prof = polygon([[bore / 2.0, 0, 0], [bulge / 2.0 - 1.5, 0, 0], [bulge / 2.0, 0, 6.0], [bulge / 2.0, 0, 12.0], [7.0, 0, 24.0], [7.0, 0, length - 4.0], [7.5, 0, length], [bore / 2.0, 0, length]]);
face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0)
