// Double 15 mm pipe spacer clip (holds flow and return at fixed centres): two snap rings 15.2 mm bore with 12 mm mouths, 35 mm centres, 2.2 mm walls, 10 mm wide, central 4 mm web
let pipe = 15.0; // [10.0, 22.0] Pipe size (mm)
let centres = 35.0; // [22.0, 60.0] Pipe centres (mm)
let wall = 2.2; // [1.5, 3.5] Ring wall (mm)
let width = 10.0; // [6.0, 16.0] Clip width (mm)
let ri = pipe / 2.0 + 0.1;
let ro = ri + wall;
let c = max(centres, 2.0 * ro + 2.0);
let mouth = pipe * 0.8;
let shapes = [box_from_corners([-c / 2.0, 0, -2.0], [c / 2.0, width, 2.0])];
let cuts = [];
for s in [-1.0, 1.0] {
    let x = s * c / 2.0;
    shapes.push(cylinder([x, 0, 0], "Y", ro, width));
    cuts.push(cylinder([x, -1, 0], "Y", ri, width + 2.0));
    cuts.push(box_from_corners([x + s * ri * 0.4, -1, -mouth / 2.0], [x + s * (ro + 1.0), width + 1.0, mouth / 2.0]));
}
fuse_all(shapes) - fuse_all(cuts)
