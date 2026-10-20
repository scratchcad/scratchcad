// Kart exhaust spring hook post: 8 mm round post 25 mm tall on a 20 mm weld pad 3 mm thick, with a 1.5 mm deep, 3 mm wide spring groove 5 mm below the 1 mm chamfered tip, plus a 10 mm head ring 2 mm thick to stop the spring slipping off
let post_d = 8.0; // [6.0, 12.0] Post diameter (mm)
let post_h = 25.0; // [15.0, 40.0] Post height (mm)
let pad_d = 20.0; // [16.0, 30.0] Weld pad diameter (mm)
const pad_t = 3.0;
let rp = post_d / 2.0;
let profile = polygon([
    [0, 0, 0], [pad_d / 2.0, 0, 0], [pad_d / 2.0, 0, pad_t], [rp, 0, pad_t], [rp, 0, post_h - 9.0], [rp - 1.5, 0, post_h - 9.0],
    [rp - 1.5, 0, post_h - 6.0], [rp + 1.0, 0, post_h - 6.0], [rp + 1.0, 0, post_h - 4.0], [rp, 0, post_h - 4.0], [rp, 0, post_h - 1.0],
    [rp - 1.0, 0, post_h], [0, 0, post_h]]);
face(profile).revolve("Z", 360.0)
