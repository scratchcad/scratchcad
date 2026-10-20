// Six-point toy jack: three 3 mm rods 26 mm long on the axes, ball ends 5 mm, one pair with a flattened knob
let span = 26.0; // [18.0, 40.0] Tip to tip (mm)
let h = span / 2.0;
let parts = [cylinder([-h, 0, 0], "X", 1.5, span), cylinder([0, -h, 0], "Y", 1.5, span), cylinder([0, 0, -h], "Z", 1.5, span), sphere(3.0)];
for p in [[h, 0, 0], [-h, 0, 0], [0, h, 0], [0, -h, 0], [0, 0, -h]] { parts.push(sphere(p, 2.5)); }
parts.push(cylinder([0, 0, h - 1.5], "Z", 2.5, 3.0));
fuse_all(parts)
