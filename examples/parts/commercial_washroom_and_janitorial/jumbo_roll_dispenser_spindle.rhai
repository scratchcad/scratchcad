// Jumbo toilet roll dispenser spindle for 76 mm (3 inch) cores: a 75 mm finned hub 60 mm long (six 3 mm radial fins on a 30 mm drum with 1.5 mm lead-in chamfers), and a 12 mm axle stub 15 mm long at each end
let core_d = 75.0; // [40.0, 76.0] Hub diameter over the fins (mm)
let hub_len = 60.0; // [30.0, 100.0] Hub length (mm)
let fins = 6; // [3, 12] Number of radial fins
let stub_d = 12.0; // [8.0, 16.0] Axle stub diameter (mm)
let stub_len = 15.0; // [8.0, 25.0] Axle stub length (mm)
const drum_d = 30.0;
const fin_t = 3.0;
let rf = core_d / 2.0;
let rd = min(drum_d / 2.0, rf - 5.0);
let drum = cylinder([0, 0, 0], "Z", rd, hub_len);
let parts = [drum];
for i in 0..fins {
    let fin = face(polygon([[rd - 1.0, 0, 0], [rf - 1.5, 0, 0], [rf, 0, 1.5], [rf, 0, hub_len - 1.5], [rf - 1.5, 0, hub_len], [rd - 1.0, 0, hub_len]])).extrude([0, fin_t, 0]).translate([0, -fin_t / 2.0, 0]);
    parts.push(fin.rotate_z(i.to_float() * 360.0 / fins.to_float()));
}
let sr = min(stub_d / 2.0, rd - 2.0);
parts.push(cylinder([0, 0, -stub_len], "Z", sr, stub_len + 0.5));
parts.push(cylinder([0, 0, hub_len - 0.5], "Z", sr, stub_len + 0.5));
fuse_all(parts)
