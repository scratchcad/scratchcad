// Windscreen ice scraper: 100 mm blade tapering to 45 mm, 1.5 mm scraping edge thickening to 6 mm over 70 mm, 150 mm x 30 x 18 mm handle, 4 ice-breaker ribs, 8 mm hang hole
let blade_w = 100.0; // [70.0, 130.0] Blade width (mm)
let blade_l = 70.0; // [50.0, 90.0] Blade length (mm)
let edge = 1.5; // [1.0, 3.0] Scraping edge thickness (mm)
let handle_l = 150.0; // [100.0, 200.0] Handle length (mm)
let handle_w = 30.0; // [24.0, 40.0] Handle width (mm)

const root_t = 6.0;
const handle_h = 18.0;
let side = polygon([[-blade_w, 0, 0], [-blade_w, blade_l, 0], [-blade_w, blade_l, root_t], [-blade_w, 0, edge]]);
let blade = side.to_face().extrude([2.0 * blade_w, 0, 0]);
let plan = polygon([[-blade_w / 2.0, 0, -1.0], [blade_w / 2.0, 0, -1.0], [handle_w / 2.0 + 8.0, blade_l, -1.0], [-handle_w / 2.0 - 8.0, blade_l, -1.0]]);
blade = blade & plan.to_face().extrude([0, 0, root_t + 2.0]);
let ribs = [];
for i in 0..4 {
    let x = (i - 1.5) * blade_w / 6.0;
    ribs.push(box_from_corners([x - 1.0, blade_l * 0.35, 0], [x + 1.0, blade_l + 1.0, root_t + 1.5]));
}
let handle = box_from_corners([-handle_w / 2.0, blade_l - 5.0, 0], [handle_w / 2.0, blade_l + handle_l, handle_h]);
handle = handle.fillet(min(handle_h / 2.0 - 1.0, 8.0), handle.edges("|Y"));
handle = handle.fillet(5.0, handle.edges(">Y"));
let scraper = fuse_all([blade, (fuse_all(ribs) & plan.to_face().extrude([0, 0, root_t + 3.0])), handle]);
scraper - cylinder([0, blade_l + handle_l - 14.0, -1.0], "Z", 4.0, handle_h + 2.0)
