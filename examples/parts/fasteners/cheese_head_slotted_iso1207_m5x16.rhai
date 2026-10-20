// Slotted cheese head screw ISO 1207 M5 x 16: 8.5 mm head 3.3 mm tall, 1.2 mm slot 1.5 mm deep, 0.3 mm head chamfer, thread shown as 0.8 mm pitch rings
let diameter = 5.0; // [2.0, 10.0] Nominal diameter (mm)
let length = 16.0; // [3.0, 80.0] Length under head (mm)
let head_diameter = 8.5; // [3.8, 16.0] Head diameter (mm)
let head_height = 3.3; // [1.3, 6.0] Head height (mm)
let slot_width = 1.2; // [0.5, 2.5] Slot width (mm)
let slot_depth = 1.5; // [0.6, 3.0] Slot depth (mm)
const pitch = 0.8;
let r = diameter / 2.0;
let rm = r - 0.6134 * pitch;
let rk = max(head_diameter / 2.0, r + 1.0);
let p = [[0.0, 0.0, 0.0], [rm, 0.0, 0.0]];
let z = 0.0;
while z + pitch < length - 1.0 {
    p.push([r, 0.0, z + pitch * 0.4]);
    p.push([r, 0.0, z + pitch * 0.6]);
    p.push([rm, 0.0, z + pitch]);
    z += pitch;
}
p.push([r, 0.0, z + (r - rm)]);
p.push([r, 0.0, length + 0.01]);
p.push([0.0, 0.0, length + 0.01]);
let shank = polygon(p).to_face().revolve("Z", 360);
let head = cylinder([0, 0, length], "Z", rk, head_height).chamfer(min(0.3, head_height * 0.1), ">Z");
let sd = min(slot_depth, head_height * 0.6);
(shank + head) - box_centered(2.0 * rk + 2.0, slot_width, 2.0 * sd).translate([0, 0, length + head_height])
