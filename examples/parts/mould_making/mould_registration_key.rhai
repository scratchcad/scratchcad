// Two-part mould registration key: 12 mm conical key 6 mm tall on a 16 mm base 2 mm, with a matching socket block 20 x 20 x 8 mm (2 bodies)
let key = 12.0; // [8.0, 20.0] Key base diameter (mm)
let height = 6.0; // [4.0, 10.0] Key height (mm)
let k = cylinder([0, 0, 0], "Z", key / 2.0 + 2.0, 2.0) + cone(key / 2.0, key / 2.0 - height * 0.4, height).translate([0, 0, 1.99]);
let socket = box_centered(key + 8.0, key + 8.0, height + 2.0).translate([key + 12.0, 0, (height + 2.0) / 2.0]) - cone(key / 2.0 + 0.2, key / 2.0 - height * 0.4 + 0.2, height + 0.01).translate([key + 12.0, 0, 2.0]);
compound([k, socket])
