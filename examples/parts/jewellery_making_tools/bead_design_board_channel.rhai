// Bead board section: 250 x 60 mm, 3 U-channels 6 mm wide 4 mm deep on 12 mm pitch, 30 mm compartment strip
let length = 250.0; // [150.0, 350.0] Length (mm)
let width = 60.0; // [40.0, 90.0] Width (mm)
let t = 8.0; // [6.0, 12.0] Thickness (mm)
let board = box_from_corners([0, 0, 0], [length, width, t]);
let b = board.fillet(6.0, board.edges("|Z"));
let channels = [];
for k in 0..3 { channels.push(box_from_corners([5.0, 8.0 + k.to_float() * 12.0, t - 4.0], [length - 5.0, 14.0 + k.to_float() * 12.0, t + 1.0])); }
let wells = [];
for k in 0..8 { wells.push(box_from_corners([8.0 + k.to_float() * 29.5, width - 16.0, t - 5.0], [32.0 + k.to_float() * 29.5, width - 4.0, t + 1.0])); }
b - compound(channels) - compound(wells)
