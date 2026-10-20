// Car 12 V accessory socket blanking cap (ISO 4165 / SAE J563, 21 mm socket): 20.8 mm slotted plug 14 mm deep with a 0.35 mm retention bead, 27 mm x 4 mm head, tether tab with 3.5 mm hole
let socket = 21.0; // [20.5, 21.5] Socket bore (mm)
let plug_len = 14.0; // [10.0, 20.0] Plug depth (mm)
let head_d = 27.0; // [24.0, 32.0] Head diameter (mm)
let slits = 4; // [3, 8] Number of spring slits
let wall = 1.4; // [1.0, 2.0] Plug wall (mm)

const head_t = 4.0;
let r = socket / 2.0 - 0.1;
let ri = r - wall;
let rh = head_d / 2.0;
let zb = head_t + plug_len * 0.6;
let profile = polygon([
    [ri, 0, head_t - 1.0], [ri, 0, head_t + plug_len], [r - 0.4, 0, head_t + plug_len], [r, 0, head_t + plug_len - 0.6],
    [r, 0, zb + 1.0], [r + 0.35, 0, zb], [r, 0, zb - 1.0], [r, 0, head_t], [rh, 0, head_t], [rh, 0, 0.6], [rh - 0.6, 0, 0], [0, 0, 0],
    [0, 0, head_t - 1.0]
]);
let cap = profile.to_face().revolve("Z", 360.0);
let cuts = [];
for i in 0..slits {
    cuts.push(box_from_corners([0, -0.6, head_t + plug_len * 0.35], [r + 2.0, 0.6, head_t + plug_len + 1.0]).rotate_z(i * 360.0 / slits + 45.0));
}
cap = cap - fuse_all(cuts);
let tab = box_from_corners([rh - 2.0, -4.0, 0], [rh + 9.0, 4.0, 2.0]);
tab = tab.fillet(3.9, tab.edges("|Z and >X"));
cap + (tab - cylinder([rh + 5.0, 0, -1.0], "Z", 1.75, 4.0))
