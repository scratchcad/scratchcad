// Chess knight, flat-profile style: 60 mm tall on a 32 mm revolved base, horse head profile 12 mm thick extruded and centred, with an eye hole and mane notches
let height = 60.0; // [45.0, 80.0] Knight height (mm)
let base = 32.0; // [25.0, 40.0] Base diameter (mm)
let s = height / 60.0;
let b = base / 2.0;
let prof = polygon([[0, 0, 0], [b, 0, 0], [b, 0, 4.0 * s], [b - 2.0, 0, 7.0 * s], [b - 4.0, 0, 10.0 * s], [0, 0, 10.0 * s]]);
let pedestal = face(prof).revolve([0, 0, 0], [0, 0, 1], 360.0);
let head = face(polygon([[-9.0 * s, 0, 9.0 * s], [10.0 * s, 0, 9.0 * s], [8.0 * s, 0, 22.0 * s], [12.0 * s, 0, 34.0 * s], [16.0 * s, 0, 40.0 * s], [15.0 * s, 0, 46.0 * s], [6.0 * s, 0, 52.0 * s], [2.0 * s, 0, 60.0 * s], [-2.0 * s, 0, 54.0 * s], [-8.0 * s, 0, 48.0 * s], [-12.0 * s, 0, 34.0 * s], [-11.0 * s, 0, 20.0 * s]])).extrude([0, 12.0 * s, 0]).translate([0, -6.0 * s, 0]);
let eye = cylinder([5.0 * s, -10.0 * s, 46.0 * s], "Y", 1.5 * s, 20.0 * s);
let mane = [];
for i in 0..4 { mane.push(box_centered(4.0 * s, 20.0 * s, 1.5 * s).rotate_y(-35.0).translate([-9.5 * s + i.to_float() * 1.0 * s, 0, 30.0 * s + i.to_float() * 5.0 * s])); }
pedestal + head - eye - fuse_all(mane) - cylinder([0, 0, -1.0], "Z", b - 4.5, 2.0)
