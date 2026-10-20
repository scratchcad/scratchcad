// Open jump ring, 6 mm outside diameter in 0.8 mm (20 gauge) wire, with a 0.2 mm saw-cut gap
let outer_diameter = 6.0; // [3.0, 15.0] Outside diameter (mm)
let wire_diameter = 0.8; // [0.4, 2.0] Wire diameter (mm)
let gap = 0.2; // [0.0, 1.0] Opening gap (mm)
let rw = min(wire_diameter / 2.0, outer_diameter / 6.0);
let rr = outer_diameter / 2.0 - rw;
let ring = torus(rr, rw);
if gap > 0.0 {
    // cut the gap with a thin wedge whose faces pass through the ring's axis, so they meet the
    // torus in circles (a box's flat faces would leave B-spline edges, which measure wrong: #42/#43)
    let l = rr + 2.0 * rw;
    let k = gap / 2.0 / rr;
    ring = ring - polygon([[0, 0, -rw - 1.0], [l, -l * k, -rw - 1.0], [l, l * k, -rw - 1.0]]).to_face().extrude([0, 0, 2.0 * rw + 2.0]);
}
ring
