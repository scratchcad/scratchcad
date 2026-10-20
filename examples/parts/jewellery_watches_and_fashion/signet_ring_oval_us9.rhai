// Signet ring, US size 9: 18.95 mm inner diameter, 14 x 12 mm oval flat face 3 mm above the shank, 1.8 x 4 mm shank flaring into the head
let inner_diameter = 18.95; // [15.0, 23.0] Inner diameter (mm)
let face_length = 14.0; // [9.0, 18.0] Face length (mm)
let face_width = 12.0; // [8.0, 16.0] Face width (mm)
let shank_thickness = 1.8; // [1.2, 3.0] Shank thickness (mm)
let shank_width = 4.0; // [2.5, 6.0] Shank width (mm)
let head_height = 3.0; // [1.5, 5.0] Face height above the shank (mm)
let ri = inner_diameter / 2.0;
let ro = ri + shank_thickness;
fn oval(a, b, z) {
    let pts = [];
    for i in 0..36 {
        let t = i.to_float() * 10.0 * PI() / 180.0;
        pts.push([a * t.cos(), b * t.sin(), z]);
    }
    wire([spline(pts, true)])
}
// finger hole along Y, face on top (+Z), face length across the finger (X)
let shank = cylinder([0, -shank_width / 2.0, 0], "Y", ro, shank_width);
// the head is lofted from a narrow oval inside the finger hole (cut away later) to the face, through a waist at the shank
let z_top = ro + head_height;
let head = loft([oval(face_length * 0.45, shank_width / 2.0, ri * 0.4), oval(face_length * 0.47, (shank_width + face_width) / 4.0, ri + shank_thickness * 0.5), oval(face_length / 2.0, face_width / 2.0, z_top)], true);
let ring = (shank + head) - cylinder([0, -20, 0], "Y", ri, 40);
ring
