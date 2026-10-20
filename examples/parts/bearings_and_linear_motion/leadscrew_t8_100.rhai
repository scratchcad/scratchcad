// T8 lead screw, 100 mm long, 8 mm lead with 4 starts (2 mm pitch), trapezoidal thread approximated by lofted ridges
let length = 30.0; // [10.0, 100.0] Length shown (mm)
let starts = 4; // [1, 4] Thread starts
let lead = 8.0; // [2.0, 12.0] Lead (mm)
let major = 8.0; // [6.0, 16.0] Major diameter (mm)
let minor = 6.2; // [4.0, 13.0] Minor diameter (mm)
// the core runs past the ridges at both ends, so no ridge ends inside it
let core = cylinder([0, 0, -lead - 2.0], "Z", minor / 2.0, length + 2.0 * lead + 4.0);
let section = polygon([[minor / 2.0 - 0.4, 0, -0.6], [minor / 2.0 - 0.05, 0, -0.6], [major / 2.0, 0, -0.3], [major / 2.0, 0, 0.3], [minor / 2.0 - 0.05, 0, 0.6], [minor / 2.0 - 0.4, 0, 0.6]]);
let turns = (length / lead).ceiling().to_int() + 1;
const per_turn = 12;
let ridges = [];
for s in 0..starts {
    let sections = [];
    for i in 0..=(turns * per_turn) {
        let t = i.to_float() / per_turn.to_float();
        sections.push(section.rotate_z(t * 360.0 + s.to_float() * 360.0 / starts.to_float()).translate([0, 0, -lead + t * lead]));
    }
    ridges.push(loft(sections, true));
}
fuse_all([core] + ridges) & cylinder(major / 2.0 + 1.0, length)
