// 77-67 mm step-down ring: M77 x 0.75 male thread 3 mm long (shown as a band), M67 x 0.75 female thread 3.5 mm deep, 1.5 mm web, 64.5 mm aperture
let lens_thread = 77.0; // [49.0, 95.0] Lens side thread (mm)
let filter_thread = 67.0; // [37.0, 82.0] Filter side thread (mm)
let male_length = 3.0; // [2.0, 4.0] Male thread length (mm)
let female_depth = 3.5; // [2.5, 5.0] Female thread depth (mm)
let web = 1.5; // [1.0, 3.0] Web thickness (mm)
let rl = lens_thread / 2.0;
let rf = min(filter_thread / 2.0, rl - 2.0);
// the male thread band is the outside of the ring; the female thread is bored into its face
let ring = cylinder([0, 0, -male_length], "Z", rl - 0.05, male_length + web + female_depth);
ring = ring + cylinder([0, 0, web + female_depth - 1.2], "Z", rl + 1.0, 1.2);
ring = ring.chamfer(0.3, "%CIRCLE and <Z");
ring -= cylinder([0, 0, web], "Z", rf - 0.4, female_depth + 1.0);
ring -= cylinder([0, 0, -male_length - 1.0], "Z", rf - 1.25, male_length + web + 2.0);
// open the male side out to leave a 1.6 mm thread wall
ring -= cylinder([0, 0, -male_length - 1.0], "Z", rl - 1.65, male_length + 1.0);
ring
