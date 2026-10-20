// ECG lead wire organiser comb: 70 x 14 x 10 mm bar with five 4.2 mm keyhole slots (3.2 mm entries) at 12 mm pitch for monitor lead wires, chamfered top edges and a 50 x 10 mm adhesive pad recess 0.8 mm deep underneath
let leads = 5; // [3, 10] Number of leads
let lead_d = 4.2; // [3.0, 6.0] Lead wire diameter (mm)
let pitch = 12.0; // [9.0, 16.0] Lead pitch (mm)
const depth = 14.0;
const h = 10.0;
let len = leads.to_float() * pitch + 10.0;
let bar = box_from_corners([0, 0, 0], [len, depth, h]);
bar = bar.chamfer(1.0, bar.edges("|X and >Z"));
let cuts = [];
for i in 0..leads {
    let x = 5.0 + pitch * (i.to_float() + 0.5);
    cuts.push(cylinder([x, -1.0, h / 2.0], "Y", lead_d / 2.0, depth + 2.0));
    cuts.push(box_from_corners([x - lead_d * 0.38, -1.0, h / 2.0], [x + lead_d * 0.38, depth + 1.0, h + 1.0]));
}
bar - fuse_all(cuts) - box_from_corners([5.0, 2.0, -1.0], [len - 5.0, depth - 2.0, 0.8])
