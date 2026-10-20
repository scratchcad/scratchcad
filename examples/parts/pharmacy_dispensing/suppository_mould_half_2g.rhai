// Suppository mould half for 2 g suppositories: 12 mm thick block holding 6 torpedo half-cavities 11 mm in diameter and 33 mm long (16 mm cylinder, 12 mm cone to a 2 mm nose, 5 mm taper to an 8 mm pour end) at 18 mm pitch, the pour ends open at one edge, with two 4 mm dowel holes for the matching half
let count = 6; // [2, 12] Number of cavities
let cavity_d = 11.0; // [8.0, 14.0] Cavity diameter (mm)
let cavity_len = 33.0; // [25.0, 40.0] Cavity length (mm)
let pitch = 18.0; // [16.0, 24.0] Cavity spacing (mm)
const block_t = 12.0;
const margin = 10.0;
const dowel_r = 2.0;
let r = cavity_d / 2.0;
let lx = (count - 1) * pitch + 2.0 * margin;
let ly = cavity_len + 12.0;
let block = box_from_corners([0, 0, 0], [lx, ly, block_t]);
let cone_len = cavity_len * 0.36;
let taper = cavity_len * 0.15;
let profile = polygon([
    [0, -1.0, 0], [r * 0.73, -1.0, 0], [r * 0.73, 0, 0], [r, taper, 0],
    [r, cavity_len - cone_len, 0], [1.0, cavity_len, 0], [0, cavity_len, 0],
]);
let cavity = profile.to_face().revolve("Y", 360.0);
let cutters = [];
for i in 0..count {
    cutters.push(cavity.translate([margin + i * pitch, 0, block_t]));
}
cutters.push(cylinder([margin / 2.0, ly - 5.0, -1.0], "Z", dowel_r, block_t + 2.0));
cutters.push(cylinder([lx - margin / 2.0, ly - 5.0, -1.0], "Z", dowel_r, block_t + 2.0));
block - fuse_all(cutters)
