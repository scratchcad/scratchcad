// Kart front wheel hub 95 mm long: 45 mm tube with 40 mm bearing seats 12 mm deep at each end (6203 bearings on a 17 mm stub axle), 30 mm bore between, and a 76 mm flange 8 mm thick at the outer end with three M8 tapped holes (6.8 mm core) on a 58 mm PCD
let hub_len = 95.0; // [60.0, 135.0] Hub length (mm)
let bearing_od = 40.0; // [35.0, 42.0] Bearing outside diameter (mm)
let pcd = 58.0; // [56.0, 70.0] Wheel stud circle (mm)
const flange_t = 8.0;
const seat = 12.0;
let rt = bearing_od / 2.0 + 2.5;
let rf = pcd / 2.0 + 9.0;
let ri = bearing_od / 2.0 - 5.0;
let rs = bearing_od / 2.0;
let profile = polygon([
    [rs, 0, 0], [rf - 1.0, 0, 0], [rf, 0, 1.0], [rf, 0, flange_t], [rt, 0, flange_t + 2.0], [rt, 0, hub_len - 1.0], [rt - 1.0, 0, hub_len],
    [rs, 0, hub_len], [rs, 0, hub_len - seat], [ri, 0, hub_len - seat], [ri, 0, seat], [rs, 0, seat]]);
let hub = face(profile).revolve("Z", 360.0);
let holes = [];
for i in 0..3 {
    let a = (i.to_float() * 120.0) * PI() / 180.0;
    holes.push(cylinder([pcd / 2.0 * cos(a), pcd / 2.0 * sin(a), -1.0], "Z", 3.4, flange_t + 2.0));
}
hub - fuse_all(holes)
