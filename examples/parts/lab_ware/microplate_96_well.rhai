// SBS 96-well microplate: 127.76 x 85.48 x 14.4 mm, 6.86 mm wells 10.7 mm deep on a 9 mm grid from A1 at 14.38, 11.24 mm, chamfered H1 corner, hollow skirt
let depth = 10.7; // [3.0, 12.0] Well depth (mm)
let plate = box_from_corners([0, 0, 0], [127.76, 85.48, 14.4]);
plate -= polygon([[123.76, -1], [128.76, -1], [128.76, 4]]).to_face().extrude(16.0).translate([0, 0, -1]);
plate -= box_from_corners([1.5, 1.5, -1], [126.26, 83.98, 14.4 - depth - 0.7]);
let wells = [];
for i in 0..12 { for j in 0..8 { wells.push(cylinder([14.38 + i.to_float() * 9.0, 11.24 + j.to_float() * 9.0, 14.4 - depth], "Z", 3.43, depth + 1.0)); } }
plate - fuse_all(wells)
