// Zipper pull tab for a #5 slider: 35 x 10 x 2.5 mm, 3 x 5 mm loop slot, finger dimple
let length = 35.0; // [25.0, 50.0] Length (mm)
let width = 10.0; // [7.0, 15.0] Width (mm)
let thickness = 2.5; // [1.5, 4.0] Thickness (mm)
let tab = polygon([[0, -width * 0.35], [length, -width / 2.0], [length, width / 2.0], [0, width * 0.35]]).to_face().extrude(thickness);
let t = tab.fillet(2.0, tab.edges("|Z"));
t - box_from_corners([2.5, -2.5, -1], [5.5, 2.5, thickness + 1.0]) - sphere([length - 9.0, 0, thickness + 3.6], 4.0)
