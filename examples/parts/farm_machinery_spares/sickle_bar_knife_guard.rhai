// Sickle bar mower knife guard: forged finger 110 mm long, 30 mm wide at the bar tapering to a 10 mm blunt point, 16 mm thick, with a 3.5 mm knife slot 50 mm long through it 6 mm above the base for the knife sections, and two 10.5 mm bolt holes 12 mm apart one behind the other in the 25 mm heel for M10 bolts to the cutter bar
let length = 110.0; // [80.0, 140.0] Guard length (mm)
let width = 30.0; // [24.0, 40.0] Heel width (mm)
let thickness = 16.0; // [12.0, 22.0] Guard thickness (mm)
let slot_h = 3.5; // [2.5, 5.0] Knife slot height (mm)
let slot_len = 50.0; // [35.0, 65.0] Knife slot length (mm)
const heel = 25.0;
const bolt_d = 10.5;
const slot_z = 6.0;
let w = width / 2.0;
let x_taper = heel + 20.0;
let plan = polygon([[0, -w, 0], [x_taper, -w, 0], [length - 10.0, -4.0, 0], [length, 0, 0], [length - 10.0, 4.0, 0], [x_taper, w, 0], [0, w, 0]]);
let guard = plan.to_face().extrude([0, 0, thickness]);
let sl = min(slot_len, length - heel - 20.0);
let sh = min(slot_h, thickness - slot_z - 3.0);
guard - fuse_all([
    box_from_corners([heel, -w - 1.0, slot_z], [heel + sl, w + 1.0, slot_z + sh]),
    cylinder([6.5, 0, -1.0], "Z", bolt_d / 2.0, thickness + 2.0),
    cylinder([18.5, 0, -1.0], "Z", bolt_d / 2.0, thickness + 2.0),
])
