// Upper tension thumbwheel: 30 mm wheel 7 mm thick with 40 fine V-notches 0.6 mm deep round the rim, 10 mm hubs standing 2 mm proud on both faces, 5.2 mm bore with an 8 mm across flats hex nut pocket 3 mm deep in one hub
let wheel_d = 30.0; // [22.0, 40.0] Wheel diameter (mm)
let thickness = 7.0; // [5.0, 10.0] Wheel thickness (mm)
let notches = 40; // [20, 60] Number of grip notches
let bore = 5.2; // [4.2, 6.2] Bore diameter (mm)
const hub_d = 10.0;
const hub_h = 2.0;
const nut_af = 8.0;
let r = wheel_d / 2.0;
let wheel = fuse_all([
    cylinder(r, thickness),
    cylinder([0, 0, -hub_h], "Z", hub_d / 2.0 + 0.5, thickness + 2.0 * hub_h),
]);
let s = 0.6 * sqrt(2.0);
let cuts = [cylinder([0, 0, -hub_h - 1.0], "Z", bore / 2.0, thickness + 2.0 * hub_h + 2.0)];
for i in 0..notches {
    let a = i.to_float() * 360.0 / notches.to_float();
    cuts.push(box_centered(s, s, thickness + 2.0).rotate_z(45.0).translate([r, 0, thickness / 2.0]).rotate_z(a));
}
let rn = nut_af / sqrt(3.0);
let pts = [];
for i in 0..6 {
    let a = i.to_float() * 60.0 * PI() / 180.0;
    pts.push([rn * cos(a), rn * sin(a), 0.0]);
}
cuts.push(polygon(pts).to_face().extrude([0, 0, 4.0]).translate([0, 0, thickness + hub_h - 3.0]));
wheel - fuse_all(cuts)
