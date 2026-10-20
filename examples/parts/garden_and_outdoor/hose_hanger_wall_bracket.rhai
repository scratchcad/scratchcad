// Wall-mounted garden hose hanger: 150 mm wide curved saddle reaching 150 mm from the wall, 10 mm thick, front lip, 100 mm back plate with three screw holes
let width = 150.0; // [80.0, 250.0] Saddle width (mm)
let reach = 150.0; // [80.0, 250.0] Reach from the wall (mm)
let thickness = 10.0; // [6.0, 16.0] Arm thickness (mm)
let crown = 22.0; // [5.0, 40.0] Saddle crown height (mm)
let lip = 20.0; // [10.0, 40.0] Front lip height (mm)
let t = thickness;
let profile = sketch("YZ").move_to(0, -60.0).vline_to(40.0).hline_to(6.0).vline_to(t)
    .arc_to(reach / 2.0, t + crown, reach, t).line_to(reach + 10.0, t + lip).hline(t * 0.8).line_to(reach + 8.0, 0)
    .hline_to(reach).arc_to(reach / 2.0, crown, 6.0, 0).vline_to(-60.0).close();
let hanger = profile.to_face().extrude(width).translate([-width / 2.0, 0, 0]);
let holes = [];
for p in [[-width / 2.0 + 20.0, 25.0], [width / 2.0 - 20.0, 25.0], [0, -45.0]] {
    holes.push(cylinder([p[0], -1.0, p[1]], "Y", 2.5, 10.0));
    holes.push(cone(2.5, 5.5, 3.0).rotate_x(90.0).translate([p[0], 6.01, p[1]]));
}
hanger - fuse_all(holes)
