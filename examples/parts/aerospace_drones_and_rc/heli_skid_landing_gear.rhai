// RC helicopter skid landing gear: two 6 mm skids 180 mm long, 120 mm apart, two swept cross tubes 45 mm high with mitred bends
let spacing = 120.0; // [80.0, 200.0] Skid spacing (mm)
let h = 45.0; // [25.0, 80.0] Cross tube height (mm)
let len = 180.0; // [120.0, 300.0] Skid length (mm)
let w = spacing / 2.0;
let parts = [];
for s in [-1.0, 1.0] { parts.push(cylinder([-len / 2.0, s * w, 0], "X", 3.0, len)); }
for x in [-len / 4.0, len / 4.0] {
    let path = polyline([[x, -w, 0], [x, -w + 20.0, h], [x, w - 20.0, h], [x, w, 0]]);
    parts.push(circle([x, -w, 0], [0, 20.0, h], 3.0).to_face().sweep(path));
}
fuse_all(parts)
