// Square washroom bin liner retainer ring: 280 x 280 mm outside, 15 mm wide band 4 mm thick with 25 mm outside corner radii, a 12 mm downturned skirt 2 mm thick around the outer edge that clips over the bin rim, and four 20 mm finger notches on the inner edge
let size = 280.0; // [180.0, 400.0] Ring size (mm)
let band = 15.0; // [10.0, 30.0] Band width (mm)
let skirt = 12.0; // [6.0, 25.0] Skirt depth (mm)
const t = 4.0;
const sk_t = 2.0;
const corner = 25.0;
let outer = box_centered(size, size, t + skirt).translate([0, 0, (t + skirt) / 2.0 - skirt]);
let outer = outer.fillet(corner, outer.edges("|Z"));
let in_sk = box_centered(size - 2.0 * sk_t, size - 2.0 * sk_t, skirt + 1.0).translate([0, 0, -(skirt + 1.0) / 2.0]);
let in_sk = in_sk.fillet(corner - sk_t, in_sk.edges("|Z"));
let hole = box_centered(size - 2.0 * band, size - 2.0 * band, t + skirt + 4.0).translate([0, 0, t / 2.0]);
let hole = hole.fillet(max(corner - band, 2.0), hole.edges("|Z"));
let ring = outer - in_sk - hole;
let nr = min(10.0, band - 5.0);
let cuts = [];
for i in 0..4 {
    cuts.push(cylinder([size / 2.0 - band, 0, -skirt - 1.0], "Z", nr, t + skirt + 2.0).rotate_z(i.to_float() * 90.0));
}
ring - fuse_all(cuts)
