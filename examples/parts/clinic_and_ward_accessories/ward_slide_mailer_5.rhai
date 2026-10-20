// Microscope slide mailer for five 75 x 25 x 1 mm slides: 84 x 32 x 30 mm body, slides stand on their long edge in five 1.4 mm slots at 5 mm pitch, 2 mm walls and a 20 mm finger relief across the middle
let slides = 5; // [2, 10] Number of slides
let slot_w = 1.4; // [1.2, 2.0] Slot width (mm)
let pitch = 5.0; // [3.5, 8.0] Slot pitch (mm)
const t = 2.0;
const len = 84.0;
const h = 30.0;
let w = slides.to_float() * pitch + 2.0 * t + 2.0;
let b = box_from_corners([0, 0, 0], [len, w, h]);
let cuts = [box_from_corners([t, t, h - 6.0], [len - t, w - t, h + 1.0]), box_from_corners([len / 2.0 - 10.0, -1.0, h - 12.0], [len / 2.0 + 10.0, w + 1.0, h + 1.0])];
for i in 0..slides {
    let y = t + 1.0 + pitch * (i.to_float() + 0.5);
    cuts.push(box_from_corners([(len - 76.0) / 2.0, y - slot_w / 2.0, t], [(len + 76.0) / 2.0, y + slot_w / 2.0, h + 1.0]));
}
b - fuse_all(cuts)
