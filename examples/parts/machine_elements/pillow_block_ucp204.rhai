// Pillow block bearing UCP204 for a 20 mm shaft: 33.3 mm centre height, 127 mm long base 38 mm wide, 95 mm bolt centres with 13 x 19 mm slots, 65 mm tall, UC204 insert 31 mm wide with set screw
let shaft = 20.0; // [12.0, 40.0] Shaft diameter (mm)
let centre_height = 33.3; // [25.0, 60.0] Shaft centre height (mm)
let base_length = 127.0; // [90.0, 200.0] Base length (mm)
let base_width = 38.0; // [25.0, 60.0] Base width (mm)
let bolt_centres = 95.0; // [60.0, 160.0] Bolt centres (mm)
const base_thickness = 14.0;
const insert_od = 47.0;
const insert_width = 31.0;
const slot_w = 13.0;
const slot_len = 19.0;
let rh = centre_height - 1.5;
let bc = min(bolt_centres, base_length - slot_len - 6.0);
let base = box_from_corners([-base_length / 2.0, -base_width / 2.0, 0], [base_length / 2.0, base_width / 2.0, base_thickness]).fillet(4.0, "|Z");
let boss = cylinder([0, -base_width / 2.0, centre_height], "Y", rh, base_width);
let web = polygon([[-rh * 1.6, -base_width / 2.0, base_thickness - 0.01], [rh * 1.6, -base_width / 2.0, base_thickness - 0.01], [rh * 0.8, -base_width / 2.0, centre_height], [-rh * 0.8, -base_width / 2.0, centre_height]]).to_face().extrude([0, base_width, 0]);
let housing = fuse_all([base, boss, web]);
let slots = [];
for s in [-1.0, 1.0] {
    let sx = s * bc / 2.0;
    slots.push(box_centered(slot_len - slot_w, slot_w, base_thickness + 2.0).translate([sx, 0, base_thickness / 2.0]));
    slots.push(cylinder([sx - (slot_len - slot_w) / 2.0, 0, -1], "Z", slot_w / 2.0, base_thickness + 2.0));
    slots.push(cylinder([sx + (slot_len - slot_w) / 2.0, 0, -1], "Z", slot_w / 2.0, base_thickness + 2.0));
}
housing = housing - fuse_all(slots);
housing = housing - cylinder([0, -base_width, centre_height], "Y", insert_od / 2.0 + 0.05, 2.0 * base_width);
housing = housing - cylinder([0, 0, centre_height + insert_od / 2.0 - 1.0], "Z", 3.0, rh);
let insert = cylinder([0, -insert_width / 2.0, centre_height], "Y", insert_od / 2.0, insert_width) - cylinder([0, -insert_width, centre_height], "Y", shaft / 2.0, 2.0 * insert_width);
insert = insert - cylinder([0, insert_width * 0.3, centre_height + shaft / 2.0 - 1.0], "Z", 2.5, 15.0);
compound([housing, insert])
