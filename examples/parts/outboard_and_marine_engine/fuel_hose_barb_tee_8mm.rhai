// Marine fuel hose barb tee for 8 mm (5/16 in) hose: 14 mm centre body, three 8.5 mm barbed spigots 22 mm long each with two 1 mm barbs, 5 mm bore through all three branches
let hose_d = 8.0; // [5.0, 13.0] Hose inside diameter (mm)
let spigot_len = 22.0; // [14.0, 35.0] Spigot length (mm)
let bore = 5.0; // [3.0, 9.0] Bore diameter (mm)
const body_d = 14.0;
let rs = hose_d / 2.0 + 0.25;
let rb = min(bore / 2.0, rs - 1.2);
let rbody = max(body_d / 2.0, rs + 2.0);
let l = rbody + spigot_len;
let profile = polygon([[rb, 0, 0], [rs, 0, 0], [rs, 0, l - spigot_len * 0.75], [rs + 1.0, 0, l - spigot_len * 0.75 + 0.5], [rs, 0, l - spigot_len * 0.4],
    [rs + 1.0, 0, l - spigot_len * 0.4 + 0.5], [rs - 0.6, 0, l], [rb, 0, l]]);
let spigot = face(profile).revolve("Z", 360.0);
let body = cylinder([0, -rbody, 0], "Y", rbody, 2.0 * rbody);
let arms = [body, spigot.rotate_y(90.0), spigot.rotate_y(-90.0), spigot.rotate_x(-90.0)];
let bores = [cylinder([-l - 1.0, 0, 0], "X", rb, 2.0 * l + 2.0), cylinder([0, 0, 0], "Y", rb, l + 1.0)];
fuse_all(arms) - fuse_all(bores)
