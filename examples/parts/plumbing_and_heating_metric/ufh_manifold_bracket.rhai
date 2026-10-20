// Underfloor heating manifold wall bracket for 1 in bars: 50 mm wide 2.5 mm steel, 260 mm backplate, two 70 mm arms 200 mm apart with 34 mm saddle notches and U-bolt slots, 4 keyhole fixings
let width = 50.0; // [35.0, 70.0] Bracket width (mm)
let thick = 2.5; // [1.5, 4.0] Plate thickness (mm)
let spacing = 200.0; // [150.0, 230.0] Bar spacing (mm)
let arm = 70.0; // [50.0, 100.0] Arm length (mm)
let saddle = 34.0; // [28.0, 42.0] Bar saddle diameter (mm)
let height = spacing + 60.0;
let back = box_from_corners([-width / 2.0, 0, 0], [width / 2.0, thick, height]);
let arms = [];
let cuts = [];
for z in [30.0, 30.0 + spacing] {
    arms.push(box_from_corners([-width / 2.0, 0, z - thick / 2.0], [width / 2.0, arm, z + thick / 2.0]));
    arms.push(polygon([[-thick / 2.0, thick, z - 20.0], [-thick / 2.0, thick, z], [-thick / 2.0, arm * 0.6, z]]).to_face().extrude([thick, 0, 0]));
    cuts.push(cylinder([0, arm - saddle * 0.15, z - 5.0], "Z", saddle / 2.0, 10.0));
    for x in [-1.0, 1.0] {
        let slot = box_centered(4.0, 10.0, 10.0).translate([x * (saddle / 2.0 + 3.5), arm - saddle * 0.15, z]);
        cuts.push(slot);
    }
}
for zk in [height * 0.25, height * 0.75] {
    for x in [-1.0, 1.0] {
        cuts.push(cylinder([x * width * 0.25, -1, zk], "Y", 4.0, thick + 2.0));
        cuts.push(box_centered(4.4, thick + 2.0, 8.0).translate([x * width * 0.25, thick / 2.0, zk + 4.0]));
    }
}
fuse_all([back] + arms) - fuse_all(cuts)
