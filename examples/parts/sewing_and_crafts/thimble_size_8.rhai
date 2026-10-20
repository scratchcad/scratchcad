// Sewing thimble, size 8: 17.5 mm bore, 22 mm tall, dimpled crown, 0.8 mm wall
let bore = 17.5; // [14.0, 21.0] Finger bore (mm)
let height = 22.0; // [16.0, 28.0] Height (mm)
let wall = 0.8; // [0.5, 2.0] Wall (mm)
let outer = cylinder(bore / 2.0 + wall, height - bore / 2.0) + sphere([0, 0, height - bore / 2.0 - wall], bore / 2.0 + wall);
let body = outer & box_from_corners([-20, -20, 0], [20, 20, height]);
let cavity = cylinder([0, 0, -1], "Z", bore / 2.0, height - bore / 2.0 + 1.0) + sphere([0, 0, height - bore / 2.0 - wall], bore / 2.0);
let dimples = [];
for ring in 0..3 {
    let z = 4.0 + ring.to_float() * 4.0;
    for k in 0..16 {
        let a = (k.to_float() + 0.5 * ring.to_float()) * 22.5 * PI() / 180.0;
        dimples.push(sphere([(bore / 2.0 + wall + 0.35) * a.cos(), (bore / 2.0 + wall + 0.35) * a.sin(), z], 0.7));
    }
}
body - cavity - compound(dimples)
