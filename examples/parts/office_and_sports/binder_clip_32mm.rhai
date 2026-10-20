// Medium binder clip, 32 mm: 0.5 mm spring steel folded into a triangular body 32 mm wide and 23 mm deep, with two 1.2 mm wire handles
let w = 32.0; // [15.0, 51.0] Clip width (mm)
let depth = 23.0; // [12.0, 35.0] Body depth (mm)
const t = 0.5;
let outer = polygon([[0, 0, 0], [depth, 0, 6.0], [depth, 0, 9.0], [0, 0, 15.0]]);
let inner = polygon([[t * 2.0, 0, t * 1.5], [depth - t, 0, 6.0 + t * 0.6], [depth - t, 0, 9.0 - t * 0.6], [t * 2.0, 0, 15.0 - t * 1.5]]);
let body = (outer.to_face() - inner.to_face()).extrude([0, w, 0]) - box_from_corners([-1.0, -1.0, 6.5], [1.5, w + 1.0, 8.5]);
let handles = [];
for s in [-1.0, 1.0] {
    let z0 = 7.5 + s * 7.0;
    handles.push(circle([depth * 0.6, 3.0, z0], [0, 0, 1], 0.6).to_face().sweep(polyline([[depth * 0.6, 3.0, z0], [-12.0, 3.0, z0 + s * 6.0], [-12.0, w - 3.0, z0 + s * 6.0], [depth * 0.6, w - 3.0, z0]])));
}
compound([body] + handles)
