// Telecaster control plate: 140 x 32 mm with 16 mm round ends, 2 mm thick, holes for a 3-way switch slot 15 x 3 mm and two 9.5 mm pot holes on 33 mm centres, two 2.5 mm screw holes
let length = 140.0; // [120.0, 160.0] Plate length (mm)
let pot_pitch = 33.0; // [25.0, 40.0] Pot spacing (mm)
const w = 32.0;
const t = 2.0;
let r = w / 2.0;
let p = box_from_corners([r, -r, 0], [length - r, r, t]) + cylinder([r, 0, 0], "Z", r, t) + cylinder([length - r, 0, 0], "Z", r, t);
let cuts = [box_from_corners([22.0, -1.5, -1.0], [37.0, 1.5, t + 1.0]) + cylinder([22.0, 0, -1.0], "Z", 1.5, t + 2.0) + cylinder([37.0, 0, -1.0], "Z", 1.5, t + 2.0)];
cuts.push(cylinder([length - 30.0 - pot_pitch, 0, -1.0], "Z", 4.75, t + 2.0));
cuts.push(cylinder([length - 30.0, 0, -1.0], "Z", 4.75, t + 2.0));
cuts.push(cylinder([6.0, 0, -1.0], "Z", 1.25, t + 2.0));
cuts.push(cylinder([length - 6.0, 0, -1.0], "Z", 1.25, t + 2.0));
p - fuse_all(cuts)
