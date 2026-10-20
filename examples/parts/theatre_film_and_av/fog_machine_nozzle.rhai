// Fog machine output nozzle: 3/8 in BSP-style 16.5 mm spigot 12 mm long with ridges, 30 mm round flange 5 mm, 45 mm cone flaring to a 25 x 6 mm fan slot outlet, 4 mm bore
let spigot = 16.5; // [12.0, 22.0] Spigot diameter (mm)
let flange = 30.0; // [24.0, 40.0] Flange diameter (mm)
let cone_length = 45.0; // [25.0, 70.0] Nozzle length (mm)
let slot_width = 25.0; // [15.0, 40.0] Fan slot width (mm)
let bore = 4.0; // [3.0, 8.0] Bore (mm)
let pts = [[bore / 2.0, 0.0], [spigot / 2.0 - 0.8, 0.0]];
for i in 0..6 { let z = i.to_float() * 2.0; pts.push([spigot / 2.0, z + 1.0]); pts.push([spigot / 2.0 - 0.8, z + 2.0]); }
pts.push([flange / 2.0, 12.0]);
pts.push([flange / 2.0, 17.0]);
pts.push([10.0, 17.0]);
pts.push([10.0, 17.0 + cone_length * 0.3]);
pts.push([bore / 2.0, 17.0 + cone_length * 0.3]);
let base = polygon("XZ", pts).to_face().revolve([0, 0, 0], "Z", 360);
// the fan head is a loft from a 14 mm square to the flat slot, butted onto the neck top
let z0 = 17.0 + cone_length * 0.3;
let z1 = 17.0 + cone_length;
let head = loft([rect(plane([0, 0, z0], "Z"), 14.0, 14.0), rect(plane([0, 0, z1], "Z"), slot_width + 4.0, 6.0 + 4.0)], true);
let channel = loft([rect(plane([0, 0, z0 - 1.0], "Z"), bore, bore), rect(plane([0, 0, z1 + 1.0], "Z"), slot_width, 2.0)], true);
(base + head) - channel - cylinder([0, 0, -1.0], "Z", bore / 2.0, z0 + 2.0)
