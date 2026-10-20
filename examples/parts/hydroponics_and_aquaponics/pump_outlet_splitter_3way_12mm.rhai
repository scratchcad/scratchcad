// Hydroponic pump outlet splitter: a 30 mm hub 22 mm tall with a 3/4 inch (19 mm) barbed inlet 25 mm long underneath and three 12 mm barbed outlets 20 mm long at 120 degrees, 8 mm outlet bores and a 14 mm inlet bore into a 20 mm chamber
let outlets = 3; // [2, 6] Number of outlets
let outlet_barb = 12.0; // [8.0, 16.0] Outlet barb diameter (mm)
let outlet_len = 20.0; // [12.0, 35.0] Outlet length (mm)
let inlet_barb = 19.0; // [16.0, 25.0] Inlet barb diameter (mm)
const hub_r = 15.0;
const hub_h = 22.0;
let ri = inlet_barb / 2.0;
let rib = ri - 2.5;
let hub = cylinder([0, 0, 0], "Z", hub_r, hub_h);
let hub = hub.chamfer(1.0, hub.edges(">Z"));
const il = 25.0;
let inlet = face(polygon([[rib, 0, 0], [ri - 1.0, 0, 0], [ri, 0, il * 0.3], [ri - 1.0, 0, il * 0.3], [ri, 0, il * 0.6], [ri - 1.0, 0, il * 0.6], [ri - 1.0, 0, il + 0.5], [rib, 0, il + 0.5]])).revolve("Z", 360.0).translate([0, 0, -il]);
let ro = outlet_barb / 2.0;
let rob = min(4.0, ro - 1.5);
let ol = outlet_len + hub_r - 2.0;
let zc = hub_h / 2.0;
let parts = [hub, inlet];
let cuts = [cylinder([0, 0, -il - 1.0], "Z", rib, il + 2.0), cylinder([0, 0, 1.0], "Z", 10.0, hub_h - 4.0)];
for i in 0..outlets {
    let a = i.to_float() * 360.0 / outlets.to_float();
    let o = face(polygon([[rob, 0, 0], [ro - 0.8, 0, 0], [ro, 0, outlet_len * 0.3], [ro - 0.8, 0, outlet_len * 0.3], [ro, 0, outlet_len * 0.6], [ro - 0.8, 0, outlet_len * 0.6], [ro - 0.8, 0, ol], [rob, 0, ol]])).revolve("Z", 360.0);
    parts.push(o.rotate_y(-90.0).translate([hub_r + outlet_len, 0, zc]).rotate_z(a));
    cuts.push(cylinder([0, 0, zc], "X", rob, hub_r + outlet_len + 1.0).rotate_z(a));
}
fuse_all(parts) - fuse_all(cuts)
