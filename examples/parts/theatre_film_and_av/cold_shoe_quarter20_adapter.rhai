// Cold shoe to 1/4-20 adapter: ISO 518 cold shoe foot 18.6 x 18 mm, 2 mm plate on a 4 mm neck, 12 mm round body 10 mm tall with a 1/4-20 male stud 6.35 x 6 mm (ridged)
let foot_width = 18.6; // [18.0, 19.0] Shoe foot width (mm)
let foot_length = 18.0; // [15.0, 22.0] Shoe foot length (mm)
let foot_thickness = 2.0; // [1.5, 2.2] Foot plate thickness (mm)
let body_d = 12.0; // [10.0, 18.0] Body diameter (mm)
let stud_length = 6.0; // [4.0, 10.0] Stud length (mm)
let foot = box_centered(foot_width, foot_length, foot_thickness).translate([0, 0, foot_thickness / 2.0]);
let f = foot.fillet(1.5, foot.edges("|Z"));
let neck = box_centered(12.0, foot_length, 4.0 + 0.02).translate([0, 0, foot_thickness + 2.0]);
let body = cylinder([0, 0, foot_thickness + 4.0], "Z", body_d / 2.0, 10.0);
let top = foot_thickness + 14.0;
// stud: 1/4-20 approximated by ridges at 1.27 mm pitch
let pts = [[0.0, top - 0.01], [2.6, top - 0.01]];
let n = (stud_length / 1.27).floor().to_int();
for i in 0..n {
    let z = top + i.to_float() * 1.27;
    pts.push([3.175, z + 0.45]);
    pts.push([3.175, z + 0.65]);
    pts.push([2.6, z + 1.1]);
}
pts.push([2.6, top + stud_length]);
pts.push([0.0, top + stud_length]);
let stud = polygon("XZ", pts).to_face().revolve([0, 0, 0], "Z", 360);
f + neck + body + stud
