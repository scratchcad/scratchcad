// Fertilizer spreader flow rate shutter slide: 3 mm plate 140 x 70 mm with a tapered metering aperture 60 mm long opening from 8 mm to 40 mm wide, two 8.5 mm wide guide slots 30 mm long for the M8 guide bolts, and a 25 mm high lever lip along one end
let length = 140.0; // [100.0, 200.0] Slide length (mm)
let width = 70.0; // [50.0, 100.0] Slide width (mm)
let aperture_len = 60.0; // [40.0, 90.0] Aperture length (mm)
let aperture_max = 40.0; // [20.0, 60.0] Aperture wide end (mm)
let lip_h = 25.0; // [12.0, 40.0] Lever lip height (mm)
const t = 3.0;
const narrow = 8.0;
const slot_w = 8.5;
const slot_len = 30.0;
let am = min(aperture_max, width - 20.0);
let al = min(aperture_len, length - slot_len - 40.0);
let plate = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, t]);
let lip = box_from_corners([length - t, -width / 2.0, t - 0.5], [length, width / 2.0, lip_h]);
let slide = plate + lip;
let x0 = 15.0 + slot_len;
let aperture = polygon([[x0, -narrow / 2.0, -1.0], [x0 + al, -am / 2.0, -1.0], [x0 + al, am / 2.0, -1.0], [x0, narrow / 2.0, -1.0]]).to_face().extrude([0, 0, t + 2.0]);
let sr = slot_w / 2.0;
let cutters = [aperture];
for y in [-width / 2.0 + 8.0, width / 2.0 - 8.0] {
    cutters.push(fuse_all([
        box_from_corners([8.0, y - sr, -1.0], [8.0 + slot_len, y + sr, t + 1.0]),
        cylinder([8.0, y, -1.0], "Z", sr, t + 2.0),
        cylinder([8.0 + slot_len, y, -1.0], "Z", sr, t + 2.0),
    ]));
}
slide - fuse_all(cutters)
