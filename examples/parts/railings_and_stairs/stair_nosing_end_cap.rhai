// Aluminium stair nosing end cap: 55 x 30 mm L profile 2 mm, 10 mm deep plug, rounded front 6 mm
let tread = 55.0; // [40.0, 75.0] Tread leg (mm)
let riser = 30.0; // [20.0, 45.0] Riser leg (mm)
let t = 2.0; // [1.5, 3.0] Cap thickness (mm)
let profile = polygon([[0, 0], [tread, 0], [tread, 6.0], [6.0, 6.0], [6.0, riser], [0, riser]]).to_face().extrude([0, 0, t]);
let p = profile.fillet(5.9, profile.edges("|Z").filter(|e| e.center().x < 0.5 && e.center().y < 0.5));
let plug = polygon([[1.0, 1.0], [tread - 2.0, 1.0], [tread - 2.0, 5.0], [5.0, 5.0], [5.0, riser - 2.0], [1.0, riser - 2.0]]).to_face().extrude([0, 0, 10.0]).translate([0, 0, t - 0.01]);
p + plug
