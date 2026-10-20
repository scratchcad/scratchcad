// Four-prong solitaire head for a 6.5 mm round brilliant (about 1 ct): 0.9 mm prongs splaying from a 3.8 mm base, two gallery rings, girdle seat at 3.8 mm with 2.8 mm pavilion depth
let stone_diameter = 6.5; // [3.0, 10.0] Stone diameter (mm)
let prong_diameter = 0.9; // [0.6, 1.4] Prong diameter (mm)
let head_height = 5.0; // [3.5, 8.0] Head height (mm)
let prongs = 4; // [3, 6] Number of prongs
let rs = stone_diameter / 2.0;
let z_girdle = head_height - 1.2;
let pavilion = stone_diameter * 0.43;
// prong centres run from radius rb at z = 0 to put the prong centre on the girdle at z_girdle
let rb = rs * 0.58;
let rg = rs + prong_diameter * 0.15;
let slope = (rg - rb) / z_girdle;
let rt = rb + slope * head_height;
let parts = [];
for i in 0..prongs {
    let a = i.to_float() * 360.0 / prongs.to_float() + 45.0;
    let axis = [rt - rb, 0, head_height];
    let len = ((rt - rb) * (rt - rb) + head_height * head_height).sqrt();
    let p = cylinder([rb, 0, 0], axis, prong_diameter / 2.0, len) + sphere([rt, 0, head_height], prong_diameter / 2.0);
    parts.push(p.rotate_z(a));
}
// gallery rings where the prongs pass
for z in [0.6, z_girdle - pavilion * 0.55] {
    let rc = rb + slope * (z + 0.3);
    parts.push(cylinder([0, 0, z], "Z", rc + 0.35, 0.6) - cylinder([0, 0, z - 1.0], "Z", rc - 0.35, 2.6));
}
let head = fuse_all(parts);
// seat for the stone: pavilion cone plus a short girdle cylinder
let seat = cone(0.01, rs + 0.02, pavilion).translate([0, 0, z_girdle - pavilion]) + cylinder([0, 0, z_girdle - 0.01], "Z", rs + 0.02, 0.18) + cone(rs + 0.02, rs * 0.55, 1.0).translate([0, 0, z_girdle + 0.17]);
head - seat
