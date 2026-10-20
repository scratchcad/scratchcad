// Wall-mounted whiteboard marker holder for 4 chisel markers (19 mm caps): 4 cups 20 mm bore 35 mm tall, 2 mm wall, 8 mm front sight slot, 3 mm floor with drain hole, 4 mm back plate 30 mm tall, 2 countersunk 4 mm screws
let markers = 4; // [2, 8] Number of markers
let bore = 20.0; // [14.0, 26.0] Cup bore (mm)
let cup_h = 35.0; // [20.0, 60.0] Cup height (mm)
let wall = 2.0; // [1.6, 3.0] Cup wall (mm)
let slot = 8.0; // [0.0, 12.0] Front slot width (mm)

const plate_t = 4.0;
const floor_t = 3.0;
let ro = bore / 2.0 + wall;
let pitch = 2.0 * ro + 3.0;
let len = markers * pitch + 20.0;
let ph = max(30.0, cup_h);
let plate = box_from_corners([-len / 2.0, 0, 0], [len / 2.0, plate_t, ph]);
plate = plate.fillet(4.0, plate.edges("|Y"));
let cups = [];
let holes = [];
for i in 0..markers {
    let x = -len / 2.0 + 10.0 + pitch / 2.0 + i * pitch;
    let yc = plate_t + ro - wall * 0.5;
    cups.push(cylinder([x, yc, 0], "Z", ro, cup_h));
    holes.push(cylinder([x, yc, floor_t], "Z", bore / 2.0, cup_h));
    holes.push(cylinder([x, yc, -1.0], "Z", 2.5, floor_t + 2.0));
    if slot > 0.5 {
        holes.push(box_from_corners([x - slot / 2.0, yc, floor_t + 6.0], [x + slot / 2.0, yc + ro + 1.0, cup_h + 1.0]));
    }
}
let holder = plate + fuse_all(cups) - fuse_all(holes);
for s in [-1.0, 1.0] {
    let x = s * (len / 2.0 - 5.0);
    holder = holder - cylinder([x, -1.0, ph / 2.0], "Y", 2.1, plate_t + 2.0) - cone(2.1, 4.3, 2.3).rotate_x(-90.0).translate([x, plate_t - 2.1, ph / 2.0]);
}
holder
