// Face-mount joist hanger for a 2x8 (38 x 184 mm) joist: 1.2 mm galvanised steel seat 38 mm wide, 51 mm flanges, nail holes on a 25 mm grid
let jw = 38.0; // [38.0, 89.0] Joist width (mm)
let jh = 184.0; // [140.0, 286.0] Joist height (mm)
const t = 1.2;
let seat = box_from_corners([-jw / 2.0 - t, 0, 0], [jw / 2.0 + t, 50.0, t]);
let sides = [box_from_corners([-jw / 2.0 - t, 0, 0], [-jw / 2.0, 50.0, jh * 0.85]), box_from_corners([jw / 2.0, 0, 0], [jw / 2.0 + t, 50.0, jh * 0.85])];
let flanges = [box_from_corners([-jw / 2.0 - 51.0, 0, 0], [-jw / 2.0, t, jh * 0.85]), box_from_corners([jw / 2.0, 0, 0], [jw / 2.0 + 51.0, t, jh * 0.85])];
let h = fuse_all([seat] + sides + flanges);
let nails = [];
let rows = (jh * 0.85 / 25.0).to_int();
for k in 1..rows { for x in [-jw / 2.0 - 15.0, -jw / 2.0 - 40.0, jw / 2.0 + 15.0, jw / 2.0 + 40.0] { nails.push(cylinder([x, -1, k.to_float() * 25.0], "Y", 2.2, 3.0)); } }
h - compound(nails)
