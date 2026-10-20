// Bail pull swing handle: 76.2 mm centres, 5 mm round bar bail dropping 25 mm, 3 mm pivot ends
let centers = 76.2; // [64.0, 101.6] Post centres (mm)
let drop = 25.0; // [15.0, 40.0] Bail drop (mm)
let bar = 5.0; // [4.0, 8.0] Bar diameter (mm)
let r = bar / 2.0;
let grip = cylinder([-centers / 2.0 + 8.0, 0, -drop], "X", r, centers - 16.0);
let legs = [];
for s in [-1.0, 1.0] {
    let x0 = s * (centers / 2.0 - 8.0);
    let x1 = s * centers / 2.0;
    let len = ((x1 - x0) * (x1 - x0) + drop * drop).sqrt();
    let ang = (drop / 8.0).atan() * 180.0 / PI();
    legs.push(cylinder([x0, 0, -drop], "Z", r, len).rotate([x0, 0, -drop], "Y", s * (90.0 - ang)));
    legs.push(sphere([x0, 0, -drop], r + 0.3));
    legs.push(cylinder([if s > 0.0 { x1 - 0.5 } else { x1 - 3.5 }, 0, 0], "X", 1.5, 4.0));
}
grip + fuse_all(legs)
