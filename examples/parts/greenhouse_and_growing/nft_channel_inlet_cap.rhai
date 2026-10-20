// NFT channel inlet cap: push-on end cap for a 100 x 50 mm NFT hydroponic channel, 2 mm wall, 15 mm skirt with 0.3 mm clearance, 16 mm barbed inlet spigot near the floor and a 25 mm vent hole on top
// # Channel
let channel_w = 100.0; // [60.0, 150.0] Channel width (mm)
let channel_h = 50.0; // [30.0, 80.0] Channel height (mm)
let skirt = 15.0; // [8.0, 25.0] Skirt depth (mm)
let wall = 2.0; // [1.5, 3.0] Wall thickness (mm)
// # Ports
let inlet = 16.0; // [10.0, 20.0] Inlet pipe diameter (mm)
let vent = 25.0; // [10.0, 35.0] Vent hole diameter (mm)
let iw = channel_w + 0.6;
let ih = channel_h + 0.6;
let ow = iw + 2.0 * wall;
let oh = ih + 2.0 * wall;
let cap = box_from_corners([-wall, -ow / 2.0, -wall], [skirt, ow / 2.0, oh - wall]);
let cavity = box_from_corners([0, -iw / 2.0, 0], [skirt + 1.0, iw / 2.0, ih]);
let rs = inlet / 2.0 - 0.8;
let iz = rs + 4.0;
let spigot = cylinder([-wall - 20.0, 0, iz], "X", rs, 20.01);
let barbs = [];
for i in 0..2 {
    barbs.push(cone(rs - 0.3, inlet / 2.0 + 0.8, 5.0).rotate_y(90.0).translate([-wall - 20.0 + 1.0 + i.to_float() * 7.0, 0, iz]));
}
let bore = cylinder([-wall - 25.0, 0, iz], "X", rs - 2.0, 30.0);
let vh = min(vent, ow - 10.0);
let vent_hole = cylinder([-wall - 1.0, -iw / 4.0, ih * 0.7], "X", min(vh / 2.0, ih * 0.25), wall + 2.0);
(cap - cavity + spigot + fuse_all(barbs)) - bore - vent_hole
