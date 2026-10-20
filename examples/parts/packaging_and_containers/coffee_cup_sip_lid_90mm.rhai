// Hot-drink sip lid for a 90 mm cup rim: 0.6 mm polystyrene, recessed deck, 6 mm raised drinking ridge, snap channel that hooks over the cup's 3 mm rolled rim, 10 x 4 mm sip slot and a 2 mm vent
let rim_diameter = 90.0; // [70.0, 100.0] Cup rim diameter (mm)
let ridge_height = 6.0; // [3.0, 12.0] Drinking ridge height (mm)
let thickness = 0.6; // [0.4, 1.2] Sheet thickness (mm)
let sip_slot = 10.0; // [6.0, 16.0] Sip slot length (mm)
let rr = rim_diameter / 2.0;
// thin wall from a centreline: offset each point by half the thickness along the local normal
fn strip(pts, t) {
    let left = [];
    let right = [];
    let n = pts.len();
    for i in 0..n {
        let a = if i == 0 { pts[0] } else { pts[i - 1] };
        let b = if i == n - 1 { pts[n - 1] } else { pts[i + 1] };
        let dr = b[0] - a[0];
        let dz = b[1] - a[1];
        let l = (dr * dr + dz * dz).sqrt();
        let nr = -dz / l * t / 2.0;
        let nz = dr / l * t / 2.0;
        left.push([max(pts[i][0] + nr, 0.0), 0, pts[i][1] + nz]);
        right.insert(0, [max(pts[i][0] - nr, 0.0), 0, pts[i][1] - nz]);
    }
    polygon(left + right)
}
let h = ridge_height;
let pts = [[0.0, 2.0], [rr - 12.0, 2.0], [rr - 9.0, 3.0], [rr - 7.0, h], [rr - 4.0, h + 0.5], [rr - 2.4, h - 0.5], [rr - 1.9, 2.0]];
// snap channel around the rim bead centred at (rr, 0)
for k in 0..=8 {
    let a = (180.0 - k.to_float() * 22.5) * PI() / 180.0;
    pts.push([rr + 1.9 * a.cos(), 0.3 + 1.9 * a.sin()]);
}
pts.push([rr + 2.1, -3.0]);
pts.push([rr + 3.0, -3.8]);
let lid = strip(pts, thickness).to_face().revolve("Z", 360);
// sip slot through the top of the ridge at +X, vent hole in the deck at -X
let slot = face(rect(sip_slot - 4.0, 0.01).offset(2.0)).rotate_z(90.0).extrude([0, 0, 10.0]).translate([rr - 4.5, 0, h - 3.0]);
lid - slot - cylinder([-(rr - 18.0), 0, 0], "Z", 1.0, 5.0)
