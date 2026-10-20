// 52-58 mm step-up ring: M52 x 0.75 male thread 3 mm long (shown as a band), M58 x 0.75 female thread 3.5 mm deep in a 60 mm flange, 1.5 mm web, 49.5 mm aperture
let lens_thread = 52.0; // [37.0, 77.0] Lens side thread (mm)
let filter_thread = 58.0; // [40.5, 95.0] Filter side thread (mm)
let male_length = 3.0; // [2.0, 4.0] Male thread length (mm)
let female_depth = 3.5; // [2.5, 5.0] Female thread depth (mm)
let web = 1.5; // [1.0, 3.0] Web thickness (mm)
let rf = max(filter_thread, lens_thread + 3.0) / 2.0;
let rl = lens_thread / 2.0;
let flange = cylinder(rf + 1.0, web + female_depth).chamfer(0.4, "%CIRCLE and >Z");
let male = cylinder([0, 0, -male_length], "Z", rl - 0.05, male_length + 0.5).chamfer(0.3, "%CIRCLE and <Z");
let ring = flange + male;
ring -= cylinder([0, 0, web], "Z", rf - 0.4, female_depth + 1.0);
ring -= cylinder([0, 0, -male_length - 1.0], "Z", rl - 1.25, male_length + web + 2.0);
ring
