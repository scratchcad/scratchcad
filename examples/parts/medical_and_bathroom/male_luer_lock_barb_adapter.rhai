// Male luer lock to 1/8 in barb adapter (ISO 80369-7): 6 % taper tip 3.925 mm at the end, 7.5 mm long, 8 mm lock collar with a 2-start 5 mm lead internal thread, 3.2 mm barb
const taper = 0.06;
const tip_d = 3.925;
const tip_len = 7.5;
let collar_bore = 8.0; // [7.6, 9.0] Lock collar bore (mm)
let collar_height = 8.0; // [6.0, 10.0] Lock collar height (mm)
let barb_diameter = 3.6; // [3.2, 5.0] Barb diameter (mm)
let barb_length = 12.0; // [8.0, 20.0] Barb length (mm)
let rc = collar_bore / 2.0;
let rco = rc + 1.2;
// hub: base disk at z = 0, collar and tip pointing down to -z
let tip = cone(tip_d / 2.0, tip_d / 2.0 + taper * tip_len / 2.0, tip_len).translate([0, 0, -tip_len]);
let collar = cylinder([0, 0, -collar_height], "Z", rco, collar_height + 0.1) - cylinder([0, 0, -collar_height - 1.0], "Z", rc, collar_height + 1.0);
let base = cylinder(rco, 3.0);
let wings = box_centered(2.0 * rco + 6.0, 2.5, 3.0).translate([0, 0, 1.5]);
let rb = barb_diameter / 2.0;
let pts = [[0, 0, 2.9], [rb - 0.5, 0, 2.9], [rb - 0.5, 0, 5.0]];
let z = 5.0;
const n = 3;
let step = (barb_length - 2.0) / n.to_float();
for i in 0..n {
    pts.push([rb, 0, z + 0.5]);
    pts.push([rb - 0.6, 0, z + step]);
    z += step;
}
pts.push([0, 0, z]);
let barb = polygon(pts).to_face().revolve("Z", 360);
// internal 2-start thread in the collar
const lead = 5.0;
let ridge = polygon([[rc + 0.05, 0, -0.9], [rc - 0.5, 0, -0.3], [rc - 0.5, 0, 0.3], [rc + 0.05, 0, 0.9]]);
let threads = [];
for st in 0..2 {
    let secs = [];
    for i in 0..=24 {
        let t = i.to_float() / 12.0;
        secs.push(ridge.rotate_z(t * 360.0 + st.to_float() * 180.0).translate([0, 0, -collar_height - 2.0 + t * lead]));
    }
    threads.push(loft(secs, true));
}
let thread_band = compound(threads) & cylinder([0, 0, -collar_height + 0.5], "Z", rc + 0.5, collar_height - 1.0);
let part = fuse_all([tip, collar, base, wings, barb, thread_band]);
part - cylinder([0, 0, -tip_len - 1.0], "Z", 0.9, tip_len + barb_length + 10.0)
