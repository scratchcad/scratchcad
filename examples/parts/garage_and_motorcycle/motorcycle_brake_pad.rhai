// Motorcycle disc brake pad: arc-shaped 3.5 mm steel backing plate on a 127 mm mean radius, 34 mm tall, 26 degree span, ear with a 5 mm hanger pin hole, 8 mm friction block with a centre slot and chamfered ends
let mean_r = 127.0; // [90.0, 160.0] Mean radius on the disc (mm)
let pad_height = 34.0; // [24.0, 45.0] Pad height (mm)
let span = 26.0; // [16.0, 40.0] Pad span (degrees)
let plate_t = 3.5; // [2.5, 5.0] Backing plate thickness (mm)
let friction_t = 8.0; // [4.0, 10.0] Friction material thickness (mm)
let pin_d = 5.0; // [3.0, 7.0] Hanger pin hole (mm)
fn sector(r1, r2, deg) {
    let h = deg / 2.0 * PI() / 180.0;
    sketch("XY").move_to(r1 * h.cos(), -r1 * h.sin()).line_to(r2 * h.cos(), -r2 * h.sin()).arc_to(r2, 0, r2 * h.cos(), r2 * h.sin())
        .line_to(r1 * h.cos(), r1 * h.sin()).arc_to(r1, 0, r1 * h.cos(), -r1 * h.sin()).close()
}
let r1 = mean_r - pad_height / 2.0;
let r2 = mean_r + pad_height / 2.0;
let plate = sector(r1, r2, span).to_face().extrude([0, 0, plate_t]);
let ear = box_from_corners([r2 - 14.0, -6.0, 0], [r2 + 9.0, 6.0, plate_t]).fillet(5.9, "|Z and >X");
plate = (plate + ear) - cylinder([r2 + 3.0, 0, -1.0], "Z", pin_d / 2.0, plate_t + 2.0);
let block = sector(r1 + 1.5, r2 - 1.5, span - 2.0).to_face().extrude([0, 0, friction_t]).translate([0, 0, plate_t - 0.01]);
block = block.chamfer(2.0, block.edges(">Z").filter(|e| e.geom_type() == "line"));
block = block - box_from_corners([r1, -1.0, plate_t + 2.0], [r2 + 1.0, 1.0, plate_t + friction_t + 1.0]);
(plate + block).translate([-mean_r, 0, 0])
