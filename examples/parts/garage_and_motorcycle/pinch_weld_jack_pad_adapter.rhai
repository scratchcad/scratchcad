// Floor jack pinch-weld pad adapter: 65 mm puck 30 mm tall, 18 mm wide x 16 mm deep slot for the sill seam, 20 side grip grooves, 2 mm chamfers
let diameter = 65.0; // [56.0, 90.0] Diameter (mm)
let height = 30.0; // [20.0, 45.0] Height (mm)
let slot_width = 18.0; // [13.2, 22.2] Slot width (mm)
let slot_depth = 16.0; // [8.0, 25.0] Slot depth (mm)
let grooves = 20; // [0, 20] Number of grip grooves
let pad = cylinder(diameter / 2.0, height).chamfer(2.0, "%CIRCLE");
let sd = min(slot_depth, height - 6.0);
pad = pad - box_centered(slot_width, diameter + 2.0, sd + 1.0).translate([0, 0, height - sd / 2.0 + 0.5]);
let cuts = [];
for i in 0..grooves {
    cuts.push(cylinder([diameter / 2.0 + 0.6, 0, 4.0], "Z", 1.5, height - 8.0).rotate_z(i.to_float() * 360.0 / grooves.to_float() + 9.0));
}
if grooves > 0 { pad = pad - compound(cuts); }
pad.fillet(1.0, pad.edges("|Z").filter(|e| e.center().z > height - sd && abs(e.center().x) < slot_width))
