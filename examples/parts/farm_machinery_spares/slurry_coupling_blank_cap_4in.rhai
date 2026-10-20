// Blank cap for a 4 inch (108 mm ball) slurry hose quick coupling: 128 mm cap with a 6 mm end plate and a 4 mm skirt 28 mm deep over a 116 mm bore, a 6 mm wide gasket groove 3 mm deep in the end face, a 1.5 mm chamfer at the mouth, and two 8 mm thick hook lugs 20 mm wide reaching 30 mm out from the skirt at its mouth, each with a 12.5 mm hole for the coupling's lever hooks
let bore = 116.0; // [80.0, 160.0] Skirt bore (mm)
let skirt_depth = 28.0; // [18.0, 40.0] Skirt depth (mm)
let wall = 4.0; // [3.0, 6.0] Skirt wall (mm)
let lug_reach = 30.0; // [20.0, 45.0] Lug reach (mm)
const end_t = 6.0;
const groove_w = 6.0;
const groove_d = 3.0;
const lug_w = 20.0;
const lug_t = 8.0;
const lug_hole = 12.5;
let ri = bore / 2.0;
let ro = ri + wall;
let h = end_t + skirt_depth;
let profile = polygon([
    [0, 0, 0], [ro, 0, 0], [ro, 0, h], [ri + 1.5, 0, h], [ri, 0, h - 1.5], [ri, 0, end_t],
    [ri - 4.0, 0, end_t], [ri - 4.0, 0, end_t - groove_d], [ri - 4.0 - groove_w, 0, end_t - groove_d], [ri - 4.0 - groove_w, 0, end_t], [0, 0, end_t],
]);
let cap = profile.to_face().revolve("Z", 360.0);
let parts = [cap];
let cutters = [];
for s in [-1.0, 1.0] {
    let x0 = s * (ro - 2.0);
    let x1 = s * (ro + lug_reach);
    parts.push(box_from_corners([min(x0, x1), -lug_w / 2.0, h - lug_t], [max(x0, x1), lug_w / 2.0, h]));
    cutters.push(cylinder([s * (ro + lug_reach - 10.0), 0, h - lug_t - 1.0], "Z", lug_hole / 2.0, lug_t + 2.0));
}
let body = fuse_all(parts);
body - fuse_all(cutters)
