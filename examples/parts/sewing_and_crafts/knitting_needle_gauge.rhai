// Knitting needle gauge: 80 x 50 x 2 mm card with holes 2.0 to 10.0 mm and a 2 in ruler window
let width = 80.0; // [60.0, 120.0] Width (mm)
let height = 50.0; // [40.0, 80.0] Height (mm)
let thickness = 2.0; // [1.0, 4.0] Thickness (mm)
let card = box(width, height, thickness);
let c = card.fillet(5.0, card.edges("|Z"));
let sizes = [2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 8.0, 9.0, 10.0];
let holes = [];
for i in 0..sizes.len() {
    let d = sizes[i];
    let row = if i < 8 { 0 } else { 1 };
    let xx = if i < 8 { 6.0 + i.to_float() * 9.5 } else { 8.0 + (i - 8).to_float() * 12.0 };
    holes.push(cylinder([xx, 36.0 - row.to_float() * 16.0, -1], "Z", d / 2.0, thickness + 2.0));
}
c - compound(holes) - box_from_corners([8.0, 5.0, -1], [8.0 + 50.8, 10.0, thickness + 1.0])
