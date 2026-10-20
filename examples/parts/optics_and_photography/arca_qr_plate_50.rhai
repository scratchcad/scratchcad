// Arca-Swiss compatible camera quick-release plate: 50 x 38 mm, 10 mm thick, 45 deg dovetail on both long sides, 6.5 mm slot for a 1/4-20 camera screw with a counterbore underneath, anti-twist lip
let length = 50.0; // [40.0, 120.0] Plate length (mm)
let width = 38.0; // [36.0, 40.0] Dovetail width at the base (mm)
let thickness = 10.0; // [8.0, 14.0] Plate thickness (mm)
let dovetail_height = 4.0; // [3.0, 6.0] Dovetail height (mm)
let slot_length = 22.0; // [8.8, 80.0] Screw slot length (mm)
let w = width / 2.0;
let profile = polygon("YZ", [[-w, 0.4], [-w + 0.4, 0], [w - 0.4, 0], [w, 0.4], [w - dovetail_height + 0.4, dovetail_height], [w - dovetail_height + 0.4, thickness],
                             [-w + dovetail_height - 0.4, thickness], [-w + dovetail_height - 0.4, dovetail_height]]);
let plate = profile.to_face().extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
plate = plate.fillet(1.0, "|X and >Z");
// camera screw slot, counterbored from below for the screw head
let sl = min(slot_length, length - 16.0);
let slot = box_centered(sl, 6.5, thickness + 2.0).translate([0, 0, thickness / 2.0]) + cylinder([-sl / 2.0, 0, -1], "Z", 3.25, thickness + 2.0) + cylinder([sl / 2.0, 0, -1], "Z", 3.25, thickness + 2.0);
let counterbore = box_centered(sl, 12.0, 8.0).translate([0, 0, 2.5]) + cylinder([-sl / 2.0, 0, -2.0], "Z", 6.0, 8.5) + cylinder([sl / 2.0, 0, -2.0], "Z", 6.0, 8.5);
plate = plate - (slot + counterbore);
// anti-twist lip at the front edge
let lip = box_from_corners([length / 2.0 - 3.0, -w + dovetail_height - 0.4, thickness - 0.1], [length / 2.0, w - dovetail_height + 0.4, thickness + 2.5]);
plate + lip.fillet(0.8, "|Y and >Z")
