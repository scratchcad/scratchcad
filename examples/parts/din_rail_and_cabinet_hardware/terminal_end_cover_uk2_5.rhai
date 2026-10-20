// End cover plate for 2.5 mm2 screw terminal blocks on TS35 rail: 2.2 mm thick, 42 mm long stepped terminal profile 47 mm tall over the rail, rail notch with hooks for the 35 mm flanges, two 3 mm locating pegs 1.5 mm tall
let thickness = 2.2; // [1.5, 3.0] Plate thickness (mm)
let length = 42.0; // [38.0, 60.0] Terminal length (mm)
let height = 47.0; // [35.0, 55.0] Height above the rail (mm)
const lip = 2.3;
let a = length / 2.0;
let profile = polygon([
    [0, -a, -lip], [0, -15.5, -lip], [0, -15.5, -1.2], [0, -17.7, -1.2], [0, -17.7, 0],
    [0, 17.7, 0], [0, 17.7, -1.2], [0, 15.5, -1.2], [0, 15.5, -lip], [0, a, -lip], [0, a, height * 0.45], [0, a - 6.0, height * 0.6],
    [0, 7.0, height * 0.6], [0, 7.0, height], [0, -7.0, height], [0, -7.0, height * 0.6], [0, -a + 6.0, height * 0.6], [0, -a, height * 0.45]]);
let plate = face(profile).extrude([thickness, 0, 0]);
let pegs = cylinder([thickness - 0.5, -a + 8.0, height * 0.3], "X", 1.5, 2.0) + cylinder([thickness - 0.5, a - 8.0, height * 0.3], "X", 1.5, 2.0);
plate + pegs
