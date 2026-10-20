// Rafter (speed) square, 150 mm: right-triangle plate 4 mm thick, 10 mm fence lip along one leg, triangular window, pivot hole and 5 pencil holes at 25 mm
let leg = 150.0; // [100.0, 300.0] Leg length (mm)
let t = 4.0; // [3.0, 6.0] Plate thickness (mm)
let lip_h = 10.0; // [6.0, 16.0] Fence lip height (mm)
let lip_w = 6.0; // [4.0, 10.0] Fence lip width (mm)
let plate = polygon([[0, 0, 0], [leg, 0, 0], [0, leg, 0]]).to_face().extrude([0, 0, t]);
let lip = box_from_corners([0, -lip_w, (t - lip_h) / 2.0], [leg, 0.01, (t + lip_h) / 2.0]);
const m = 25.0;
let win = polygon([[m, m, -1], [leg - 2.4 * m, m, -1], [m, leg - 2.4 * m, -1]]).to_face().extrude([0, 0, t + 2.0]);
let holes = [cylinder([8.0, 8.0, -1], "Z", 2.5, t + 2.0)];
for i in 1..6 { holes.push(cylinder([i.to_float() * 25.0 * leg / 150.0, 10.0, -1], "Z", 1.0, t + 2.0)); }
plate + lip - win - compound(holes)
