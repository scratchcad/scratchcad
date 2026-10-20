// N-BK7 right-angle prism, Thorlabs PS911 class: 25 mm legs, 25 mm tall, 0.3 mm bevels on every edge
let leg = 25.0; // [5.0, 50.0] Leg length (mm)
let height = 25.0; // [5.0, 50.0] Prism height (mm)
let bevel = 0.3; // [0.1, 1.0] Edge bevel (mm)
let prism = polygon([[0, 0], [leg, 0], [0, leg]]).to_face().extrude(height);
prism.chamfer(bevel)
