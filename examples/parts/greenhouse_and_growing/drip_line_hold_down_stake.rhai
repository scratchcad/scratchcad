// Drip line hold-down stake: 150 mm ground stake with a snap saddle for 16 mm drip line, 6 mm T-section spike with a pointed tip, 3 mm saddle wall with 12 mm mouth, 30 mm foot-press flange
// # Stake
let length = 150.0; // [80.0, 250.0] Stake length (mm)
let spike_w = 10.0; // [6.0, 16.0] Spike width (mm)
let flange_w = 30.0; // [20.0, 45.0] Press flange width (mm)
// # Pipe
let pipe = 16.0; // [12.0, 25.0] Drip line diameter (mm)
let wall = 3.0; // [2.0, 4.0] Saddle wall (mm)
let rp = pipe / 2.0;
let web = polygon("XZ", [[-spike_w / 2.0, 0.0], [spike_w / 2.0, 0.0], [spike_w / 2.0, -length + 25.0], [0.0, -length], [-spike_w / 2.0, -length + 25.0]]).to_face().extrude([0, 2.0, 0]).translate([0, -1.0, 0]);
let rib = polygon("YZ", [[-spike_w / 2.0, 0.0], [spike_w / 2.0, 0.0], [spike_w / 2.0, -length + 30.0], [0.0, -length + 5.0], [-spike_w / 2.0, -length + 30.0]]).to_face().extrude([2.0, 0, 0]).translate([-1.0, 0, 0]);
let flange = box_from_corners([-flange_w / 2.0, -spike_w / 2.0, -wall], [flange_w / 2.0, spike_w / 2.0, 0.01]);
let saddle = cylinder([0, -spike_w / 2.0, rp + 0.5], "Y", rp + wall, spike_w) - cylinder([0, -spike_w, rp + 0.5], "Y", rp, spike_w * 2.0) - box_from_corners([-pipe * 0.375, -spike_w, rp + 0.5], [pipe * 0.375, spike_w, pipe * 2.0]);
fuse_all([web, rib, flange, saddle])
