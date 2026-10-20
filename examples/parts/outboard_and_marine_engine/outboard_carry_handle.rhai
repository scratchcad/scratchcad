// Outboard motor carry handle: 120 mm wide D handle 45 mm tall in a 16 x 20 mm section, 88 x 29 mm hand opening with 4 mm inner and 8 mm outer rounded corners, each leg with an M6 tapped hole (5 mm core) 12 mm deep in its foot
let width = 120.0; // [90.0, 160.0] Handle width (mm)
let height = 45.0; // [35.0, 70.0] Handle height (mm)
let depth = 20.0; // [14.0, 30.0] Handle depth (mm)
const bar = 16.0;
let outer = box_from_corners([-width / 2.0, -depth / 2.0, 0], [width / 2.0, depth / 2.0, height]);
let outer = outer.fillet(8.0, outer.edges("|Y and >Z"));
let inner = box_from_corners([-width / 2.0 + bar, -depth / 2.0 - 1.0, -1.0], [width / 2.0 - bar, depth / 2.0 + 1.0, height - bar]);
let inner = inner.fillet(4.0, inner.edges("|Y and >Z"));
let handle = outer - inner;
let taps = [];
for s in [-1.0, 1.0] {
    taps.push(cylinder([s * (width / 2.0 - bar / 2.0), 0, -1.0], "Z", 2.5, 13.0));
}
handle - fuse_all(taps)
