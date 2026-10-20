// Board game meeple: 16 mm tall person token 10 mm thick, rounded head and arms, chamfered edges
let h = 16.0; // [12.0, 30.0] Height (mm)
let t = 10.0; // [5.0, 12.0] Thickness (mm)
let s = h / 16.0;
let m = polygon([[-8, 0], [-3, 0], [0, 4], [3, 0], [8, 0], [5.5, 6], [8, 9], [7.5, 10.5], [2.5, 10], [2.8, 12.5], [0, 16], [-2.8, 12.5], [-2.5, 10], [-7.5, 10.5], [-8, 9], [-5.5, 6]]).to_face().extrude(t).scale(s);
m.chamfer(0.6 * s, ">Z or <Z")
