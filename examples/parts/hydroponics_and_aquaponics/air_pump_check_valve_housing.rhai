// Aquarium / hydroponic air pump inline check valve housing: 14 mm body 18 mm long with a 10 mm valve chamber and a conical seat, and two 12 mm barbed spigots for 4 mm ID airline tube (4.8 mm barb crests, 3.8 mm roots, 2.4 mm bore)
let body_d = 14.0; // [11.0, 20.0] Body diameter (mm)
let body_len = 18.0; // [12.0, 30.0] Body length (mm)
let barb_len = 12.0; // [8.0, 18.0] Spigot length (mm)
let tube_id = 4.0; // [3.0, 6.0] Airline tube inside diameter (mm)
const bore_d = 2.4;
let rb = body_d / 2.0;
let crest = tube_id / 2.0 + 0.4;
let root = tube_id / 2.0 - 0.1;
let br = min(bore_d / 2.0, root - 0.6);
let total = body_len + 2.0 * barb_len;
let pts = [[br, 0, 0], [root - 0.3, 0, 0], [crest, 0, barb_len * 0.35], [root, 0, barb_len * 0.35], [crest, 0, barb_len * 0.7], [root, 0, barb_len * 0.7],
    [root, 0, barb_len], [rb - 1.0, 0, barb_len], [rb, 0, barb_len + 1.0], [rb, 0, barb_len + body_len - 1.0], [rb - 1.0, 0, barb_len + body_len],
    [root, 0, barb_len + body_len], [root, 0, total - barb_len * 0.7], [crest, 0, total - barb_len * 0.7], [root, 0, total - barb_len * 0.35],
    [crest, 0, total - barb_len * 0.35], [root - 0.3, 0, total], [br, 0, total]];
let housing = face(polygon(pts)).revolve("Z", 360.0);
let cr = rb - 2.0;
let chamber = face(polygon([[0, 0, barb_len + 1.5], [cr * 0.4, 0, barb_len + 1.5], [cr, 0, barb_len + 4.0], [cr, 0, barb_len + body_len - 2.0], [0, 0, barb_len + body_len - 2.0]])).revolve("Z", 360.0);
housing - chamber
