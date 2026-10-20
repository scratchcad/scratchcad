// Heat-set threaded insert M3 x 5.7 for plastics: 4.6 mm knurled OD in two bands of 12 ribs, 4.0 mm core, centre groove, tapered lead-in, 3.0 mm internal bore
let thread_diameter = 3.0; // [2.0, 3.2] Thread size (mm)
let outer_diameter = 4.6; // [4.4, 12.0] Knurl outer diameter (mm)
let length = 5.7; // [3.0, 15.0] Length (mm)
const ribs = 12;
let ro = max(outer_diameter / 2.0, thread_diameter / 2.0 + 0.6);
let rcore = ro - 0.3;
let band = length * 0.38;
let core = polygon([[thread_diameter / 2.0, 0, 0], [rcore - 0.3, 0, 0], [rcore, 0, 0.4], [rcore, 0, length], [thread_diameter / 2.0, 0, length]]).to_face().revolve("Z", 360);
let knurls = [];
for b in [0, 1] {
    let z0 = if b == 0 { length - band } else { 0.5 };
    let twist = if b == 0 { 0.0 } else { 15.0 };
    for i in 0..ribs {
        let a = i.to_float() * 360.0 / ribs.to_float() + twist;
        knurls.push(polygon([[rcore - 0.1, -0.35, z0], [ro, -0.12, z0], [ro, 0.12, z0], [rcore - 0.1, 0.35, z0]]).to_face().extrude(band).rotate("Z", a));
    }
}
fuse_all([core] + knurls)
