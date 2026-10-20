// Chainline gauge ruler: 150 x 20 x 3 mm plate with a 12 mm tall end stop 4 mm thick that butts against the seat tube, 0.6 mm wide tick grooves 0.5 mm deep every 5 mm (long ticks every 10 mm) along the top edge
let length = 150.0; // [80.0, 200.0] Ruler length (mm)
let width = 20.0; // [15.0, 30.0] Ruler width (mm)
let thickness = 3.0; // [2.0, 5.0] Ruler thickness (mm)
let stop_h = 12.0; // [6.0, 20.0] End stop height (mm)
const stop_t = 4.0;
const tick_w = 0.6;
let plate = box_from_corners([0, 0, 0], [length, width, thickness]);
let stop = box_from_corners([-stop_t, 0, 0], [0.5, width, stop_h]);
let ruler = plate + stop;
let ticks = [];
let n = ((length - 5.0) / 5.0).to_int();
for i in 1..=n {
    let x = i.to_float() * 5.0;
    let l = if i % 2 == 0 { 8.0 } else { 4.0 };
    ticks.push(box_from_corners([x - tick_w / 2.0, width - l, thickness - 0.5], [x + tick_w / 2.0, width + 1.0, thickness + 1.0]));
}
ruler - fuse_all(ticks)
