// Round EVF eyecup adapter ring: slides over a 38 mm viewfinder barrel 12 mm deep, 2 mm walls, then flares to a 50 mm soft-eyecup seat 8 mm long with a 1.5 mm retaining bead 2 mm from the end
let barrel_d = 38.0; // [28.0, 45.0] Viewfinder barrel diameter (mm)
let cup_d = 50.0; // [46.0, 60.0] Eyecup seat diameter (mm)
let grip_len = 12.0; // [8.0, 20.0] Depth over the barrel (mm)
const wall = 2.0;
const seat_len = 8.0;
let ri = barrel_d / 2.0 + 0.15;
let ro = ri + wall;
let rs = cup_d / 2.0;
let z1 = grip_len;
let z2 = z1 + 8.0;
let z3 = z2 + seat_len;
let profile = polygon([
    [ri, 0, 0], [ro, 0, 0], [ro, 0, z1], [rs, 0, z2], [rs, 0, z3 - 3.5], [rs + 1.5, 0, z3 - 2.75], [rs, 0, z3 - 2.0],
    [rs, 0, z3], [rs - wall, 0, z3], [rs - wall, 0, z2 + 0.5], [ri, 0, z1 + 0.5]]);
face(profile).revolve("Z", 360.0)
