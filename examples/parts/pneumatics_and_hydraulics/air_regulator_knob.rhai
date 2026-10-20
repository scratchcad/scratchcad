// FRL regulator adjusting knob: 40 mm, 18 mm tall, 12 flutes, push-to-lock skirt, 8 mm hex socket
let diameter = 40.0; // [28.0, 60.0] Knob diameter (mm)
let height = 18.0; // [12.0, 25.0] Height (mm)
let hex = 8.0; // [5.0, 12.0] Hex socket (mm)
let knob = cylinder(diameter / 2.0, height);
let k = knob.fillet(3.0, knob.edges(">Z"));
let flutes = [];
for i in 0..12 { flutes.push(cylinder([diameter / 2.0 + 1.0, 0, 3.0], "Z", 3.0, height).rotate_z(i.to_float() * 30.0)); }
let pts = [];
for i in 0..6 { let a = (i.to_float() * 60.0) * PI() / 180.0; pts.push([hex / 3.0.sqrt() * a.cos(), hex / 3.0.sqrt() * a.sin()]); }
let sock = polygon(pts).to_face().extrude([0, 0, height - 4.0]).translate([0, 0, -1.0]);
k - fuse_all(flutes) - sock - (cylinder([0, 0, -1], "Z", diameter / 2.0 - 3.0, 4.0) - cylinder([0, 0, -2], "Z", hex, 6.0))
