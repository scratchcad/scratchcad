// Seat belt stopper button, two bodies printed side by side: 16 mm male disc with a 4.5 mm barbed post 4.2 mm long through the webbing, and a 16 mm x 3 mm female disc with a 4.6 mm socket
let disc_d = 16.0; // [12.0, 22.0] Disc diameter (mm)
let post_d = 4.5; // [3.5, 6.0] Post diameter (mm)
let webbing = 1.4; // [1.0, 2.0] Webbing thickness (mm)
let disc_t = 2.5; // [2.0, 3.5] Disc thickness (mm)

const female_t = 3.0;
let post_len = webbing + female_t - 0.2;
let r = post_d / 2.0;
let male_profile = polygon([
    [0, 0, 0], [disc_d / 2.0 - 0.6, 0, 0], [disc_d / 2.0, 0, 0.6], [disc_d / 2.0, 0, disc_t], [r, 0, disc_t],
    [r, 0, disc_t + post_len - 1.6], [r + 0.4, 0, disc_t + post_len - 1.0], [r - 0.3, 0, disc_t + post_len], [0, 0, disc_t + post_len]
]);
let male = male_profile.to_face().revolve("Z", 360.0);
male = male - box_from_corners([-0.5, -r - 1.0, disc_t + 0.8], [0.5, r + 1.0, disc_t + post_len + 1.0]);
let female_profile = polygon([
    [r + 0.05, 0, 0], [disc_d / 2.0 - 0.6, 0, 0], [disc_d / 2.0, 0, 0.6], [disc_d / 2.0, 0, female_t], [r + 0.05, 0, female_t]
]);
let female = female_profile.to_face().revolve("Z", 360.0).translate([disc_d + 4.0, 0, 0]);
compound([male, female])
