// 24 V 40 W heater cartridge: 6 mm x 20 mm with a crimped end and two PTFE leads 1.2 mm
let diameter = 6.0; // [4.0, 8.0] Diameter (mm)
let length = 20.0; // [15.0, 40.0] Length (mm)
let body = cylinder([0, 0, 0], "X", diameter / 2.0, length).chamfer(0.4, "<X");
let crimp = cylinder([length - 0.01, 0, 0], "X", diameter / 2.0 - 0.6, 2.0);
let leads = cylinder([length + 1.0, -1.0, 0], "X", 0.6, 30.0) + cylinder([length + 1.0, 1.0, 0], "X", 0.6, 30.0);
fuse_all([body, crimp, leads])
