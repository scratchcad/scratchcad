// Loose wheel nut indicator for 19 mm hex nuts: push-on ring 12 mm tall with a 19.2 mm AF hex socket, 28 mm round body, 16 mm pointer arrow to line up with the next nut, 0.4 mm crush rib on each flat
let nut_af = 19.2; // [16.5, 22.5] Nut across flats (mm)
let height = 12.0; // [8.0, 16.0] Ring height (mm)
let wall = 2.5; // [1.8, 4.0] Wall at the corners (mm)
let pointer = 16.0; // [8.0, 25.0] Pointer length (mm)

let rc = nut_af / sqrt(3.0);
let ro = rc + wall;
let body = cylinder(ro, height);
let arrow = polygon([[ro - 3.0, -5.0, 0], [ro + pointer, 0, 0], [ro - 3.0, 5.0, 0]]).to_face().extrude([0, 0, height * 0.6]);
let ring = body + arrow;
ring = ring.chamfer(0.8, ring.edges(">Z and %CIRCLE"));
let pts = [];
for i in 0..6 {
    let a = (i * 60.0 + 30.0) * PI() / 180.0;
    pts.push([rc * cos(a), rc * sin(a), 0]);
}
let socket = polygon(pts).to_face().extrude([0, 0, height + 2.0]).translate([0, 0, -1.0]);
ring = ring - socket;
let ribs = [];
for i in 0..6 {
    let a = i * 60.0;
    ribs.push(box_centered(1.6, 4.0, height - 2.0).translate([nut_af / 2.0 + 0.4, 0, height / 2.0 + 1.0]).rotate_z(a));
}
ring + fuse_all(ribs)
