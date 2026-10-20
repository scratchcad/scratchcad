// DIN-rail screw terminal block like Phoenix UT 2.5: 5.2 mm wide, 47.5 mm long, 42 mm tall, two M2.5 screw wells and 3.5 mm wire entries, TS35 snap foot
let width = 5.2; // [4.0, 10.2] Block width (mm)
let length = 47.5; // [40.0, 60.0] Length across the rail (mm)
let height = 42.0; // [35.0, 50.0] Height above the rail (mm)
let wire_hole = 3.5; // [2.0, 6.0] Wire entry size (mm)
let hl = length / 2.0;
let h1 = height * 0.55;
let prof = polygon("YZ", [[-hl, 0], [hl, 0], [hl, h1], [hl - 8.0, h1 + 4.0], [7.0, height - 6.0], [4.0, height], [-4.0, height], [-7.0, height - 6.0], [-hl + 8.0, h1 + 4.0], [-hl, h1]]);
let b = prof.to_face().extrude([width, 0, 0]);
let cuts = [];
for s in [-1.0, 1.0] {
    let ys = s * (hl - 9.5);
    cuts.push(cylinder([width / 2.0, ys, 10.0], "Z", 1.75, height));
    cuts.push(box_centered(width - 1.4, wire_hole, wire_hole).translate([width / 2.0, s * (hl - 2.0), h1 - 7.0]).translate([0, -s * 5.0, 0]));
    cuts.push(box_centered(width - 1.4, 12.0, wire_hole).translate([width / 2.0, s * (hl - 5.0), h1 - 7.0]));
}
b -= fuse_all(cuts);
let foot = box_from_corners([-1, -17.7, -1], [width + 1.0, 17.7, 1.2]) + box_from_corners([-1, -12.0, -1], [width + 1.0, 12.0, 6.0]);
b -= foot;
let hooks = box_from_corners([0, -19.5, -2.3], [width, -16.2, -1.2]) + box_from_corners([0, -19.5, -2.3], [width, -17.7, 0.1])
    + box_from_corners([0, 16.2, -2.3], [width, 19.5, -1.2]) + box_from_corners([0, 17.7, -2.3], [width, 19.5, 0.1]);
b + hooks
