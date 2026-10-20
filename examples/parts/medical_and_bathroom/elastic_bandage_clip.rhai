// Elastic bandage clip: 0.6 mm stamped steel, 30 x 12 mm body with an elastic strap slot, three hooked teeth bent down 60 degrees at each end
let length = 30.0; // [20.0, 45.0] Body length (mm)
let width = 12.0; // [8.0, 18.0] Body width (mm)
let thickness = 0.6; // [0.4, 1.2] Sheet thickness (mm)
let tooth_length = 5.0; // [3.0, 8.0] Tooth length (mm)
const teeth = 3;
let hl = length / 2.0;
let hw = width / 2.0;
let body = box_from_corners([-hl, -hw, 0], [hl, hw, thickness]).fillet(1.5, "|Z");
body -= box_from_corners([-hl * 0.5, -hw * 0.45, -1.0], [hl * 0.5, hw * 0.45, thickness + 1.0]).fillet(1.0, "|Z");
let parts = [body];
let tw = width / (2.0 * teeth.to_float());
for s in [-1.0, 1.0] {
    for i in 0..teeth {
        let y = -hw + tw * (2.0 * i.to_float() + 1.0);
        let tooth = polygon([[0, -tw * 0.4], [tooth_length, -tw * 0.15], [tooth_length + 0.6, 0], [tooth_length, tw * 0.15], [0, tw * 0.4]]).to_face().extrude(thickness);
        let bent = tooth.translate([-0.4, y, 0]).rotate([0, 0, 0], "Y", 60.0);
        parts.push(if s > 0.0 { bent.translate([hl - 0.5, 0, 0]) } else { bent.mirror("YZ").translate([-hl + 0.5, 0, 0]) });
    }
}
fuse_all(parts)
