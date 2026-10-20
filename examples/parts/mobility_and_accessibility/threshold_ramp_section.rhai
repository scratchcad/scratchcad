// Threshold ramp section: door threshold ramp for wheelchairs, 200 mm wide module, 25 mm rise over 150 mm (1:6), hollow underside with 3 ribs, 3 mm tread grooves every 10 mm and two 5 mm countersunk fixings
// # Ramp
let rise = 25.0; // [10.0, 50.0] Ramp rise (mm)
let run = 150.0; // [60.0, 300.0] Ramp run (mm)
let width = 200.0; // [100.0, 400.0] Module width (mm)
// # Detail
let ribs = 3; // [2, 6] Number of underside ribs
let groove_pitch = 10.0; // [6.0, 20.0] Tread groove pitch (mm)
const top_land = 20.0;
const shell = 4.0;
let section = polygon("XZ", [[0.0, 0.0], [run + top_land, 0.0], [run + top_land, rise], [run, rise], [0.0, 1.5]]);
let ramp = section.to_face().extrude([0, -width, 0]);
let ramp_y = ramp.translate([0, width / 2.0, 0]);
let hollow = polygon("XZ", [[shell * 3.0, -1.0], [run + top_land - shell, -1.0], [run + top_land - shell, rise - shell], [run, rise - shell], [shell * 3.0, 1.5 + (rise - 1.5) * shell * 3.0 / run - shell]]).to_face().extrude([0, -(width - 2.0 * shell), 0]);
let hollow_y = hollow.translate([0, (width - 2.0 * shell) / 2.0, 0]);
let rs = [];
for i in 0..ribs {
    let y = -width / 2.0 + (i.to_float() + 1.0) * width / (ribs + 1).to_float();
    rs.push(box_centered(run + top_land, shell, rise * 2.0).translate([(run + top_land) / 2.0, y, 0]));
}
let body = ramp_y - (hollow_y - fuse_all(rs));
let grooves = [];
let n = ((run - 10.0) / groove_pitch).floor().to_int();
for i in 1..=n {
    let x = i.to_float() * groove_pitch;
    let z = 1.5 + (rise - 1.5) * x / run;
    grooves.push(box_centered(1.5, width - 10.0, 2.0).translate([x, 0, z]));
}
let screws = [];
for y in [-width / 4.0, width / 4.0] {
    screws.push(cylinder([run + top_land / 2.0, y, -1.0], "Z", 2.6, rise + 2.0));
    screws.push(cone(2.6, 5.2, 2.6).translate([run + top_land / 2.0, y, rise - 2.59]));
}
body - fuse_all(grooves) - fuse_all(screws)
