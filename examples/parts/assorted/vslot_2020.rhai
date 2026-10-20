// 2020 V-slot extrusion
let length = 100.0; // [10, 500] Length (mm)
let slot_width = 6.2; // [5.0, 7.0] Slot opening (mm)
let bore = 4.2; // [3.0, 5.0] Center bore (mm)
const h = 10.0;
let body = box_centered(20, 20, length).translate([0, 0, length / 2.0]);
// a V-slot cutter on the +X face: 1.8 mm lip, V out to 9.2 mm, cavity tapering back to the core
let s = slot_width / 2.0;
let cutter = polygon([
    [h + 1.0, -s], [h - 1.8, -s], [h - 3.3, -4.6], [h - 4.0, -4.6], [h - 6.1, -2.8],
    [h - 6.1, 2.8], [h - 4.0, 4.6], [h - 3.3, 4.6], [h - 1.8, s], [h + 1.0, s]
]).to_face().extrude([0, 0, length + 2.0]).translate([0, 0, -1]);
let cutters = [];
for i in 0..4 { cutters.push(cutter.rotate_z(i * 90)); }
(body - fuse_all(cutters)) - cylinder([0, 0, -1], "Z", bore / 2.0, length + 2.0)
