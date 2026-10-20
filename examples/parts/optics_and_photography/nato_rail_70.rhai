// NATO rail (STANAG 4694 profile) for camera cages: 70 mm long, 21.2 mm over the 45 deg dovetail flats, 9 mm tall, 5.3 mm cross slots on a 10 mm pitch, two countersunk 1/4-20 screw holes 30 mm apart
let length = 70.0; // [30.0, 200.0] Rail length (mm)
let rail_width = 21.2; // [20.0, 22.5] Width over the dovetail flats (mm)
let height = 9.0; // [7.0, 12.0] Rail height (mm)
let slot_pitch = 10.0; // [10.0, 10.1] Cross slot pitch (mm)
let hole_spacing = 30.0; // [10.0, 60.0] Screw hole spacing (mm)
let w = rail_width / 2.0;
const b = 7.8;
let profile = polygon("YZ", [[-b, 0], [b, 0], [b, 1.5], [w, 1.5 + w - b], [w, 2.0 + w - b], [b - 0.2, height - 0.2], [b - 0.4, height], [-b + 0.4, height],
                             [-b + 0.2, height - 0.2], [-w, 2.0 + w - b], [-w, 1.5 + w - b], [-b, 1.5]]);
let rail = profile.to_face().extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
let n = ((length - 6.0) / slot_pitch).floor().to_int();
let cuts = [];
for i in 0..n {
    let x = (i.to_float() - (n - 1).to_float() / 2.0) * slot_pitch;
    cuts.push(box_centered(5.3, rail_width + 2.0, 6.0).translate([x, 0, height + 0.01]));
}
rail = rail - compound(cuts);
let holes = [];
for s in [-1.0, 1.0] {
    let x = s * min(hole_spacing, length - 12.0) / 2.0;
    // align the screws with the slots so the countersinks clear the slot floors
    holes.push(cylinder([x, 0, -1.0], "Z", 3.3, height + 2.0) + cone(3.3, 6.5, 3.2).translate([x, 0, height - 3.0 - 3.2]));
}
rail - compound(holes)
