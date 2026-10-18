// A mounting plate with rounded corners, four bolt holes and a chamfered top edge.
let width = 80;
let depth = 50;
let thickness = 6;
let hole_radius = 2.5;
let inset = 8;

let plate = box_centered(width, depth, thickness).fillet(5, "|Z");

for x in [-1, 1] {
    for y in [-1, 1] {
        let position = [x * (width / 2 - inset), y * (depth / 2 - inset), -thickness];
        plate -= cylinder(position, "Z", hole_radius, thickness * 2);
    }
}

plate.chamfer(0.8, ">Z")
