// EV charging cable wall hook: 110 mm deep saddle 60 mm wide for a coiled 7 m Type 2 cable, 35 mm lip, 20 mm inner bend radius, 140 mm back plate 6 mm with 3 screw holes
let depth = 110.0; // [70.0, 160.0] Saddle depth (mm)
let width = 60.0; // [40.0, 90.0] Hook width (mm)
let lip = 35.0; // [20.0, 60.0] Lip height (mm)
let t = 6.0; // [4.0, 10.0] Material thickness (mm)
let bend = 20.0; // [8.0, 30.0] Inner bend radius (mm)

const height = 140.0;
let profile = polygon([[0, 0, 0], [0, depth, 0], [0, depth, lip], [0, depth - t, lip], [0, depth - t, t], [0, t, t], [0, t, height], [0, 0, height]]);
let hook = profile.to_face().extrude([width, 0, 0]).translate([-width / 2.0, 0, 0]);
let r_in = min(bend, min(lip - t - 2.0, height / 3.0));
hook = hook.fillet(r_in, hook.edges("|X").filter(|e| e.center().z > t - 0.01 && e.center().z < t + 0.01));
hook = hook.fillet(r_in + t - 0.5, hook.edges("|X").filter(|e| e.center().z.abs() < 0.01));
hook = hook.fillet(t / 2.0 - 0.2, hook.edges("|X").filter(|e| e.center().z > lip - 0.01 && e.center().z < lip + 0.01));
let holes = [];
for z in [height - 15.0, height - 55.0, 40.0] {
    holes.push(cylinder([0, -1.0, z], "Y", 2.5, t + 2.0));
    holes.push(cone(2.5, 5.2, 2.8).rotate_x(-90.0).translate([0, t - 2.7, z]));
}
hook - fuse_all(holes)
