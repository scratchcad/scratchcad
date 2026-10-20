// Outboard tiller extension grip: 120 mm long 34 mm sleeve pushed onto a 25 mm tiller arm (25.3 mm bore 100 mm deep), six 2 mm deep V finger grooves along the grip, closed 1.5 mm chamfered end and a 6 mm lanyard hole across the closed end
let tiller_d = 25.0; // [18.0, 32.0] Tiller arm diameter (mm)
let length = 120.0; // [80.0, 180.0] Grip length (mm)
let grooves = 6; // [3, 10] Number of finger grooves
const wall = 4.5;
let ri = tiller_d / 2.0 + 0.15;
let ro = ri + wall;
let depth = length - 20.0;
let pts = [[ri, 0, 0], [ro - 1.0, 0, 0], [ro, 0, 1.0]];
let pitch = (depth - 20.0) / grooves.to_float();
for i in 0..grooves {
    let z = 15.0 + i.to_float() * pitch;
    if i == 0 {
        pts.push([ro, 0, z]);
    }
    pts.push([ro - 2.0, 0, z + pitch / 2.0]);
    pts.push([ro, 0, z + pitch]);
}
pts.push([ro, 0, length - 1.5]);
pts.push([ro - 1.5, 0, length]);
pts.push([0, 0, length]);
pts.push([0, 0, depth]);
pts.push([ri, 0, depth]);
let grip = face(polygon(pts)).revolve("Z", 360.0);
grip - cylinder([-ro - 1.0, 0, depth + 10.0], "X", 3.0, 2.0 * ro + 2.0)
