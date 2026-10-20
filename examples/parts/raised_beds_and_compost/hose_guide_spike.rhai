// Garden hose guide spike: 300 mm spike 12 mm, 60 mm roller post 25 mm with a 35 mm top cap to keep the hose off beds
let spike = 300.0; // [200.0, 400.0] Spike length (mm)
let post = 25.0; // [18.0, 35.0] Roller post diameter (mm)
let s = cylinder([0, 0, 40.0], "Z", 6.0, spike - 40.0) + cone(0.5, 6.0, 40.01);
let roller = cylinder([0, 0, spike - 0.01], "Z", post / 2.0, 60.0);
let cap = cylinder([0, 0, spike + 59.99], "Z", 17.5, 5.0);
let c = cap.fillet(2.0, cap.edges(">Z"));
s + roller + c
