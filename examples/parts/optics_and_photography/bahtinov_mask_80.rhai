// Bahtinov focusing mask for an 80 mm refractor: 96 mm disc 2 mm thick over an 80 mm aperture, slots 1.6 mm wide on a 3.2 mm pitch, one half parallel, two quarters at +/-20 deg, 92 mm push-on skirt 10 mm deep
let aperture = 80.0; // [50.0, 150.0] Clear aperture (mm)
let dew_shield = 92.0; // [55.0, 170.0] Dew shield outside diameter (mm)
let thickness = 2.0; // [1.5, 3.0] Mask thickness (mm)
let slot_width = 1.6; // [1.0, 3.0] Slot width (mm)
let angle = 20.0; // [10.0, 30.0] Angle of the tilted slots (deg)
let skirt_depth = 10.0; // [5.0, 20.0] Skirt depth (mm)
let ra = aperture / 2.0;
let rs = max(dew_shield / 2.0, ra + 2.0);
let mask = cylinder(rs + 2.0, thickness) + (cylinder([0, 0, -skirt_depth], "Z", rs + 2.0, skirt_depth + 0.1) - cylinder([0, 0, -skirt_depth - 1.0], "Z", rs + 0.2, skirt_depth + 1.0));
let pitch = 2.0 * slot_width;
let n = (2.0 * ra / pitch).floor().to_int() + 2;
fn slot_set(n, pitch, slot_width, ra, thickness, deg) {
    let s = [];
    for i in 0..n {
        let y = (i.to_float() - (n - 1).to_float() / 2.0) * pitch;
        s.push(box_centered(4.0 * ra, slot_width, thickness + 2.0).translate([0, y, thickness / 2.0]).rotate_z(deg));
    }
    compound(s)
}
// regions, separated by 3 mm bars: lower half, upper-left and upper-right quarters
let disc = cylinder([0, 0, -1.0], "Z", ra, thickness + 2.0);
let lower = disc & box_from_corners([-ra - 1.0, -ra - 1.0, -2.0], [ra + 1.0, -1.5, thickness + 2.0]);
let upper_left = disc & box_from_corners([-ra - 1.0, 1.5, -2.0], [-1.5, ra + 1.0, thickness + 2.0]);
let upper_right = disc & box_from_corners([1.5, 1.5, -2.0], [ra + 1.0, ra + 1.0, thickness + 2.0]);
let cuts = [slot_set(n, pitch, slot_width, ra, thickness, 90.0) & lower,
            slot_set(n, pitch, slot_width, ra, thickness, 90.0 + angle) & upper_left,
            slot_set(n, pitch, slot_width, ra, thickness, 90.0 - angle) & upper_right];
mask - compound(cuts)
