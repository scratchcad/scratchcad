// Reducing duct tee 125 x 100 mm: 124 mm OD run 200 mm long, 99 mm OD branch spigot 60 mm beyond the run, 1.5 mm wall, 3 mm stop beads at each spigot root
let run_d = 124.0; // [110.0, 250.0] Run outside diameter (mm)
let branch_d = 99.0; // [60.0, 105.0] Branch outside diameter (mm)
let run_l = 200.0; // [150.0, 400.0] Run length (mm)
let branch_l = 60.0; // [30.0, 120.0] Branch length beyond the run (mm)
let wall = 1.5; // [1.2, 3.0] Wall thickness (mm)
let rr = run_d / 2.0;
let rb = branch_d / 2.0;
let run = cylinder([-run_l / 2.0, 0, 0], "X", rr, run_l);
let branch = cylinder([0, 0, 0], "Z", rb, rr + branch_l);
let beads = [];
for sx in [-1.0, 1.0] {
    beads.push(cylinder([sx * (run_l / 2.0 - 40.0), 0, 0], "X", rr + 2.0, 3.0));
}
beads.push(cylinder([0, 0, rr + 10.0], "Z", rb + 2.0, 3.0));
let body = fuse_all([run, branch] + beads);
let bores = fuse_all([cylinder([-run_l / 2.0 - 1.0, 0, 0], "X", rr - wall, run_l + 2.0), cylinder([0, 0, 0], "Z", rb - wall, rr + branch_l + 1.0)]);
body - bores
