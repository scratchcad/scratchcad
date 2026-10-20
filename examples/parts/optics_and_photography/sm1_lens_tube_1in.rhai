// Thorlabs SM1L10 lens tube: 30.5 mm OD, 1.035"-40 (SM1) internal thread 1 in deep (shown as its 25.6 mm minor bore with lead-in chamfers), external SM1 coupling stub 3.8 mm long, 22.9 mm clear aperture through it
let thread_depth = 25.4; // [6.0, 76.2] Internal thread depth (mm)
let outer_diameter = 30.5; // [28.0, 34.0] Tube outside diameter (mm)
let stub_length = 3.8; // [2.0, 6.0] External stub length (mm)
let groove_count = 2; // [0, 6] Number of engraved grip rings
const r_major = 13.1445;
const r_minor = 12.8;
let tube = cylinder(outer_diameter / 2.0, thread_depth) - cylinder([0, 0, -1.0], "Z", r_minor, thread_depth + 2.0);
tube = tube.chamfer(0.4, tube.edges("%CIRCLE").filter(|e| e.radius() > outer_diameter / 2.0 - 0.1));
// thread lead-in at the open end
tube -= cone(r_minor, r_major + 0.2, r_major + 0.2 - r_minor).translate([0, 0, thread_depth - (r_major + 0.2 - r_minor) + 0.01]);
// shallow engraved grip rings, evenly spaced
for i in 0..groove_count {
    let z = thread_depth * (i + 1).to_float() / (groove_count + 1).to_float();
    tube -= torus(outer_diameter / 2.0 + 0.1, 0.4).translate([0, 0, z]);
}
let stub = cylinder([0, 0, -stub_length], "Z", r_major, stub_length + 0.5) - cylinder([0, 0, -stub_length - 1.0], "Z", 11.45, stub_length + 2.0);
tube + stub.chamfer(0.3, "%CIRCLE and <Z")
