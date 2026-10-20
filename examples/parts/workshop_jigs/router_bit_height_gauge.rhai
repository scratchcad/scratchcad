// Router bit height setup gauge: 6 steps 3, 6, 10, 12, 16 and 19 mm high, each 15 mm wide, 25 mm deep, on a 3 mm base plate
let step_w = 15.0; // [10.0, 25.0] Step width (mm)
let depth = 25.0; // [15.0, 40.0] Gauge depth (mm)
let scale = 1.0; // [0.5, 2.0] Height scale factor
let heights = [3.0, 6.0, 10.0, 12.0, 16.0, 19.0];
let pts = [[0, 0, 0], [6.0 * step_w, 0, 0]];
for k in 0..6 {
    let i = 5 - k;
    let h = heights[i] * scale;
    pts.push([(i + 1).to_float() * step_w, 0, h]);
    pts.push([i.to_float() * step_w, 0, h]);
}
polygon(pts).to_face().extrude([0, depth, 0])
