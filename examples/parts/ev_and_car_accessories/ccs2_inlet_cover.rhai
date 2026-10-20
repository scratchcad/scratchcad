// CCS Combo 2 car inlet cover: push-on cap over a 70 mm AC (Type 2) rim and a 64 x 32 mm DC stadium 50 mm below, 2 mm wall, 18 mm skirt, hinge lug 3 mm pin, pull tab
let ac_d = 70.0; // [62.0, 76.0] AC rim diameter (mm)
let dc_w = 64.0; // [56.0, 70.0] DC section width (mm)
let dc_h = 32.0; // [26.0, 36.0] DC section height (mm)
let spacing = 50.0; // [44.0, 56.0] AC to DC centre distance (mm)
let wall = 2.0; // [1.6, 3.0] Wall (mm)
let skirt = 18.0; // [10.0, 25.0] Skirt depth (mm)

const top_t = 2.5;
let outline = |grow, z0, hgt| {
    let r = dc_h / 2.0 + grow;
    let a = dc_w / 2.0 - dc_h / 2.0;
    let st = sketch("XY").move_to(-a, -r).hline(2.0 * a).arc_to(a + r, 0, a, r).hline(-2.0 * a).arc_to(-a - r, 0, -a, -r).close();
    let dc = st.to_face().extrude([0, 0, hgt]).translate([0, -spacing, z0]);
    let ac = cylinder([0, 0, z0], "Z", ac_d / 2.0 + grow, hgt);
    let bridge = box_from_corners([-ac_d * 0.3 - grow, -spacing, z0], [ac_d * 0.3 + grow, 0, z0 + hgt]);
    fuse_all([ac, dc, bridge])
};
let h = skirt + top_t;
let cap = outline.call(wall, 0.0, h) - outline.call(0.0, top_t, h);
// hinge lug above the AC rim and a pull tab below the DC section
let ytop = ac_d / 2.0 + wall;
let lug = box_from_corners([-8.0, ytop - 1.0, 0], [8.0, ytop + 6.0, 8.0]) + cylinder([-8.0, ytop + 6.0, 4.0], "X", 4.0, 16.0);
lug = lug - cylinder([-9.0, ytop + 6.0, 4.0], "X", 1.6, 18.0);
let ybot = -spacing - dc_h / 2.0 - wall;
let tab = box_from_corners([-12.0, ybot - 12.0, 0], [12.0, ybot + 1.0, 2.5]);
tab = tab.fillet(6.0, tab.edges("|Z and <Y"));
fuse_all([cap, lug, tab]).clean()
