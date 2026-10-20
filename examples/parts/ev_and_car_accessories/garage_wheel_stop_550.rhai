// Garage parking wheel stop: 550 mm long, 150 mm base, 60 mm top, 100 mm high trapezoid, cored underside with ribs, 2 anchor holes 18 mm with 32 mm counterbores
let length = 550.0; // [400.0, 900.0] Length (mm)
let height = 100.0; // [70.0, 120.0] Height (mm)
let base = 150.0; // [120.0, 200.0] Base width (mm)
let top = 60.0; // [40.0, 80.0] Top width (mm)
let pockets = 4; // [2, 6] Number of underside pockets

const rib = 8.0;
const anchor_in = 60.0;
let profile = polygon([[0, -base / 2.0, 0], [0, base / 2.0, 0], [0, top / 2.0, height], [0, -top / 2.0, height]]);
let stop = profile.to_face().extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
let side = polygon([[-length / 2.0, -base, 0], [length / 2.0, -base, 0], [length / 2.0, -base, height - 35.0], [length / 2.0 - 50.0, -base, height], [-length / 2.0 + 50.0, -base, height], [-length / 2.0, -base, height - 35.0]]);
stop = stop & side.to_face().extrude([0, 2.0 * base, 0]);
stop = stop.chamfer(4.0, stop.edges(">Z"));

// cored underside: pockets between the anchor bosses, walls about 12 mm at their tops
let pocket_h = height * 0.5;
let half_w = (base / 2.0 - (base / 2.0 - top / 2.0) * pocket_h / height) - 12.0;
let span = length - 2.0 * anchor_in - 40.0;
let pl = (span - (pockets - 1) * rib) / pockets;
let cuts = [];
for i in 0..pockets {
    let x0 = -span / 2.0 + i * (pl + rib);
    cuts.push(box_from_corners([x0, -half_w, -1.0], [x0 + pl, half_w, pocket_h]));
}
stop = stop - compound(cuts);

for s in [-1.0, 1.0] {
    let x = s * (length / 2.0 - anchor_in);
    stop = stop - cylinder([x, 0, -1.0], "Z", 9.0, height + 2.0) - cylinder([x, 0, height * 0.4], "Z", 16.0, height);
}
stop
