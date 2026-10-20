// Triangular architect's scale ruler: 300 mm long, 30 mm section with concave faces, 6 scale edges
let length = 300.0; // [150.0, 300.0] Length (mm)
let side = 30.0; // [20.0, 40.0] Section side (mm)
let groove_r = 25.0; // [15.0, 40.0] Face groove radius (mm)
let h = side * 3.0.sqrt() / 2.0;
let tri = polygon([[0, 0], [side, 0], [side / 2.0, h]]).to_face().extrude([0, 0, length]).translate([-side / 2.0, -h / 3.0, 0]);
let grooves = [];
for k in 0..3 {
    let inr = h / 3.0;
    grooves.push(cylinder([0, -inr - groove_r + 2.5, -1], "Z", groove_r, length + 2.0).rotate_z(k.to_float() * 120.0));
}
tri - fuse_all(grooves)
