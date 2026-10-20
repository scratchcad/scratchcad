// 16-tooth Shimano HG cassette cog: 1/2 in pitch, 1.8 mm thick, 9-spline bore (one wide) for a 34.9 mm freehub body
let teeth = 16; // [14, 21] Teeth
let thick = 1.8; // [1.6, 2.2] Thickness (mm)
let n = teeth.to_float();
let rp = 12.7 / (2.0 * (PI() / n).sin());
let ro = rp + 0.28 * 12.7;
const seat = 4.0;
let cog = cylinder(ro, thick) - cylinder([0, 0, -1], "Z", 16.95, thick + 2.0);
let gap = cylinder([rp, 0, -1], "Z", seat, thick + 2.0) + polygon([[rp, -seat], [ro + 1.0, -seat - 1.8], [ro + 1.0, seat + 1.8], [rp, seat]]).to_face().extrude(thick + 2.0).translate([0, 0, -1]);
for i in 0..teeth { cog -= gap.rotate("Z", i.to_float() * 360.0 / n); }
for i in 0..9 {
    let w = if i == 0 { 4.6 } else { 3.2 };
    cog -= box_centered(2.0, w, thick + 2.0).translate([17.6, 0, thick / 2.0]).rotate("Z", i.to_float() * 40.0);
}
cog
