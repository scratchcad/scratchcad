// 18650 2S battery sled: two 18.6 x 65 mm cells side by side at 20 mm pitch, 2 mm floor, cradle walls, 3 mm end walls with 0.8 mm spring-contact slots and 2 mm wire holes, 2 x M3 base holes
let cell_d = 18.6; // [14.0, 21.5] Cell diameter (mm)
let cell_len = 65.0; // [50.0, 71.0] Cell length (mm)
let contact = 5.0; // [3.0, 8.0] Contact allowance per end (mm)
let floor_t = 2.0; // [1.5, 3.0] Floor thickness (mm)
let wall = 3.0; // [2.0, 4.0] End wall thickness (mm)
let pitch = cell_d + 1.4;
let inner_len = cell_len + 2.0 * contact;
let len = inner_len + 2.0 * wall;
let width = 2.0 * pitch + 3.0;
let rc = cell_d / 2.0 + 0.3;
let zc = floor_t + rc;
let tray = box_from_corners([0, -width / 2.0, 0], [len, width / 2.0, floor_t + rc * 0.9]);
let ends = box_from_corners([0, -width / 2.0, 0], [wall, width / 2.0, zc + rc * 0.2]) + box_from_corners([len - wall, -width / 2.0, 0], [len, width / 2.0, zc + rc * 0.2]);
let body = tray + ends;
let cuts = [];
for y in [-pitch / 2.0, pitch / 2.0] {
    cuts.push(cylinder([wall, y, zc], "X", rc, inner_len));
    for x in [wall / 2.0 - 0.4, len - wall / 2.0 - 0.4] {
        cuts.push(box_from_corners([x, y - 4.0, floor_t + 2.0], [x + 0.8, y + 4.0, zc + rc]));
    }
    cuts.push(cylinder([-1, y, floor_t + 2.0], "X", 1.0, len + 2.0));
}
cuts.push(cylinder([len * 0.3, 0, -1], "Z", 1.6, floor_t + 2.0));
cuts.push(cylinder([len * 0.7, 0, -1], "Z", 1.6, floor_t + 2.0));
body - fuse_all(cuts)
