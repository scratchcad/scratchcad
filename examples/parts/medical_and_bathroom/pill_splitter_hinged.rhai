// Hinged pill splitter, closed: 70 x 35 mm base 14 mm tall with a 14 mm V cradle, lid 5 mm thick carrying a 0.4 mm blade in a cross slot, knuckle hinge
let length = 70.0; // [50.0, 100.0] Length (mm)
let width = 35.0; // [25.0, 50.0] Width (mm)
let base_height = 14.0; // [10.0, 20.0] Base height (mm)
let cradle = 14.0; // [6.0, 20.0] V cradle width at the top (mm)
let blade_depth = 4.0; // [2.0, 6.0] Blade reach below the lid (mm)
const lid_t = 5.0;
const gap = 1.0;
let hw = width / 2.0;
let zt = base_height;
let cw = min(cradle, width - 8.0) / 2.0;
let base = box_from_corners([0, -hw, 0], [length, hw, zt]).fillet(3.0, "|Z and >Y");
base -= polygon([[-1.0, -cw, zt + 0.01], [-1.0, cw, zt + 0.01], [-1.0, 0, zt - cw]]).to_face().extrude([length + 2.0, 0, 0]);
base -= box_from_corners([length / 2.0 - 0.6, -hw + 2.0, zt - blade_depth - 3.0], [length / 2.0 + 0.6, hw - 2.0, zt + 1.0]);
// hinge: base ears and knuckles, lid knuckle between them
let hy = -hw - 3.0;
let hz = zt + gap + 2.0;
let k = length * 0.3;
let ears = [];
for xs in [[0, k], [length - k, length]] {
    ears.push(box_from_corners([xs[0], hy - 0.5, zt - 6.0], [xs[1], -hw + 0.5, zt + 0.5]));
    ears.push(box_from_corners([xs[0], hy - 0.5, zt], [xs[1], -hw - 0.5, hz]));
    ears.push(cylinder([xs[0], hy, hz], "X", 2.5, xs[1] - xs[0]));
}
base = fuse_all([base] + ears);
let z0 = zt + gap;
let lid = box_from_corners([0, -hw, z0], [length, hw, z0 + lid_t]).fillet(3.0, "|Z and >Y");
lid = fuse_all([lid, box_from_corners([k + 0.6, hy, z0], [length - k - 0.6, -hw + 0.5, z0 + lid_t]), cylinder([k + 0.6, hy, hz], "X", 2.5, length - 2.0 * k - 1.2)]);
let blade = box_from_corners([length / 2.0 - 0.2, -hw + 3.0, z0 - blade_depth], [length / 2.0 + 0.2, hw - 3.0, z0 + 0.5]);
compound([base, lid + blade])
