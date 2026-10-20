// Duct hanger strap clip for 20 mm perforated band: L bracket 25 mm wide 3 mm thick, 40 mm base with an M8 (8.5 mm) bolt hole, 30 mm upstand with a 21 x 2.5 mm band slot and a 5 mm locating peg
let width = 25.0; // [20.0, 40.0] Clip width (mm)
let t = 3.0; // [2.0, 5.0] Plate thickness (mm)
let base_l = 40.0; // [30.0, 60.0] Base length (mm)
let upstand = 30.0; // [22.0, 50.0] Upstand height (mm)
let band_w = 21.0; // [12.0, 30.0] Band slot width (mm)
const bolt_d = 8.5;
let bw = min(band_w, width - 4.0);
let prof = polygon([[0, 0, 0], [base_l, 0, 0], [base_l, 0, t], [t, 0, t], [t, 0, upstand], [0, 0, upstand]]);
let clip = prof.to_face().extrude([0, width, 0]);
clip = clip.fillet(t * 0.9, clip.edges("|Y").filter(|e| e.center().x > t * 0.5 && e.center().x < t * 1.5 && e.center().z > t * 0.5 && e.center().z < t * 1.5));
let hole = cylinder([base_l * 0.6, width / 2.0, -1], "Z", bolt_d / 2.0, t + 2.0);
let slot = box_from_corners([-1, (width - bw) / 2.0, upstand - 9.0], [t + 1.0, (width + bw) / 2.0, upstand - 6.5]);
let peg = cylinder([t - 0.5, width / 2.0, upstand * 0.45], "X", 2.5, 4.5);
clip - hole - slot + peg
