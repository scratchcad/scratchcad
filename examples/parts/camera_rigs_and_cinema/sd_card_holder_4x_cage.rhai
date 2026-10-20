// Media card holder for a camera cage: 4 SD card slots (24.5 x 2.6 mm, 18 mm deep) on 6 mm pitch in a 32 x 30 x 22 mm block with 1 mm chamfers, 10 mm finger notch across the front so cards can be pinched out, 1/4-20 tapped hole (5.1 mm core) 8 mm deep underneath
let slots = 4; // [1, 8] Number of card slots
let card_w = 24.5; // [21.0, 33.0] Card width (mm)
let card_t = 2.6; // [1.2, 3.8] Card slot thickness (mm)
const pitch = 6.0;
const depth = 18.0;
let length = slots.to_float() * pitch + 8.0;
let width = card_w + 5.5;
let height = depth + 4.0;
let block = box_from_corners([0, -width / 2.0, 0], [length, width / 2.0, height]);
let block = block.chamfer(1.0, block.edges(">Z"));
let cuts = [];
for i in 0..slots {
    let x = 4.0 + pitch * (i.to_float() + 0.5);
    cuts.push(box_from_corners([x - card_t / 2.0, -card_w / 2.0, height - depth], [x + card_t / 2.0, card_w / 2.0, height + 1.0]));
}
cuts.push(cylinder([-1.0, 0, height + 1.0], "X", 5.0, length + 2.0));
cuts.push(cylinder([length / 2.0, 0, -1.0], "Z", 2.55, 9.0));
block - fuse_all(cuts)
