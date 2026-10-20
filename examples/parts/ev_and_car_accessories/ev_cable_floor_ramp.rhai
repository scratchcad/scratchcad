// EV charging cable driveway ramp segment: 300 mm long, 130 mm wide, 30 mm tall trapezoid with a 50 mm flat top, 18 x 18 mm cable channel underneath, dovetail tongue and socket to link segments, anti-slip grooves
let length = 300.0; // [200.0, 500.0] Segment length (mm)
let width = 130.0; // [100.0, 200.0] Base width (mm)
let height = 30.0; // [22.0, 45.0] Height (mm)
let channel = 18.0; // [12.0, 25.0] Cable channel size (mm)
let grooves = 8; // [4, 16] Number of grip grooves

const top_w = 50.0;
const dove = 6.0;
let ch = min(channel, height - 6.0);
let profile = polygon([[0, -width / 2.0, 0], [0, width / 2.0, 0], [0, top_w / 2.0, height], [0, -top_w / 2.0, height]]);
let ramp = profile.to_face().extrude([length, 0, 0]);
// dovetail tongue on the +X end, socket on the 0 end, both 10 mm deep below the channel side
let dt = |grow, x0| {
    polygon([[x0, -10.0 - grow, 0], [x0, 10.0 + grow, 0], [x0 + 12.0, 10.0 + dove + grow, 0], [x0 + 12.0, -10.0 - dove - grow, 0]]).to_face().extrude([0, 0, height * 0.5])
};
let tongue_y = width / 2.0 - 30.0;
ramp = ramp + dt.call(0.0, length - 0.5).translate([0, tongue_y, 0]) + dt.call(0.0, length - 0.5).translate([0, -tongue_y, 0]);
ramp = ramp & profile.to_face().extrude([length + 40.0, 0, 0]).translate([-20.0, 0, 0]);
ramp = ramp - dt.call(0.3, -0.5).translate([0, tongue_y, -1.0]) - dt.call(0.3, -0.5).translate([0, -tongue_y, -1.0]);
let cuts = [box_from_corners([-1.0, -ch / 2.0, -1.0], [length + 13.0, ch / 2.0, ch])];
for i in 0..grooves {
    let x = (i + 0.5) * length / grooves;
    cuts.push(box_centered(3.0, width + 2.0, 4.0).translate([x, 0, height]));
}
ramp - fuse_all(cuts)
