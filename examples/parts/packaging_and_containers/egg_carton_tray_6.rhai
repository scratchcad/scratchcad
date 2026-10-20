// Six-egg carton tray (2 x 3), moulded fibre style: 1.2 mm walls, conical cells 44 mm across the top, 30 mm deep on a 46 mm pitch, 3 mm flat rim flange
let pitch = 46.0; // [40.0, 60.0] Cell pitch (mm)
let cell_depth = 30.0; // [20.0, 40.0] Cell depth (mm)
let cell_top = 44.0; // [36.0, 58.0] Cell diameter at the top (mm)
let cell_bottom = 30.0; // [20.0, 40.0] Cell diameter at the bottom (mm)
let wall = 1.2; // [0.8, 2.5] Wall thickness (mm)
let rows = 2; // [1, 4] Number of rows
let cols = 3; // [1, 6] Number of columns
let rt = min(cell_top / 2.0, pitch / 2.0 - 0.2);
let rb = min(cell_bottom / 2.0, rt - 2.0);
let w = cols.to_float() * pitch + 6.0;
let d = rows.to_float() * pitch + 6.0;
let outers = [box_centered(w, d, wall).translate([0, 0, cell_depth - wall / 2.0])];
let inners = [];
for i in 0..cols {
    for j in 0..rows {
        let x = (i.to_float() - (cols.to_float() - 1.0) / 2.0) * pitch;
        let y = (j.to_float() - (rows.to_float() - 1.0) / 2.0) * pitch;
        outers.push(cone(rb, rt, cell_depth).translate([x, y, 0]));
        // the inner cone is the outer one shifted up by the wall, so the wall stays even
        inners.push(cone(rb - wall * 0.3, rt - wall, cell_depth + 0.01).translate([x, y, wall]));
    }
}
fuse_all(outers) - fuse_all(inners)
