// Flail mower Y-blade pivot bushing: 20 mm sleeve 42 mm long with a 12.5 mm bore for the M12 blade bolt, a 30 mm centre collar 6 mm wide that spaces the pair of Y blades apart, the blades riding on the 20 mm journals either side, and 0.8 mm chamfers on the sleeve ends and bore
let sleeve_d = 20.0; // [16.0, 28.0] Journal diameter (mm)
let length = 42.0; // [30.0, 60.0] Overall length (mm)
let bore = 12.5; // [8.5, 16.5] Bolt bore (mm)
let collar_d = 30.0; // [24.0, 40.0] Collar diameter (mm)
let collar_w = 6.0; // [4.0, 12.0] Collar width (mm)
const c = 0.8;
let rb = bore / 2.0;
let rs = max(sleeve_d / 2.0, rb + 2.5);
let rc = max(collar_d / 2.0, rs + 3.0);
let cw = min(collar_w, length - 16.0);
let z1 = (length - cw) / 2.0;
let z2 = z1 + cw;
polygon([
    [rb + c, 0, 0], [rs - c, 0, 0], [rs, 0, c], [rs, 0, z1], [rc, 0, z1], [rc, 0, z2], [rs, 0, z2],
    [rs, 0, length - c], [rs - c, 0, length], [rb + c, 0, length], [rb, 0, length - c], [rb, 0, c],
]).to_face().revolve("Z", 360.0)
