// Spill berm corner connector: hollow L-shaped corner wall 150 x 150 mm, 100 mm tall, 30 mm thick with 5 mm skins, 3 mm floor apron, two 20 mm dowel sockets 40 mm deep in each leg end for joining straight sections
let leg = 150.0; // [100.0, 250.0] Leg length (mm)
let height = 100.0; // [60.0, 150.0] Wall height (mm)
let wall = 5.0; // [3.0, 8.0] Skin thickness (mm)
let socket = 20.0; // [12.0, 25.0] Dowel socket diameter (mm)
const floor_t = 3.0;
let w = wall * 2.0 + socket;
let outline = polygon("XY", [[0, 0], [leg, 0], [leg, w], [w, w], [w, leg], [0, leg]]);
let body = outline.to_face().extrude([0, 0, height]);
let cavity = polygon("XY", [[wall, wall], [leg - wall, wall], [leg - wall, w - wall], [w - wall, w - wall], [w - wall, leg - wall], [wall, leg - wall]]).to_face().extrude([0, 0, height - 2.0 * wall]).translate([0, 0, wall]);
let apron = box_from_corners([0, 0, 0], [leg, leg, floor_t]);
let tubes = [];
let bores = [];
for z in [height * 0.3, height * 0.7] {
    tubes.push(cylinder([leg - 45.0, w / 2.0, z], "X", socket / 2.0 + wall * 0.6, 45.0));
    tubes.push(cylinder([w / 2.0, leg - 45.0, z], "Y", socket / 2.0 + wall * 0.6, 45.0));
    bores.push(cylinder([leg + 1.0, w / 2.0, z], "-X", socket / 2.0, 41.0));
    bores.push(cylinder([w / 2.0, leg + 1.0, z], "-Y", socket / 2.0, 41.0));
}
(body - cavity + apron + fuse_all(tubes)) - compound(bores)
