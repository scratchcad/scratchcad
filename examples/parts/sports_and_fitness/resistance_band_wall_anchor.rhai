// Resistance band wall anchor: 80 x 80 x 6 mm wall plate, 12 mm wide arched loop 50 mm across with a 30 mm opening, four 5 mm countersunk screw holes on 60 mm
let plate_size = 80.0; // [60.0, 120.0] Plate size (mm)
let plate_t = 6.0; // [4.0, 10.0] Plate thickness (mm)
let loop_span = 50.0; // [36.0, 70.0] Loop outer span (mm)
let loop_bar = 10.0; // [6.0, 14.0] Loop bar thickness (mm)
let loop_width = 12.0; // [8.0, 20.0] Loop width (mm)
let hole_spacing = 60.0; // [40.0, 100.0] Screw hole spacing (mm)
const screw = 5.0;
let ro = loop_span / 2.0;
let ri = ro - min(loop_bar, ro - 8.0);
let plate = box_centered(plate_size, plate_size, plate_t).translate([0, 0, plate_t / 2.0]).fillet(10.0, "|Z").fillet(1.0, ">Z");
let arch = sketch("XZ").move_to(ro, 0).arc_to(0, ro, -ro, 0).hline_to(-ri).arc_to(0, ri, ri, 0).close();
let band_loop = arch.to_face().extrude([0, loop_width, 0]).translate([0, -loop_width / 2.0, plate_t - 0.5]);
let anchor = plate + band_loop;
let hs = min(hole_spacing, plate_size - 14.0) / 2.0;
for sx in [-1.0, 1.0] {
    for sy in [-1.0, 1.0] {
        anchor = anchor - cylinder([sx * hs, sy * hs, -1.0], "Z", screw / 2.0, plate_t + 2.0) - cone(screw / 2.0, screw / 2.0 + 2.5, 2.5).translate([sx * hs, sy * hs, plate_t - 2.49]);
    }
}
anchor
