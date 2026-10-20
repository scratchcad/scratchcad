// SC fibre adapter panel: 6-port panel 116 x 40 x 2 mm (width follows the port count) with 6 SC simplex cut-outs 9.8 x 13.2 mm on 16 mm pitch, two 3.2 mm screw holes and a 6 mm folded label lip
let ports = 6; // [2, 8] Number of ports
let pitch = 16.0; // [14.0, 20.0] Port pitch (mm)
const t = 2.0;
let w = pitch * ports.to_float() + 20.0;
let p = box_centered(w, 40.0, t).translate([0, 0, t / 2.0]);
let lip = box_from_corners([-w / 2.0, 20.0 - t, 0], [w / 2.0, 20.0, 6.0]);
let cuts = [];
for i in 0..ports { cuts.push(box_centered(9.8, 13.2, t + 2.0).translate([-pitch * (ports.to_float() - 1.0) / 2.0 + pitch * i.to_float(), -2.0, t / 2.0])); }
cuts.push(cylinder([-w / 2.0 + 5.0, -2.0, -1.0], "Z", 1.6, t + 2.0));
cuts.push(cylinder([w / 2.0 - 5.0, -2.0, -1.0], "Z", 1.6, t + 2.0));
p + lip - fuse_all(cuts)
