// Kart axle locking collar for a 30 mm axle: 50 mm OD 15 mm wide, split with a 2 mm slot, 16 mm wide clamp lug standing 10 mm proud with an M6 pinch screw (6.4 mm clearance, 5 mm tapped side) and 0.8 mm chamfers round both faces of the ring
let axle_d = 30.0; // [20.0, 50.0] Axle diameter (mm)
let width = 15.0; // [10.0, 25.0] Collar width (mm)
let wall = 10.0; // [7.0, 15.0] Collar wall (mm)
let ri = axle_d / 2.0 + 0.05;
let ro = ri + wall;
let ring = cylinder([0, 0, 0], "Z", ro, width);
let ring = ring.chamfer(0.8, ring.edges("%CIRCLE"));
let lug = box_from_corners([-8.0, 0, 0], [8.0, ro + 10.0, width]);
let body = ring + lug;
let cuts = [
    cylinder([0, 0, -1.0], "Z", ri, width + 2.0),
    box_from_corners([-1.0, 0, -1.0], [1.0, ro + 11.0, width + 1.0]),
    cylinder([-9.0, ro + 4.5, width / 2.0], "X", 3.2, 10.0),
    cylinder([0.0, ro + 4.5, width / 2.0], "X", 2.5, 9.0)
];
body - fuse_all(cuts)
