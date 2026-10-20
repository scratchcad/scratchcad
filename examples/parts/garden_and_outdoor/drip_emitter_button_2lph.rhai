// Pressure-compensating button drip emitter, 2 l/h: 18 mm disc 7 mm thick, 4 mm barbed inlet, 4 mm outlet spout
let disc_diameter = 18.0; // [14.0, 26.0] Disc diameter (mm)
let disc_thickness = 7.0; // [5.0, 10.0] Disc thickness (mm)
let barb_diameter = 4.6; // [3.5, 6.0] Inlet barb diameter (mm)
let spout_diameter = 4.0; // [3.0, 6.0] Outlet spout diameter (mm)
let rd = disc_diameter / 2.0;
let body = cylinder(rd, disc_thickness).fillet(1.2, ">Z or <Z");
// split line between the two halves
body -= torus(rd + 0.2, 0.5).translate([0, 0, disc_thickness / 2.0]);
// inlet barb, pointing down into the poly pipe
let rb = barb_diameter / 2.0;
let barb = sketch("XZ").move_to(0, 0.5).hline_to(1.4).vline_to(-3.0).hline_to(rb).line_to(1.4, -6.5).hline_to(0).close().to_face().revolve("Z", 360);
let spout = sketch("XZ").move_to(0, disc_thickness - 0.5).hline_to(spout_diameter / 2.0).vline_to(disc_thickness + 3.0)
    .hline_to(spout_diameter / 2.0 - 0.5).vline_to(disc_thickness + 5.0).hline_to(0).close().to_face().revolve("Z", 360);
let part = fuse_all([body, barb, spout]);
part -= cylinder([0, 0, -8.0], "Z", 0.6, 9.5);
part -= cylinder([0, 0, disc_thickness - 1.0], "Z", 0.8, 7.0);
// flow arrow on top
let arrow = polygon([[-1.0, -4.5], [1.0, -4.5], [1.0, 3.0], [2.5, 3.0], [0, 5.5], [-2.5, 3.0], [-1.0, 3.0]]).to_face().extrude(0.6);
part - arrow.translate([rd * 0.45, 0, disc_thickness - 0.4])
