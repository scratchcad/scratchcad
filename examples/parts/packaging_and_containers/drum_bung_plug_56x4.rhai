// Plastic drum bung plug, 2 inch (56 x 4 buttress thread): 64 mm flange 6 mm thick with a gasket groove and a 40 x 8 mm wrench bar, 16 mm hollow threaded plug with a 4 mm pitch buttress thread on a 51.6 mm root
let flange_diameter = 64.0; // [58.0, 75.0] Flange diameter (mm)
let flange_thickness = 6.0; // [4.0, 10.0] Flange thickness (mm)
let plug_length = 16.0; // [10.0, 25.0] Threaded length (mm)
let wall = 3.0; // [2.0, 5.0] Plug wall (mm)
let bar_height = 5.0; // [3.0, 10.0] Wrench bar height (mm)
const pitch = 4.0;
const r_major = 28.0;
const r_minor = 25.8;
let rf = max(flange_diameter / 2.0, r_major + 3.0);
let bung = cylinder(rf, flange_thickness).fillet(1.0, ">Z");
bung = bung + box_centered(40.0, 8.0, bar_height + 0.5).translate([0, 0, flange_thickness + bar_height / 2.0 - 0.25]).fillet(1.5, "|Z");
// gasket groove under the flange, just outside the thread
bung = bung - (cylinder([0, 0, -1], "Z", r_major + 3.0, 2.5) - cylinder([0, 0, -2], "Z", r_major + 0.3, 5.0));
let plug = cylinder([0, 0, -plug_length - 2.0], "Z", r_minor, plug_length + 2.1);
// buttress section: flat load flank facing the flange, sloped flank facing the tip; ridge runs past the plug end and is trimmed
let section = polygon([[r_minor - 0.3, 0, -1.8], [r_major, 0, 0.1], [r_major, 0, 0.6], [r_minor - 0.3, 0, 0.6]]);
let turns = (plug_length / pitch).ceiling().to_int() + 1;
let sections = [];
for i in 0..=(turns * 12) {
    let t = i.to_float() / 12.0;
    sections.push(section.rotate_z(t * 360.0).translate([0, 0, -plug_length - pitch + t * pitch]));
}
let threaded = (plug + loft(sections, true)) & cylinder([0, 0, -plug_length], "Z", r_major + 1.0, plug_length - 0.6);
threaded = threaded.chamfer(0.8, "%CIRCLE and <Z and (not %BSPLINE)");
bung = bung + threaded + cylinder([0, 0, -1.0], "Z", r_minor, 1.1);
bung - cylinder([0, 0, -plug_length - 1.0], "Z", r_minor - wall, plug_length + 1.0 + flange_thickness - 2.0)
