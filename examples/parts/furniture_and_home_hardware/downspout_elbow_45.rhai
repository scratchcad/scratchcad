// 75 mm round downspout elbow, 45 deg: 2 mm wall, 60 mm bend radius, 50 mm straight legs
let d = 75.0; // [50.0, 120.0] Pipe diameter (mm)
let bend = 45.0; // [15.0, 90.0] Bend angle (deg)
let R = 60.0; // [40.0, 150.0] Bend radius (mm)
let r = d / 2.0;
let a = bend * PI() / 180.0;
let wedge = polygon([[0, 0], [300, 0], [300.0 * a.cos(), 300.0 * a.sin()]]).to_face().extrude(2.0 * d).translate([0, 0, -d]);
if bend > 60.0 { wedge = wedge + polygon([[0, 0], [300, 0], [0, 300]]).to_face().extrude(2.0 * d).translate([0, 0, -d]) & (polygon([[0, 0], [300, 0], [300.0 * a.cos(), 300.0 * a.sin()]]).to_face().extrude(2.0 * d).translate([0, 0, -d]) + cylinder([0, 0, -d], "Z", 1.0, 1.0)); }
let end = [R * a.cos(), R * a.sin(), 0];
let dir = [-a.sin(), a.cos(), 0];
let outer = fuse_all([torus(R, r) & wedge, cylinder([R, -50.0, 0], "Y", r, 50.0), cylinder(end, dir, r, 50.0)]);
let inner = fuse_all([torus(R, r - 2.0) & wedge, cylinder([R, -51.0, 0], "Y", r - 2.0, 51.5), cylinder([end[0] - dir[0] * 0.5, end[1] - dir[1] * 0.5, 0], dir, r - 2.0, 51.5)]);
outer - inner
