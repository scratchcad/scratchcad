// GU10 lamp holder: 35 mm body 20 mm tall, two 5.4 mm keyhole slots on 10 mm centres for the twist-lock pins, cable exit
let diameter = 35.0; // [28.0, 45.0] Body diameter (mm)
let height = 20.0; // [15.0, 30.0] Body height (mm)
const pitch = 10.0;
let body = cylinder(diameter / 2.0, height);
let slots = [];
for s in [-1.0, 1.0] {
    slots.push(cylinder([s * pitch / 2.0, 0, height - 8.0], "Z", 2.7, 9.0));
    slots.push((cylinder([0, 0, height - 8.0], "Z", pitch / 2.0 + 1.6, 9.0) - cylinder([0, 0, height - 9.0], "Z", pitch / 2.0 - 1.6, 11.0)) & box_from_corners([-diameter, s * 0.1, height - 8.0], [0, s * 5.0, height + 1.0]).rotate_z(if s > 0.0 { 0.0 } else { 180.0 }));
}
body - fuse_all(slots) - cylinder([0, 0, -1], "Z", 4.0, height - 7.0) - box_from_corners([-1.5, -diameter, 3.0], [1.5, 0, 8.0])
