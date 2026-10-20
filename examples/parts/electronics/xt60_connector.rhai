// XT60 male connector: 15.5 x 8 x 16 mm shell with the chamfered polarity corners, two 4.5 mm gold contacts 5 mm apart
let width = 15.5; // [14.0, 18.0] Width (mm)
let depth = 8.0; // [7.0, 10.0] Depth (mm)
let height = 16.0; // [12.0, 20.0] Height (mm)
let outline = polygon([[-width / 2.0, -depth / 2.0], [width / 2.0, -depth / 2.0], [width / 2.0, depth / 2.0 - 2.0], [width / 2.0 - 2.0, depth / 2.0], [-width / 2.0 + 2.0, depth / 2.0], [-width / 2.0, depth / 2.0 - 2.0]]);
let shell = outline.to_face().extrude(height) - outline.offset(-1.0).to_face().extrude(height).translate([0, 0, 6.0]);
let contacts = [];
for s in [-1, 1] { contacts.push(cylinder([s * 3.6, 0, 1.0], "Z", 2.25, height - 2.0) - cylinder([s * 3.6, 0, 6.0], "Z", 1.75, height)); }
fuse_all([shell] + contacts)
