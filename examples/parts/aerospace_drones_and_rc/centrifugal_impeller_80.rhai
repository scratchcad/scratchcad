// Open centrifugal impeller: 80 mm backplate 3 mm thick, 8 backward-curved 2 mm blades 12 mm tall, 20 mm hub with 8 mm bore
let R = 40.0; // [25.0, 60.0] Radius (mm)
let n = 8; // [5, 12] Blades
let h = 12.0; // [6.0, 20.0] Blade height (mm)
fn blade(r0, r1, sweep, t, h) {
    let fwd = [];
    let back = [];
    for i in 0..=10 {
        let f = i.to_float() / 10.0;
        let r = r0 + (r1 - r0) * f;
        let a = -sweep * f * f * PI() / 180.0;
        let da = t / r;
        fwd.push([r * a.cos(), r * a.sin()]);
        back.push([r * (a + da).cos(), r * (a + da).sin()]);
    }
    back.reverse();
    polygon(fwd + back).to_face().extrude(h)
}
let parts = [cylinder(R, 3.0), cylinder(10.0, h + 3.0)];
let b = blade(9.0, R - 1.0, 45.0, 2.0, h).translate([0, 0, 2.9]);
for k in 0..n { parts.push(b.rotate("Z", k.to_float() * 360.0 / n.to_float())); }
fuse_all(parts) - cylinder([0, 0, -1], "Z", 4.0, h + 5.0)
