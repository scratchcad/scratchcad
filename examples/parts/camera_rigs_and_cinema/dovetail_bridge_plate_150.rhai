// Dovetail bridge plate bar for a cinema camera, 150 mm long: 60 mm wide at the top with 45 degree undercut sides down to 50 mm at the base, 12 mm tall, 1 mm top chamfers, a row of 3/8-16 clearance holes (9.8 mm) counterbored 16 mm every 25 mm, and 1/4-20 clearance holes (6.5 mm) between them
let length = 150.0; // [80.0, 300.0] Plate length (mm)
let top_w = 60.0; // [50.0, 75.0] Top width (mm)
let height = 12.0; // [10.0, 18.0] Plate height (mm)
const undercut = 5.0;
let a = top_w / 2.0;
let profile = polygon([[0, -a + undercut, 0], [0, a - undercut, 0], [0, a, undercut], [0, a, height], [0, -a, height], [0, -a, undercut]]);
let bar = face(profile).extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
let bar = bar.chamfer(1.0, bar.edges("|X and >Z"));
let n = ((length - 20.0) / 25.0).to_int() + 1;
let cuts = [];
for i in 0..n {
    let x = (i.to_float() - (n.to_float() - 1.0) / 2.0) * 25.0;
    cuts.push(cylinder([x, 0, -1.0], "Z", 4.9, height + 2.0));
    cuts.push(cylinder([x, 0, height - 6.0], "Z", 8.0, 7.0));
}
for i in 0..(n - 1) {
    let x = (i.to_float() - (n.to_float() - 2.0) / 2.0) * 25.0;
    cuts.push(cylinder([x, 0, -1.0], "Z", 3.25, height + 2.0));
}
bar - fuse_all(cuts)
