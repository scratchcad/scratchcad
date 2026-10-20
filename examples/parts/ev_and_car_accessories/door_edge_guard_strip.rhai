// Car door edge guard strip: 150 mm U-channel for a 2 mm door edge, 11 mm deep, 1.2 mm legs, 6 mm round bumper bead on top, 3 grip fins a side
let length = 150.0; // [50.0, 300.0] Strip length (mm)
let edge = 2.0; // [1.5, 4.0] Door edge thickness (mm)
let depth = 11.0; // [7.0, 16.0] Channel depth (mm)
let leg = 1.2; // [1.0, 2.0] Leg thickness (mm)
let bead = 6.0; // [4.0, 9.0] Bumper bead diameter (mm)

const fins = 3;
let gap = edge + 0.4;
let half = gap / 2.0 + leg;
let u = box_from_corners([0, -half, 0], [length, half, depth + leg]) - box_from_corners([-1.0, -gap / 2.0, -1.0], [length + 1.0, gap / 2.0, depth]);
let br = max(bead / 2.0, half);
let bump = cylinder([0, 0, depth + leg], "X", br, length) & box_from_corners([-1.0, -br - 1.0, depth + leg - 0.5], [length + 1.0, br + 1.0, depth + leg + br + 1.0]);
let fs = [];
for i in 0..fins {
    let z = depth * (0.2 + 0.25 * i);
    for s in [-1.0, 1.0] {
        let yw = s * (gap / 2.0 + 0.2);
        let yt = s * (gap / 2.0 - 0.5);
        fs.push(polygon([[0, yw, z], [0, yt, z + 0.6], [0, yw, z + 1.4]]).to_face().extrude([length, 0, 0]));
    }
}
let strip = fuse_all([u, bump, compound(fs)]);
strip.chamfer(0.4, strip.edges("<Z"))
