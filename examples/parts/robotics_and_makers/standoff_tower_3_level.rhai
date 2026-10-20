// Three-deck robot electronics tower: 100 x 70 mm 3 mm acrylic decks with rounded corners and a 25 mm wiring hole, joined by M3 x 25 mm hex standoffs on an 88 x 58 mm pattern
let deck_l = 100.0; // [60.0, 150.0] Deck length (mm)
let deck_w = 70.0; // [40.0, 120.0] Deck width (mm)
let gap = 25.0; // [10.0, 50.0] Standoff length (mm)
let levels = 3; // [2, 5] Number of decks
const t = 3.0;
const af = 5.5;
let px = deck_l / 2.0 - 6.0;
let py = deck_w / 2.0 - 6.0;
let rc = af / sqrt(3.0);
let hp = [];
for i in 0..6 { let a = (i.to_float() * 60.0 + 30.0) * PI() / 180.0; hp.push([rc * a.cos(), rc * a.sin()]); }
let hex = polygon(hp).to_face().extrude([0, 0, gap]) - cylinder([0, 0, -1], "Z", 1.25, gap + 2.0);
let deck = box_centered(deck_l, deck_w, t).translate([0, 0, t / 2.0]).fillet(6.0, "|Z") - cylinder([0, 0, -1], "Z", 12.5, t + 2.0);
for x in [-1.0, 1.0] { for y in [-1.0, 1.0] { deck -= cylinder([x * px, y * py, -1], "Z", 1.6, t + 2.0); } }
deck -= box_centered(30.0, 4.0, 10.0).translate([0, py, 0]) + box_centered(30.0, 4.0, 10.0).translate([0, -py, 0]);
let parts = [];
for k in 0..levels {
    let z = k.to_float() * (gap + t);
    parts.push(deck.translate([0, 0, z]));
    if k < levels - 1 {
        for x in [-1.0, 1.0] { for y in [-1.0, 1.0] { parts.push(hex.translate([x * px, y * py, z + t])); } }
    }
}
compound(parts)
