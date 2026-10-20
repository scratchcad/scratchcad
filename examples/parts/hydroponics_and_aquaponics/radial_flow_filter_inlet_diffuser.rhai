// Aquaponics radial flow filter inlet diffuser: a socket for 32 mm pipe (32.2 mm bore, 3 mm wall, 30 mm deep, 3 mm internal stop), three 4 mm legs 25 mm long and a 90 mm deflector disc 3 mm thick that spreads the inflow sideways
let pipe_od = 32.0; // [20.0, 50.0] Inlet pipe outside diameter (mm)
let disc_d = 90.0; // [60.0, 150.0] Deflector disc diameter (mm)
let gap = 25.0; // [10.0, 50.0] Gap above the disc (mm)
let legs = 3; // [3, 6] Number of legs
const wall = 3.0;
const depth = 30.0;
const disc_t = 3.0;
let ri = pipe_od / 2.0 + 0.1;
let ro = ri + wall;
let rd = max(disc_d / 2.0, ro + 10.0);
let socket = face(polygon([[ri - 3.0, 0, 0], [ro, 0, 0], [ro, 0, depth + 3.0], [ri, 0, depth + 3.0], [ri, 0, 3.0], [ri - 3.0, 0, 3.0]])).revolve("Z", 360.0);
let disc = cylinder([0, 0, -gap - disc_t], "Z", rd, disc_t);
let disc = disc.chamfer(1.0, disc.edges(">Z"));
let parts = [socket, disc];
let lr = (ri + ro) / 2.0;
for i in 0..legs {
    parts.push(box_from_corners([lr - 2.0, -2.0, -gap - 0.5], [lr + 2.0, 2.0, 1.0]).rotate_z(i.to_float() * 360.0 / legs.to_float()));
}
fuse_all(parts)
