// Monitor riser shelf with cable notch: 500 x 220 mm top 10 mm thick, 100 mm clearance for a keyboard, two 12 mm end legs with arched cut-outs, 70 x 25 mm cable notch in the back edge, 4 rubber foot recesses
let width = 500.0; // [350.0, 600.0] Shelf width (mm)
let depth = 220.0; // [180.0, 280.0] Shelf depth (mm)
let clearance = 100.0; // [70.0, 140.0] Height under the shelf (mm)
let top_t = 10.0; // [8.0, 15.0] Top thickness (mm)
let notch_w = 70.0; // [40.0, 120.0] Cable notch width (mm)

const leg_t = 12.0;
const notch_d = 25.0;
let h = clearance + top_t;
let top = box_from_corners([-width / 2.0, 0, clearance], [width / 2.0, depth, h]);
top = top.fillet(10.0, top.edges("|Z"));
top = top.fillet(2.0, top.edges(">Z"));
let legs = [];
for s in [-1.0, 1.0] {
    let x0 = if s < 0.0 { -width / 2.0 } else { width / 2.0 - leg_t };
    let leg = box_from_corners([x0, 0, 0], [x0 + leg_t, depth, clearance + 1.0]);
    leg = leg.fillet(10.0, leg.edges("|Z").filter(|e| (e.center().x.abs() - width / 2.0).abs() < 0.01));
    leg = leg - cylinder([x0 - 1.0, depth / 2.0, 0], "X", min(depth * 0.3, clearance * 0.7), leg_t + 2.0);
    legs.push(leg);
}
let riser = top + fuse_all(legs);
let nw = min(notch_w, width - 4.0 * leg_t - 40.0);
let notch = box_from_corners([-nw / 2.0, depth - notch_d, clearance - 1.0], [nw / 2.0, depth + 1.0, h + 1.0]);
riser = riser - notch.fillet(8.0, notch.edges("|Z and <Y"));
for s in [-1.0, 1.0] {
    for y in [20.0, depth - 20.0] {
        riser = riser - cylinder([s * (width / 2.0 - leg_t / 2.0), y, -1.0], "Z", 5.1, 2.5);
    }
}
riser
