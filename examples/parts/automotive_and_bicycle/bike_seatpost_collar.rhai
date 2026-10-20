// Seatpost collar for a 34.9 mm seat tube: 12 mm tall ring with 4 mm wall, slotted ear and counterbored M5 pinch bolt
let d = 34.9; // [28.6, 38.0] Seat tube outer diameter (mm)
let h = 12.0; // [8.0, 16.0] Height (mm)
let ring = cylinder(d / 2.0 + 4.0, h) + box_from_corners([d / 2.0, -7.0, 0], [d / 2.0 + 13.0, 7.0, h]);
ring -= cylinder([0, 0, -1], "Z", d / 2.0, h + 2.0);
ring -= box_from_corners([d / 2.0 - 2.0, -1.0, -1.0], [d / 2.0 + 14.0, 1.0, h + 1.0]);
ring -= cylinder([d / 2.0 + 8.0, -8.0, h / 2.0], "Y", 2.6, 16.0);
ring - cylinder([d / 2.0 + 8.0, -8.0, h / 2.0], "Y", 4.5, 3.5)
