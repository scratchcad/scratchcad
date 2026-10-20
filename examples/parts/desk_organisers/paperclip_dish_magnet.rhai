// Paperclip dish with magnet pocket: 90 mm round dish 24 mm tall, flared 2.5 mm wall, 4 mm floor, 20 x 3.2 mm pocket underneath for a neodymium disc magnet (0.8 mm skin), 3 rubber foot recesses 8 mm
let diameter = 90.0; // [60.0, 130.0] Dish diameter (mm)
let height = 24.0; // [15.0, 40.0] Dish height (mm)
let flare = 8.0; // [0.0, 15.0] Wall flare (mm)
let magnet_d = 20.0; // [10.0, 30.0] Magnet diameter (mm)
let magnet_t = 3.2; // [2.0, 5.0] Magnet thickness (mm)

const wall = 2.5;
const skin = 0.8;
let floor_t = magnet_t + skin + 0.4;
let r_top = diameter / 2.0;
let r_bot = r_top - flare;
let profile = polygon([
    [0, 0, 0], [r_bot - 1.0, 0, 0], [r_bot, 0, 1.0], [r_top, 0, height - 1.0], [r_top - 1.0, 0, height],
    [r_top - wall, 0, height], [r_bot - wall, 0, floor_t + 3.0], [r_bot - wall - 3.0, 0, floor_t], [0, 0, floor_t]
]);
let dish = profile.to_face().revolve("Z", 360.0);
dish = dish - cylinder([0, 0, -1.0], "Z", min(magnet_d / 2.0 + 0.2, r_bot - 6.0), magnet_t + 1.4);
for i in 0..3 {
    let a = (i * 120.0 + 90.0) * PI() / 180.0;
    let rf = r_bot - 5.0;
    dish = dish - cylinder([rf * cos(a), rf * sin(a), -1.0], "Z", 4.1, 2.0);
}
dish
