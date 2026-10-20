// Window drip cap flashing: 1000 mm long, 0.6 mm aluminium Z profile with a 25 mm top leg, 15 mm rise, 30 mm sloped drip leg with a kick
let len = 1000.0; // [300.0, 2000.0] Length (mm)
const t = 0.6;
let path = [[0, 0, 0], [0, 0, 25.0], [-15.0, 0, 25.0], [-15.0, 0, 30.0 + 25.0 - 30.0], [-30.0, 0, 20.0], [-33.0, 0, 16.0]];
let pts = [[0, 0, 0], [t, 0, 0], [t, 0, 25.0], [-15.0, 0, 25.0], [-30.0, 0, 18.0], [-33.0, 0, 13.0], [-33.0 + t, 0, 13.0 - t * 0.2], [-30.0 + t * 0.3, 0, 18.0 - t], [-15.0 + t * 0.3, 0, 25.0 - t], [0, 0, 25.0 - t]];
polygon(pts).to_face().extrude([0, len, 0])
