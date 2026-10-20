// Boat trailer keel roller: 200 mm long V-roller, 75 mm end diameter waisting to 50 mm at the centre (straight-segment profile), 22 mm spindle bore with 26 mm bushing counterbores
let length = 200.0; // [120.0, 300.0] Roller length (mm)
let end_d = 75.0; // [60.0, 100.0] End diameter (mm)
let mid_d = 50.0; // [35.0, 58.0] Waist diameter (mm)
const bore = 22.0;
let h = length / 2.0;
let prof = polygon([[bore / 2.0, 0, -h], [end_d / 2.0, 0, -h], [end_d / 2.0, 0, -h + 10.0], [mid_d / 2.0, 0, -15.0], [mid_d / 2.0, 0, 15.0], [end_d / 2.0, 0, h - 10.0], [end_d / 2.0, 0, h], [bore / 2.0, 0, h]]);
let r = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
r - cylinder([0, 0, -h - 1.0], "Z", 13.0, 21.0) - cylinder([0, 0, h - 20.0], "Z", 13.0, 21.0)
