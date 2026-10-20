// USB-C receptacle panel bezel: 22 x 12 x 2 mm plate, 9.4 x 3.8 mm stadium opening (8.4 x 2.6 mm plug shell plus clearance), M2 holes 16 mm apart, rear shroud 1.2 mm wall 6 mm deep around a 9.2 x 3.4 mm receptacle
let plate_w = 22.0; // [18.0, 32.0] Plate width (mm)
let plate_h = 12.0; // [8.0, 18.0] Plate height (mm)
let thick = 2.0; // [1.2, 3.5] Plate thickness (mm)
let open_w = 9.4; // [8.8, 12.0] Opening width (mm)
let open_h = 3.8; // [3.0, 6.0] Opening height (mm)
let shroud = 6.0; // [0.0, 10.0] Shroud depth (mm)
let hole_spacing = 16.0; // [14.0, 26.0] Screw hole spacing (mm)
let pw = max(plate_w, max(hole_spacing, open_w + 5.0) + 5.0);
let ph = max(plate_h, open_h + 5.0);
let plate = box_centered(pw, ph, thick).translate([0, 0, thick / 2.0]);
let plate = plate.fillet(min(ph * 0.3, 3.0), plate.edges("|Z"));
let parts = [plate];
let ow = max(open_w, open_h + 0.2);
if shroud > 0.5 {
    let rw = ow + 2.4;
    let rh = open_h + 2.4;
    let outer = box_centered(rw - rh, rh, shroud + 0.5).translate([0, 0, thick + shroud / 2.0 - 0.25]) + cylinder([-(rw - rh) / 2.0, 0, thick - 0.5], "Z", rh / 2.0, shroud + 0.5) + cylinder([(rw - rh) / 2.0, 0, thick - 0.5], "Z", rh / 2.0, shroud + 0.5);
    parts.push(outer);
}
let stadium = box_centered(ow - open_h, open_h, 40.0) + cylinder([-(ow - open_h) / 2.0, 0, -20], "Z", open_h / 2.0, 40.0) + cylinder([(ow - open_h) / 2.0, 0, -20], "Z", open_h / 2.0, 40.0);
let hs = max(hole_spacing, ow + 5.0);
fuse_all(parts) - stadium - cylinder([-hs / 2.0, 0, -1], "Z", 1.1, thick + 2.0) - cylinder([hs / 2.0, 0, -1], "Z", 1.1, thick + 2.0)
