// Selectors pick faces, edges and vertices declaratively.
let block = box(30, 20, 10);

// Round only the vertical edges on the +X side, then chamfer every top edge.
let block = block.fillet(3, "|Z and >X").chamfer(1, ">Z");

// Drill a hole into the center of the top face, using the face as a sketch plane.
let top = block.top_face();
let hole = circle(top.plane(), 4).extrude(-10);
let block = block - hole;

// Closures work too: keep only the circular edges and print how many there are.
let circles = block.edges().filter(|e| e.geom_type() == "circle");
print(`circular edges: ${circles.len()}`);

block
