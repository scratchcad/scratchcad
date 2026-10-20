// Mirror clip for 6 mm glass: 20 mm wide clip, 3 mm base plate, a riser and a 6 mm lip 0.5 mm clear of the glass face, over the glass edge and a countersunk 4 mm screw hole
let glass = 6.0; // [3.0, 10.0] Glass thickness (mm)
let width = 20.0; // [14.0, 30.0] Clip width (mm)
const t = 3.0;
let base = box_from_corners([0, 0, 0], [16.0, width, t]);
let riser = box_from_corners([16.0 - 0.01, 0, 0], [19.0, width, glass + 0.5 + t]);
let lip = box_from_corners([19.0 - 0.01, 0, glass + 0.5], [25.0, width, glass + 0.5 + t]);
let c = base + riser + lip;
c - cylinder([7.0, width / 2.0, -1.0], "Z", 2.0, t + 2.0) - cone(2.0, 4.0, 2.0).translate([7.0, width / 2.0, t - 1.99])
