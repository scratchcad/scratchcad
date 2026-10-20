// Split key ring, 25 mm outside diameter: two turns of 2.4 x 1.0 mm flat wire at a 1.2 mm pitch
let outer_diameter = 25.0; // [15.0, 40.0] Outside diameter (mm)
let wire_width = 2.4; // [1.5, 3.5] Flat wire width (mm)
let wire_thickness = 1.0; // [0.6, 1.5] Flat wire thickness (mm)
let turns = 2.0; // [1.5, 2.5] Number of turns
const per_turn = 16;
let rm = outer_diameter / 2.0 - wire_width / 2.0;
let pitch = wire_thickness + 0.2;
let hw = wire_width / 2.0;
let ht = wire_thickness / 2.0;
let section = polygon([[rm - hw, 0, -ht], [rm + hw, 0, -ht], [rm + hw, 0, ht], [rm - hw, 0, ht]]);
let n = (turns * per_turn.to_float()).to_int();
let sections = [];
for i in 0..=n {
    let t = i.to_float() / per_turn.to_float();
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
}
loft(sections, true).translate([0, 0, ht])
