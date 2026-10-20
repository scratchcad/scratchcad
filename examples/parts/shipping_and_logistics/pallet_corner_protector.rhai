// Pallet load corner board cap: 50 mm legs, 4 mm thick, 60 mm tall, 20 mm strap notch 2 mm deep on both outer faces
let leg = 50.0; // [35.0, 80.0] Leg length (mm)
let t = 4.0; // [3.0, 6.0] Thickness (mm)
let height = 60.0; // [40.0, 100.0] Height (mm)
let c = box_from_corners([0, 0, 0], [leg, t, height]) + box_from_corners([0, 0, 0], [t, leg, height]);
let cc = c.fillet(2.0, c.edges("|Z").filter(|e| e.center().x < 0.1 && e.center().y < 0.1));
cc - box_from_corners([-1, -1, height / 2.0 - 10.0], [leg + 1.0, 2.0, height / 2.0 + 10.0]) - box_from_corners([-1, -1, height / 2.0 - 10.0], [2.0, leg + 1.0, height / 2.0 + 10.0])
