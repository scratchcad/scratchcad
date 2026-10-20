// Spice jar shaker fitment for a 45 mm jar mouth: 44 mm flange 1.5 mm thick, 38 mm push-in plug 6 mm deep with two sealing beads, nine 3 mm sifter holes on one half and a 16 x 22 mm spoon opening on the other
let flange_diameter = 44.0; // [30.0, 70.0] Flange diameter (mm)
let plug_diameter = 38.0; // [25.0, 60.0] Plug diameter (mm)
let plug_depth = 6.0; // [3.0, 10.0] Plug depth (mm)
let hole_diameter = 3.0; // [1.5, 5.0] Sifter hole diameter (mm)
let wall = 1.2; // [0.8, 2.0] Plug wall (mm)
let rp = min(plug_diameter / 2.0, flange_diameter / 2.0 - 1.0);
let fit = cylinder(flange_diameter / 2.0, 1.5).chamfer(0.4, "%CIRCLE and >Z");
let plug = cylinder([0, 0, -plug_depth], "Z", rp, plug_depth + 0.1) - cylinder([0, 0, -plug_depth - 1.0], "Z", rp - wall, plug_depth + 1.0);
for z in [-plug_depth + 1.5, -plug_depth + 3.5] { plug += torus(rp - 0.1, 0.5).translate([0, 0, z]); }
fit = fit + plug;
// sifter holes on the -X half, spoon opening on the +X half
let cuts = [];
for p in [[-6.0, 0.0], [-11.0, 0.0], [-16.0, 0.0], [-8.5, 5.0], [-13.5, 5.0], [-8.5, -5.0], [-13.5, -5.0], [-11.0, 10.0], [-11.0, -10.0]] {
    cuts.push(cylinder([p[0] * rp / 19.0, p[1] * rp / 19.0, -1.0], "Z", hole_diameter / 2.0, 3.0));
}
cuts.push(face(rect(rp * 0.6, rp * 1.1).offset(3.0)).extrude([0, 0, 3.0]).translate([rp * 0.5, 0, -1.0]));
fit - compound(cuts)
