// Jaw coupling hub, Lovejoy L-075 size: 44.5 mm OD, 20.6 mm hub length, three 45 deg jaws 12.7 mm tall, 16 mm bore with 5 mm keyway and M5 set screw
let outer_diameter = 44.5; // [25.0, 80.0] Outer diameter (mm)
let hub_length = 20.6; // [10.0, 40.0] Hub length (mm)
let jaw_height = 12.7; // [6.0, 25.0] Jaw height (mm)
let bore = 16.0; // [6.0, 22.0] Bore diameter (mm)
const jaws = 3;
const jaw_angle = 45.0;
let ro = outer_diameter / 2.0;
let rin = max(bore / 2.0 + 2.0, ro * 0.5);
let hub = cylinder(ro, hub_length);
let ring = cylinder([0, 0, hub_length - 0.01], "Z", ro, jaw_height + 0.01) - cylinder([0, 0, hub_length - 1.0], "Z", rin, jaw_height + 2.0);
let wedges = [];
for i in 0..jaws {
    let a0 = (i.to_float() * 360.0 / jaws.to_float() - jaw_angle / 2.0) * PI() / 180.0;
    let a1 = a0 + jaw_angle * PI() / 180.0;
    let am = (a0 + a1) / 2.0;
    let big = ro * 2.0;
    wedges.push(polygon([[0, 0], [big * a0.cos(), big * a0.sin()], [big * am.cos(), big * am.sin()], [big * a1.cos(), big * a1.sin()]]).to_face().extrude(jaw_height + 4.0).translate([0, 0, hub_length - 2.0]));
}
let jaw_set = ring & compound(wedges);
let part = (hub + jaw_set).chamfer(0.6, "%CIRCLE and <Z");
let b = min(bore, rin * 2.0 - 3.0);
let key = box_from_corners([-2.5, 0, -1], [2.5, b / 2.0 + 2.3, hub_length + jaw_height + 1.0]);
part = part - cylinder([0, 0, -1], "Z", b / 2.0, hub_length + jaw_height + 2.0) - key;
part - cylinder([0, 0, hub_length / 2.0], "Y", 2.1, ro + 1.0)
