// Vacuum precision planter seed disc for maize: 220 mm disc 2.5 mm thick with 30 seed cells of 4.5 mm on a 200 mm circle, each with a conical entry about 7 mm across and 0.8 mm deep on the seed side, a 30 mm hub bore with two 6.5 mm drive pin holes on a 50 mm circle, and 30 agitator bumps 1.5 mm high between the cells
let disc_d = 220.0; // [160.0, 260.0] Disc diameter (mm)
let cells = 30; // [16, 40] Number of seed cells
let cell_d = 4.5; // [2.5, 6.0] Cell hole diameter (mm)
let cell_circle = 200.0; // [150.0, 240.0] Cell circle diameter (mm)
let thickness = 2.5; // [2.0, 4.0] Disc thickness (mm)
const hub = 30.0;
const pin_d = 6.5;
const pin_circle = 50.0;
let rd = disc_d / 2.0;
let rc = min(cell_circle / 2.0, rd - 6.0);
let disc = cylinder(rd, thickness);
let parts = [disc];
for i in 0..cells {
    let a = (i + 0.5) * 360.0 / cells;
    parts.push(box_from_corners([rc - 2.0, -0.75, thickness - 0.3], [rc + 2.0, 0.75, thickness + 1.5]).rotate_z(a));
}
let disc = fuse_all(parts);
let cutters = [cylinder([0, 0, -1.0], "Z", hub / 2.0, thickness + 2.0)];
for s in [-1.0, 1.0] {
    cutters.push(cylinder([s * pin_circle / 2.0, 0, -1.0], "Z", pin_d / 2.0, thickness + 2.0));
}
for i in 0..cells {
    let a = i * 360.0 / cells * PI() / 180.0;
    let x = rc * cos(a);
    let y = rc * sin(a);
    cutters.push(cylinder([x, y, -1.0], "Z", cell_d / 2.0, thickness + 2.0));
    cutters.push(cone(cell_d / 2.0, cell_d / 2.0 + 1.5, 1.0).translate([x, y, thickness - 0.8]));
}
disc - fuse_all(cutters)
