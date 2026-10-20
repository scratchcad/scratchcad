// Modular DIN rail enclosure shell, 2 modules: 35 mm wide, 90 mm tall back with 45 mm tall front nose, 58 mm deep overall (44 mm to the shoulder), 2 mm walls, 4 mm thick back with a 35.5 x 1.5 mm rail seat across it and an open side for the PCB
let modules = 2; // [1, 6] Number of modules
let depth = 58.0; // [50.0, 70.0] Overall depth (mm)
let shoulder = 44.0; // [35.0, 48.0] Depth to the front shoulder (mm)
const wall = 2.0;
const pitch = 17.5;
let w = modules.to_float() * pitch;
let profile = polygon([
    [0, 0, -45.0], [0, shoulder, -45.0], [0, shoulder, -22.5], [0, depth, -22.5],
    [0, depth, 22.5], [0, shoulder, 22.5], [0, shoulder, 45.0], [0, 0, 45.0]]);
let inner_profile = polygon([
    [0, wall, -45.0 + wall], [0, shoulder - wall, -45.0 + wall], [0, shoulder - wall, -22.5 + wall], [0, depth - wall, -22.5 + wall],
    [0, depth - wall, 22.5 - wall], [0, shoulder - wall, 22.5 - wall], [0, shoulder - wall, 45.0 - wall], [0, wall, 45.0 - wall]]);
let body = face(profile).extrude([w, 0, 0]);
let cavity = face(inner_profile).extrude([w, 0, 0]).translate([wall, 0, 0]);
let groove = box_from_corners([-1.0, -1.0, -17.75], [w + 1.0, 1.5, 17.75]);
let shell = body - cavity;
let back = box_from_corners([0, 0, -25.0], [w, 4.0, 25.0]);
shell + back - groove
