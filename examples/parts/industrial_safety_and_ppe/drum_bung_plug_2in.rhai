// Steel drum bung plug: 2 in NPS bung (G2, 60 mm major, 11 tpi), 14 mm thread length, 68 mm flange 4 mm with a 2 mm gasket groove underneath, internal 25 mm bung-wrench lugs
let major = 59.6; // [55.0, 62.0] Thread major diameter (mm)
let pitch = 2.31; // [1.8, 3.2] Thread pitch (mm)
let thread_length = 14.0; // [10.0, 20.0] Thread length (mm)
let flange = 68.0; // [64.0, 76.0] Flange diameter (mm)
let depth = pitch * 0.6;
let turns = (thread_length / pitch).floor().to_int();
let pts = [[0.0, 0.0], [major / 2.0 - depth, 0.0]];
for i in 0..turns {
    let z = i.to_float() * pitch;
    pts.push([major / 2.0, z + pitch * 0.45]);
    pts.push([major / 2.0 - depth, z + pitch * 0.9]);
}
let top = turns.to_float() * pitch;
pts.push([major / 2.0 - depth, top + 0.5]);
pts.push([flange / 2.0, top + 0.5]);
pts.push([flange / 2.0, top + 4.5]);
pts.push([0.0, top + 4.5]);
let plug = polygon("XZ", pts).to_face().revolve([0, 0, 0], "Z", 360);
let groove = cylinder([0, 0, top - 0.5], "Z", major / 2.0 + 3.0, 3.0) - cylinder([0, 0, top - 1.0], "Z", major / 2.0 + 1.0, 5.0);
// recessed top with two wrench lugs across a 25 mm slot
let recess = cylinder([0, 0, top + 4.5 - 10.0], "Z", major / 2.0 - depth - 4.0, 11.0);
let lugs = box_centered(major - 2.0 * depth - 8.0, 8.0, 10.0).translate([0, 0, top + 4.5 - 5.0]) - box_centered(25.0, 10.0, 12.0).translate([0, 0, top + 4.5 - 5.0]);
plug - groove - recess + lugs
