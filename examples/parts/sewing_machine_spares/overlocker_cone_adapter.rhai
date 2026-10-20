// Overlocker thread cone adapter: hollow cone 30 mm at the base tapering to 14 mm over 40 mm with 2 mm walls, 6.5 mm bore through a closed 6 mm thick top for the spool pin, so small spools sit on the cone holder
let base_d = 30.0; // [24.0, 40.0] Base diameter (mm)
let top_d = 14.0; // [11.0, 20.0] Top diameter (mm)
let height = 40.0; // [25.0, 60.0] Cone height (mm)
let bore = 6.5; // [5.0, 8.0] Pin bore (mm)
const wall = 2.0;
const cap = 6.0;
let rb = base_d / 2.0;
let rt = top_d / 2.0;
let k = (rb - rt) / height;
let ri_top = rt - wall + k * cap;
let rp = min(bore / 2.0, ri_top - 0.5);
let profile = polygon([
    [rb - wall, 0, 0], [rb, 0, 0], [rt, 0, height], [rp, 0, height], [rp, 0, height - cap], [ri_top, 0, height - cap]
]);
profile.to_face().revolve("Z", 360.0)
