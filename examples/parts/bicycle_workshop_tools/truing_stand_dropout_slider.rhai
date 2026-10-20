// Truing stand dropout slider: 80 x 30 x 6 mm plate, 10.2 mm axle slot 18 mm deep with a 90 degree lead-in at the top, two 6.5 x 20 mm adjustment slots below, 1 mm chamfered top edge
let height = 80.0; // [60.0, 110.0] Slider height (mm)
let width = 30.0; // [24.0, 40.0] Slider width (mm)
let thickness = 6.0; // [4.0, 10.0] Thickness (mm)
let axle_slot = 10.2; // [9.2, 15.2] Axle slot width (mm)
const slot_depth = 18.0;
const lead = 4.0;
let plate = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, thickness, height]);
let plate = plate.chamfer(1.0, plate.edges(">Z and |Y"));
let a = axle_slot / 2.0;
let v = polygon([[-a, -1.0, height - slot_depth], [a, -1.0, height - slot_depth], [a, -1.0, height - lead], [a + lead + 1.0, -1.0, height + 1.0], [-a - lead - 1.0, -1.0, height + 1.0], [-a, -1.0, height - lead]]).to_face().extrude([0, thickness + 2.0, 0]);
let cuts = [v, cylinder([0, -1.0, height - slot_depth], "Y", a, thickness + 2.0)];
let span = height - slot_depth - 18.0;
for z in [8.0, 8.0 + span / 2.0] {
    let l = min(20.0, span / 2.0 - 4.0);
    cuts.push(box_from_corners([-3.25, -1.0, z + 3.25], [3.25, thickness + 1.0, z + l - 3.25]));
    cuts.push(cylinder([0, -1.0, z + 3.25], "Y", 3.25, thickness + 2.0));
    cuts.push(cylinder([0, -1.0, z + l - 3.25], "Y", 3.25, thickness + 2.0));
}
plate - fuse_all(cuts)
