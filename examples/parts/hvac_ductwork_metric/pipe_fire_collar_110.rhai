// Intumescent fire collar for a 110 mm plastic pipe: 112 mm ID, 50 mm tall C-section steel case 1 mm with 12 mm intumescent liner, 4 fixing lugs 25 x 20 mm with 6.5 mm holes at the base
let pipe_d = 112.0; // [40.0, 200.0] Pipe size the collar fits (mm)
let height = 50.0; // [30.0, 80.0] Collar height (mm)
let liner = 12.0; // [6.0, 20.0] Intumescent liner thickness (mm)
let lug_count = 4; // [3, 8] Number of fixing lugs
const case_t = 1.0;
const lug_l = 25.0;
let ri = pipe_d / 2.0;
let ro = ri + liner + case_t;
// liner and case as one revolved section: liner ring, outer case wall, top and bottom returns
let prof = polygon([[ri, 0, case_t], [ri + liner * 0.5, 0, case_t], [ri + liner * 0.5, 0, 0], [ro, 0, 0], [ro, 0, height], [ri + liner * 0.5, 0, height], [ri + liner * 0.5, 0, height - case_t], [ri, 0, height - case_t]]);
let collar = prof.to_face().revolve("Z", 360);
let lugs = [];
for k in 0..lug_count {
    let lug = box_from_corners([ro - 2.0, -10.0, 0], [ro + lug_l, 10.0, 2.0]) - cylinder([ro + lug_l - 8.0, 0, -1], "Z", 3.25, 4.0);
    lugs.push(lug.rotate_z(k.to_float() * 360.0 / lug_count.to_float()));
}
collar + fuse_all(lugs)
