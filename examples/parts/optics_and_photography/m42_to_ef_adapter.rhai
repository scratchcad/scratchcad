// M42 x 1 (Pentax/Praktica screw mount) to Canon EF adapter: 1.46 mm flange spacer (45.46 - 44.0), M42 x 1 female thread (41.0 mm minor bore), EF bayonet ring 53.9 mm with three tabs on a 59 mm circle, 58 mm grip flange
let flange_diameter = 58.0; // [56.0, 64.0] Flange diameter (mm)
let spacer = 1.46; // [1.0, 3.0] Flange spacer thickness (mm)
let thread_bore = 41.0; // [40.5, 41.5] M42 thread minor bore (mm)
let thread_depth = 4.0; // [2.0, 6.0] M42 thread depth (mm)
let tab_thickness = 1.6; // [1.0, 2.5] Bayonet tab thickness (mm)
let rf = flange_diameter / 2.0;
// flange face sits on the camera's EF mount at z = 0; the M42 lens screws into the top
let flange = cylinder(rf, spacer);
let collar = cylinder([0, 0, spacer - 0.1], "Z", 23.5, thread_depth + 0.1).chamfer(0.3, "%CIRCLE and >Z");
let bayonet = cylinder([0, 0, -3.2], "Z", 26.95, 3.3);
let tabs = [];
for k in 0..3 {
    let half = [32.0, 26.5, 21.0][k];
    let wedge = polygon([[0, 0], [40.0 * (-half * PI() / 180.0).cos(), 40.0 * (-half * PI() / 180.0).sin()], [40.0, 0], [40.0 * (half * PI() / 180.0).cos(), 40.0 * (half * PI() / 180.0).sin()]])
        .to_face().extrude(tab_thickness).translate([0, 0, -3.2]);
    tabs.push(wedge.rotate_z(k.to_float() * 120.0));
}
let tab_ring = cylinder([0, 0, -3.2], "Z", 29.5, tab_thickness) - cylinder([0, 0, -4.0], "Z", 26.0, 3.0);
let body = fuse_all([flange, collar, bayonet, tab_ring & fuse_all(tabs)]);
body -= cylinder([0, 0, -5.0], "Z", thread_bore / 2.0, spacer + thread_depth + 6.0);
// locking-pin slot in the bayonet, lens release notch in the flange
body -= box_centered(3.0, 4.0, 4.0).translate([0, -27.0, -2.0]).rotate_z(-60.0);
body - cylinder([rf, 0, -1.0], "Z", 2.0, spacer + 2.0).rotate_z(150.0)
