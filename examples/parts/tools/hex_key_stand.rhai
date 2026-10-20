// Hex key stand: 110 x 22 x 25 mm block with nine graded holes for 1.5 to 10 mm keys, chamfered top edges
let keys = [1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 8.0, 10.0];
let len = 110.0; // [90.0, 160.0] Length (mm)
let block = box_from_corners([0, 0, 0], [len, 22.0, 25.0]).chamfer(1.5, ">Z");
let x = 6.0;
for k in keys {
    let rc = (k + 0.3) / sqrt(3.0);
    let hp = [];
    for i in 0..6 { let a = i.to_float() * PI() / 3.0; hp.push([x + k / 2.0 + rc * a.cos(), 11.0 + rc * a.sin()]); }
    block -= polygon(hp).to_face().extrude(22.0).translate([0, 0, 4.0]);
    x += k + 4.5;
}
block
