// Radiator drain-off cock hose adapter: push-on cup 16.5 mm bore 14 mm deep over the 15 mm serrated outlet, 3 internal grip ribs, 22 mm body, stepped hose tail 13 mm with 3 barbs 25 mm long, 9 mm flow bore
let outlet = 16.5; // [12.0, 22.0] Drain cock outlet diameter (mm)
let cup_depth = 14.0; // [8.0, 20.0] Cup depth (mm)
let hose = 13.0; // [9.0, 19.0] Hose bore (mm)
let tail = 25.0; // [15.0, 40.0] Hose tail length (mm)
let barbs = 3; // [1, 5] Number of barbs
let rc = outlet / 2.0;
let rb = rc + 2.75;
let rh = hose / 2.0;
let rflow = min(4.5, rh - 1.5);
let pts = [[rc, 0, 0], [rb, 0, 0], [rb, 0, cup_depth + 4.0], [rh, 0, cup_depth + 6.0]];
let step = tail / barbs.to_float();
for k in 0..barbs {
    let z = cup_depth + 6.0 + k.to_float() * step;
    pts.push([rh, 0, z + step * 0.2]);
    pts.push([rh + 0.8, 0, z + step * 0.25]);
    pts.push([rh - 0.4, 0, z + step]);
}
pts.push([rflow, 0, cup_depth + 6.0 + tail]);
pts.push([rflow, 0, cup_depth]);
pts.push([rc, 0, cup_depth]);
let body = polygon(pts).to_face().revolve("Z", 360);
let ribs = [];
for k in 0..3 {
    ribs.push(box_from_corners([rc - 0.6, -0.8, 0.5], [rc + 0.3, 0.8, cup_depth - 0.5]).rotate_z(k.to_float() * 120.0));
}
fuse_all([body] + ribs)
