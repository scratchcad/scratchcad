// External retaining ring DIN 471 for a 20 mm shaft: 1.2 mm thick, 18.5 mm free inner diameter, 2.6 mm radial width tapering toward the lugs, 2 mm lug holes, 4 mm lug height
let shaft = 20.0; // [10.0, 34.4] Shaft diameter (mm)
let thickness = 1.2; // [0.6, 3.0] Ring thickness (mm)
let inner_diameter = 18.5; // [9.0, 57.0] Free inner diameter (mm)
let ring_width = 2.6; // [1.0, 6.0] Radial width at the back (mm)
const lug_hole = 2.0;
let ri = min(inner_diameter / 2.0, shaft / 2.0 - 0.2);
let w = ring_width;
let off = w * 0.25;
let ro = ri + w - off;
let ring = cylinder([0, -off, 0], "Z", ro, thickness) - cylinder([0, 0, -1], "Z", ri, thickness + 2.0);
let gap = shaft * 0.28;
ring = ring - box_from_corners([-gap / 2.0, 0, -1], [gap / 2.0, ro + 2.0, thickness + 1.0]);
let lug_r = lug_hole / 2.0 + 1.2;
let lx = gap / 2.0 + lug_r;
let ly = ri + lug_r * 0.6;
let lugs = [];
for s in [-1.0, 1.0] {
    lugs.push(cylinder([s * lx, ly, 0], "Z", lug_r, thickness));
}
ring = fuse_all([ring] + lugs);
ring - cylinder([-lx, ly, -1], "Z", lug_hole / 2.0, thickness + 2.0) - cylinder([lx, ly, -1], "Z", lug_hole / 2.0, thickness + 2.0)
