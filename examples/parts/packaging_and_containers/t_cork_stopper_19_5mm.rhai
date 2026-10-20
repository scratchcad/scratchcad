// Bar-top (T-cork) spirits stopper: 30 mm head 10 mm tall, 19.5 mm shank 20 mm long with three 0.5 mm sealing ribs and a chamfered tip, for a 18.5 mm bottle bore
let head_diameter = 30.0; // [20.0, 40.0] Head diameter (mm)
let head_height = 10.0; // [6.0, 16.0] Head height (mm)
let shank_diameter = 19.5; // [14.0, 24.0] Shank diameter (mm)
let shank_length = 20.0; // [12.0, 30.0] Shank length (mm)
let ribs = 3; // [0, 5] Number of sealing ribs
let rh = head_diameter / 2.0;
let rs = min(shank_diameter / 2.0, rh - 2.0);
let head = cylinder(rh, head_height).fillet(3.0, ">Z").fillet(1.0, "<Z");
let shank = cylinder([0, 0, -shank_length], "Z", rs, shank_length + 0.5).chamfer(1.5, "<Z");
let parts = [head, shank];
for i in 0..ribs {
    let z = -3.0 - i.to_float() * (shank_length - 6.0) / max(ribs - 1, 1).to_float();
    parts.push(torus(rs, 0.5).translate([0, 0, z]));
}
fuse_all(parts)
