// Flail mower hammer shackle: U strap 30 mm wide with 8 mm legs 24 mm apart and 62 mm tall, a 12 mm crown with 6 mm chamfered outer corners that carries the hammer, and a 16.5 mm hole through both legs 12 mm below their tops for the rotor lug bolt
let gap = 24.0; // [16.0, 36.0] Gap between legs (mm)
let leg_t = 8.0; // [6.0, 12.0] Leg thickness (mm)
let height = 62.0; // [45.0, 90.0] Shackle height (mm)
let width = 30.0; // [20.0, 45.0] Strap width (mm)
let pin_d = 16.5; // [12.5, 20.5] Pin hole (mm)
const crown = 12.0;
const ch = 6.0;
let xo = gap / 2.0 + leg_t;
let xi = gap / 2.0;
let profile = polygon([
    [-xo + ch, 0, 0], [xo - ch, 0, 0], [xo, 0, ch], [xo, 0, height], [xi, 0, height], [xi, 0, crown],
    [-xi, 0, crown], [-xi, 0, height], [-xo, 0, height], [-xo, 0, ch],
]);
let shackle = profile.to_face().extrude([0, width, 0]);
let zp = height - max(12.0, pin_d / 2.0 + 4.0);
shackle - cylinder([-xo - 1.0, width / 2.0, zp], "X", min(pin_d, width - 6.0) / 2.0, 2.0 * xo + 2.0)
