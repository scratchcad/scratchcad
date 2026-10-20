// T8 brass lead-screw nut (Tr8x8, 4 starts)
let flange_d = 22.0; // [18.0, 30.0] Flange diameter (mm)
let flange_t = 3.5; // [2.0, 6.0] Flange thickness (mm)
let body_d = 10.2; // [9.0, 14.0] Body diameter (mm)
let height = 15.0; // [10.0, 25.0] Overall height (mm)
let hole_d = 3.5; // [2.5, 4.5] Mounting hole diameter (mm)
let hole_circle = 16.0; // [14.0, 24.0] Mounting hole circle (mm)
let starts = 4; // [1, 4] Thread starts
let lead = 8.0; // [2.0, 12.0] Lead (mm)
let nut = cylinder(flange_d / 2.0, flange_t) + cylinder([0, 0, flange_t - 0.01], "Z", body_d / 2.0, height - flange_t + 0.01);
for i in 0..4 { nut -= cylinder([hole_circle / 2.0, 0, -1], "Z", hole_d / 2.0, flange_t + 2.0).rotate_z(i * 90); }
// Tr8 thread: 6.2 mm minor diameter bore with 4 trapezoidal grooves out to 8.2 mm
let r_bore = 3.1; let r_out = 4.15;
let groove = polygon([[r_bore - 0.5, 0, -0.75], [r_bore - 0.05, 0, -0.75], [r_out, 0, -0.35], [r_out, 0, 0.35], [r_bore - 0.05, 0, 0.75], [r_bore - 0.5, 0, 0.75]]);
const per_turn = 16;
let turns = (height / lead).ceiling().to_int() + 1;
let cutters = [cylinder([0, 0, -lead], "Z", r_bore, height + 2.0 * lead)];
for s in 0..starts {
    let sections = [];
    for i in 0..=(turns * per_turn) {
        let t = i.to_float() / per_turn.to_float();
        sections.push(groove.rotate_z(t * 360.0 + s.to_float() * 360.0 / starts.to_float()).translate([0, 0, -lead / 2.0 + t * lead]));
    }
    cutters.push(loft(sections, true));
}
nut - fuse_all(cutters)
