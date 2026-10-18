// A lofted vase: circles of varying radius stacked along Z, hollowed from the top.
let radii = [20, 28, 18, 14, 22];
let sections = [];
for i in 0..radii.len() {
    sections.push(circle([0, 0, i * 25], "Z", radii[i]));
}
let vase = loft(sections);
vase.shell(-2, ">Z")
