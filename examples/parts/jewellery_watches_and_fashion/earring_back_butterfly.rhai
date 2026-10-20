// Butterfly (friction) earring back for a 0.8 mm post: 6 x 5 mm plate 0.5 mm thick with a 0.9 mm centre hole and two 4 mm long curled tongues that grip the post
let plate_width = 6.0; // [4.5, 8.0] Plate width (mm)
let plate_height = 5.0; // [3.5, 7.0] Plate height (mm)
let plate_thickness = 0.5; // [0.3, 0.8] Plate thickness (mm)
let post_diameter = 0.8; // [0.6, 1.2] Post diameter (mm)
let curl_radius = 1.0; // [0.6, 1.4] Curl outer radius (mm)
let pts = [];
for i in 0..32 {
    let t = i.to_float() * 2.0 * PI() / 32.0;
    pts.push([plate_width / 2.0 * t.cos(), plate_height / 2.0 * t.sin(), 0]);
}
let plate = face(wire([spline(pts, true)])).extrude([0, 0, plate_thickness]);
// each curl is a C-shaped tube along Y, open towards the post
let x0 = post_diameter / 2.0 + curl_radius - 0.1;
let len = plate_height - 1.0;
let curls = [];
for s in [-1.0, 1.0] {
    let tube = cylinder([s * x0, -len / 2.0, plate_thickness + curl_radius - 0.1], "Y", curl_radius, len) - cylinder([s * x0, -len, plate_thickness + curl_radius - 0.1], "Y", curl_radius - 0.3, 2.0 * len);
    let opening = box_centered(curl_radius, 2.0 * len, curl_radius).translate([s * (x0 - curl_radius / 2.0), 0, plate_thickness + curl_radius * 0.6]);
    curls.push(tube - opening);
}
let back = fuse_all([plate, curls[0], curls[1]]);
back - cylinder([0, 0, -1], "Z", (post_diameter + 0.1) / 2.0, 3)
