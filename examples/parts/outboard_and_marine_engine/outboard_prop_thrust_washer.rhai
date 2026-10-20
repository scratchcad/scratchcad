// Outboard propeller thrust washer for a 3/4 in (19 mm) prop shaft: 19.3 mm bore, 50 mm OD, 8 mm thick, with the front 4 mm tapered at 30 degrees down to a 36 mm nose that seats in the prop hub, and 0.5 mm edge breaks
let shaft_d = 19.0; // [12.0, 25.4] Prop shaft diameter (mm)
let outer_d = 50.0; // [36.0, 70.0] Washer diameter (mm)
let thickness = 8.0; // [5.0, 14.0] Washer thickness (mm)
const taper_h = 4.0;
let ri = shaft_d / 2.0 + 0.15;
let ro = outer_d / 2.0;
let rn = max(ro - taper_h * tan(60.0 * PI() / 180.0), ri + 2.0);
let profile = polygon([[ri + 0.5, 0, 0], [ro - 0.5, 0, 0], [ro, 0, 0.5], [ro, 0, thickness - taper_h], [rn, 0, thickness], [ri + 0.5, 0, thickness], [ri, 0, thickness - 0.5], [ri, 0, 0.5]]);
face(profile).revolve("Z", 360.0)
