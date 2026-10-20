// 52 mm screw-in photographic filter: M52 x 0.75 male thread 3 mm long at the back (shown as a 51.9 mm band), M52 x 0.75 female front thread, 54.5 mm knurled rim 5 mm tall, 2 mm glass held in a seat
let thread_size = 52.0; // [37.0, 82.0] Filter thread size (mm)
let rim_height = 5.0; // [3.0, 8.0] Rim height (mm)
let thread_length = 3.0; // [2.0, 4.0] Male thread length (mm)
let glass_thickness = 2.0; // [1.0, 3.0] Glass thickness (mm)
let knurl_count = 60; // [0, 120] Number of knurl grooves on the rim
let r = thread_size / 2.0;
let r_rim = r + 1.25;
// male thread band below z = 0, rim above
let band = cylinder([0, 0, -thread_length], "Z", r - 0.05, thread_length + 0.5).chamfer(0.3, "%CIRCLE and <Z");
let rim = cylinder(r_rim, rim_height);
rim = rim.chamfer(0.4, "%CIRCLE");
let knurls = [];
for i in 0..knurl_count {
    knurls.push(cylinder([r_rim + 0.05, 0, 0.8], "Z", 0.35, rim_height - 1.6).rotate_z(i.to_float() * 360.0 / knurl_count.to_float()));
}
if knurl_count > 0 { rim = rim - compound(knurls); }
let ring = rim + band;
// front female thread (minor bore 51.2 mm), glass seat, and clear aperture through the band
let seat_z = rim_height - 2.5 - glass_thickness;
ring -= cylinder([0, 0, seat_z], "Z", r - 0.4, rim_height);
ring -= cylinder([0, 0, -thread_length - 1.0], "Z", r - 1.4, thread_length + rim_height);
let glass = cylinder([0, 0, seat_z], "Z", r - 0.45, glass_thickness);
compound([ring, glass])
