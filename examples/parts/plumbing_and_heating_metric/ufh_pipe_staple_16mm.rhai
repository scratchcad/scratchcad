// Underfloor heating tacker staple for 16 mm PE-RT pipe: 2 mm arch over 16.5 mm, 6 mm wide, two 30 mm legs with 3 barbs each, pointed tips
let pipe = 16.0; // [12.0, 20.0] Pipe diameter (mm)
let leg = 30.0; // [20.0, 45.0] Leg length below the pipe centre (mm)
let thick = 2.0; // [1.5, 3.0] Staple thickness (mm)
let width = 6.0; // [4.0, 10.0] Staple width (mm)
let barbs = 3; // [0, 5] Barbs per leg
let ri = pipe / 2.0 + 0.25;
let ro = ri + thick;
let arch = cylinder([0, 0, 0], "Y", ro, width) - cylinder([0, -1, 0], "Y", ri, width + 2.0) - box_from_corners([-ro - 1.0, -1, -ro - 1.0], [ro + 1.0, width + 1.0, 0]);
let legs = [arch];
for s in [-1.0, 1.0] {
    let x0 = s * ri;
    let x1 = s * ro;
    let pts = [[x0, 0, 0.0], [x0, 0, -leg + 4.0], [(x0 + x1) / 2.0, 0, -leg], [x1, 0, -leg + 4.0]];
    for k in 0..barbs {
        let z = -leg + 7.0 + k.to_float() * 5.0;
        if z + 2.5 < -2.0 {
            pts.push([x1, 0, z]);
            pts.push([x1 + s * 1.2, 0, z + 0.5]);
            pts.push([x1, 0, z + 2.5]);
        }
    }
    pts.push([x1, 0, 0.0]);
    legs.push(polygon(pts).to_face().extrude([0, width, 0]));
}
fuse_all(legs).translate([0, 0, leg])
