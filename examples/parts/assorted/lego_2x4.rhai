// LEGO 2x4 brick
let studs_x = 4; // [1, 8] Studs along the length
let studs_y = 2; // [1, 4] Studs across
let pitch = 8.0; // [7.9, 8.1] Stud pitch (mm)
let height = 9.6; // [3.2, 9.6] Brick height (mm)
let stud_d = 4.8; // [4.6, 5.0] Stud diameter (mm)
let stud_h = 1.7; // [1.5, 1.9] Stud height (mm)
let wall = 1.2; // [1.0, 1.6] Wall thickness (mm)
let top = 1.0; // [0.8, 1.6] Top thickness (mm)
let lx = studs_x * pitch - 0.2;
let ly = studs_y * pitch - 0.2;
let body = box(lx, ly, height) - box_from_corners([wall, wall, -1.0], [lx - wall, ly - wall, height - top]);
let parts = [body];
for i in 0..studs_x {
    for j in 0..studs_y {
        parts.push(cylinder([pitch / 2.0 - 0.1 + i * pitch, pitch / 2.0 - 0.1 + j * pitch, height - 0.1], "Z", stud_d / 2.0, stud_h + 0.1));
    }
}
// underside tubes between studs
if studs_y >= 2 {
    for i in 1..studs_x {
        for j in 1..studs_y {
            let c = [i * pitch - 0.1, j * pitch - 0.1, 0.0];
            parts.push(cylinder(c, "Z", 6.31 / 2.0, height - top + 0.1) - cylinder([c[0], c[1], -1.0], "Z", 4.8 / 2.0, height));
        }
    }
}
fuse_all(parts).clean()
