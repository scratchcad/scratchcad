// Snap-in panel cable grommet for 8 mm cable in a 12 mm hole, 1 to 2 mm panels: 16 mm flange 1.5 mm, 11.8 mm neck 2 mm long, 13.2 mm barbed snap ring, 8.2 mm cable bore with 6 strain-relief fingers to 7 mm
let panel_hole = 12.0; // [8.0, 20.0] Panel hole diameter (mm)
let cable = 8.0; // [3.0, 14.0] Cable diameter (mm)
let panel_t = 2.0; // [0.8, 3.0] Panel thickness (mm)
let flange_d = 16.0; // [11.0, 26.0] Flange diameter (mm)
let fingers = 6; // [3, 10] Number of fingers
let rn = panel_hole / 2.0 - 0.1;
let rc = min(cable / 2.0 + 0.1, rn - 1.2);
let rf = max(flange_d / 2.0, rn + 1.5);
let rb = rn + 0.7;
let neck = panel_t + 0.1;
const ft = 1.5;
let pts = [[rc, 0, 0], [rf, 0, 0], [rf, 0, ft], [rn, 0, ft], [rn, 0, ft + neck], [rb, 0, ft + neck], [rn - 0.4, 0, ft + neck + 3.0], [rc + 0.6, 0, ft + neck + 7.0], [rc - 0.5, 0, ft + neck + 7.0], [rc, 0, ft + neck + 3.0]];
let body = polygon(pts).to_face().revolve("Z", 360);
let slots = [];
for k in 0..fingers {
    slots.push(box_from_corners([0, -0.4, ft + neck + 1.0], [rb + 1.0, 0.4, ft + neck + 8.0]).rotate_z(k.to_float() * 360.0 / fingers.to_float()));
}
body - fuse_all(slots)
