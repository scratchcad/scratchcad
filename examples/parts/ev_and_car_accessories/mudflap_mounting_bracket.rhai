// Mud flap mounting bracket: 3 mm L-bracket, 60 mm wide, 45 mm leg to the wheel arch lip with 2 x 6.5 mm holes, 70 mm hanging leg with 3 x 5 mm flap bolt holes, 2 stiffening gussets
let width = 60.0; // [40.0, 100.0] Bracket width (mm)
let top_leg = 45.0; // [30.0, 70.0] Top leg length (mm)
let hang_leg = 70.0; // [40.0, 110.0] Hanging leg length (mm)
let t = 3.0; // [2.5, 5.0] Thickness (mm)
let flap_holes = 3; // [2, 5] Number of flap bolt holes

let top = box_from_corners([-width / 2.0, 0, hang_leg - t], [width / 2.0, top_leg, hang_leg]);
let hang = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, t, hang_leg]);
let br = top + hang;
br = br.fillet(t + 1.0, br.edges("|X").filter(|e| e.center().y > t - 0.01 && e.center().y < t + 0.01 && e.center().z > hang_leg - t - 0.01 && e.center().z < hang_leg - t + 0.01));
br = br.fillet(5.0, br.edges("|Z").filter(|e| e.center().y > top_leg - 0.01));
br = br.fillet(5.0, br.edges("|Y").filter(|e| e.center().z < 0.01));
let gl = min(20.0, top_leg - 22.0);
let gs = [];
for s in [-1.0, 1.0] {
    let x = s * (width / 2.0 - 8.0);
    gs.push(polygon([[x - t / 2.0, t - 0.5, hang_leg - t + 0.5], [x - t / 2.0, t - 0.5 + gl, hang_leg - t + 0.5], [x - t / 2.0, t - 0.5, hang_leg - t + 0.5 - gl]]).to_face().extrude([t, 0, 0]));
}
br = br + fuse_all(gs);
for s in [-1.0, 1.0] {
    br = br - cylinder([s * width / 4.0, top_leg - 10.0, hang_leg - t - 1.0], "Z", 3.25, t + 2.0);
}
for i in 0..flap_holes {
    let x = -width / 2.0 + 10.0 + i * (width - 20.0) / (flap_holes - 1);
    br = br - cylinder([x, -1.0, 12.0], "Y", 2.5, t + 2.0);
}
br
