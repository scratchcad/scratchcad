// Catering trolley corner bumper wheel: 75 mm rubber roller 25 mm wide with 2 mm chamfers, 30 mm hub 28 mm long and a 10.5 mm bore for an M10 bolt
let dia = 75.0; // [50.0, 100.0] Wheel diameter (mm)
let width = 25.0; // [15.0, 40.0] Wheel width (mm)
let bore = 10.5; // [8.5, 12.5] Bolt bore (mm)
const hub_d = 30.0;
let r = dia / 2.0;
let rb = bore / 2.0;
let hl = width + 3.0;
let e = (hl - width) / 2.0;
face(polygon([[rb, 0, 0], [hub_d / 2.0, 0, 0], [hub_d / 2.0, 0, e], [r - 2.0, 0, e], [r, 0, e + 2.0], [r, 0, e + width - 2.0], [r - 2.0, 0, e + width], [hub_d / 2.0, 0, e + width], [hub_d / 2.0, 0, hl], [rb, 0, hl]])).revolve("Z", 360)
