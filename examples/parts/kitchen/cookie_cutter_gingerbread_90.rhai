// Gingerbread man cookie cutter: 90 mm tall, 76 mm across the arms, 0.8 mm wall 16 mm tall, 3 mm pressing rim on top
let size = 1.0; // [0.5, 2.0] Size relative to 90 mm tall
let height = 16.0; // [10.0, 30.0] Cutter height (mm)
let wall = 0.8; // [0.5, 1.5] Wall thickness (mm)
let rim_width = 3.0; // [1.5, 6.0] Rim width (mm)
// a rounded bar from its length, width and angle, placed at a point
fn limb(length, width, deg, at) {
    face(rect(length - width, 1.0).offset((width - 1.0) / 2.0)).rotate_z(deg).translate(at)
}
// outline from overlapping 2D shapes: head, body, arms and legs, merged into one face
let pieces = [circle([0, 31, 0], "Z", 13.0).to_face(),
              limb(40.0, 30.0, 90.0, [0, 2, 0]),
              limb(36.0, 13.0, -20.0, [-20, 10, 0]), limb(36.0, 13.0, 20.0, [20, 10, 0]),
              limb(38.0, 14.0, 70.0, [-10, -24, 0]), limb(38.0, 14.0, -70.0, [10, -24, 0])];
let outline = pieces[0];
for p in pieces { outline = outline.fuse(p); }
let edge = outline.clean().faces()[0].outer_wire().scale(size);
let cutter = face(edge.offset(wall), [edge]).extrude([0, 0, height]);
let rim = face(edge.offset(wall + rim_width), [edge]).extrude([0, 0, 1.5]).translate([0, 0, height - 1.5]);
cutter + rim
