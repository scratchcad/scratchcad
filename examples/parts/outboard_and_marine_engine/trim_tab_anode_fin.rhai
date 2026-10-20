// Outboard trim tab anode: 15 mm thick fin 110 mm long, 60 mm wide at the bolt end tapering to 35 mm at the tail, 2 mm chamfered top edges, and an M8 bolt hole (8.5 mm) counterbored 14 mm by 6 mm 25 mm from the front, with a 12 mm locating boss 3 mm proud underneath
let length = 110.0; // [70.0, 160.0] Fin length (mm)
let front_w = 60.0; // [40.0, 80.0] Front width (mm)
let tail_w = 35.0; // [20.0, 60.0] Tail width (mm)
let thickness = 15.0; // [10.0, 22.0] Fin thickness (mm)
let tw = min(tail_w, front_w);
let fin = face(polygon([[0, -front_w / 2.0, 0], [length, -tw / 2.0, 0], [length, tw / 2.0, 0], [0, front_w / 2.0, 0]])).extrude([0, 0, thickness]);
let fin = fin.fillet(min(8.0, tw / 2.0 - 1.0), fin.edges("|Z"));
let fin = fin.chamfer(2.0, fin.edges(">Z"));
let boss = cylinder([25.0, 0, -3.0], "Z", 6.0, 3.5);
let body = fin + boss;
let cuts = [cylinder([25.0, 0, -4.0], "Z", 4.25, thickness + 5.0), cylinder([25.0, 0, thickness - 6.0], "Z", 7.0, 7.0)];
body - fuse_all(cuts)
