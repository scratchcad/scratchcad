// Aluminium PV end clamp for 35 mm frames: Z profile 40 mm long, 10 mm lip over the frame, 35 mm wall, 30 mm foot with a 8.5 mm M8 slot, 3 mm walls
let frame_h = 35.0; // [30.0, 50.0] Panel frame height (mm)
let length = 40.0; // [25.0, 80.0] Clamp length (mm)
let lip = 10.0; // [6.0, 15.0] Lip over the frame (mm)
let foot = 30.0; // [20.0, 40.0] Foot length (mm)
const t = 3.0;
let p = polygon("XZ", [[-t, 0], [foot, 0], [foot, t], [0, t], [0, frame_h + t], [-lip, frame_h + t], [-lip, frame_h], [-t, frame_h]]);
let c = p.to_face().extrude([0, length, 0]);
c = c.fillet(1.0, "|Y and >X").fillet(1.0, "|Y and >Z");
c -= box_centered(8.5, min(14.0, length - 8.0), 10.0).translate([foot / 2.0 + 2.0, length / 2.0, 0]).fillet(4.0, "|Z");
let ribs = [];
for i in 0..3 { ribs.push(box_centered(0.8, length + 2.0, 0.8).rotate_y(45.0).translate([-lip + 2.0 + i.to_float() * 2.5, length / 2.0, frame_h])); }
c - fuse_all(ribs)
