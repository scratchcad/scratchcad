// Garden rain gauge: 100 mm collector funnel with a 20 mm sharp rim, 45 degree cone to a 10 mm spout, on a 30 mm measuring tube 150 mm tall with 10 mm marks
let collector = 100.0; // [70.0, 200.0] Collector diameter (mm)
let tube_diameter = 30.0; // [20.0, 50.0] Measuring tube diameter (mm)
let tube_height = 150.0; // [80.0, 250.0] Measuring tube height (mm)
let wall = 1.5; // [1.0, 3.0] Wall thickness (mm)
let R = collector / 2.0;
let rt = tube_diameter / 2.0;
let ztop = tube_height + 5.0;
let cone_h = R - 5.0;
// funnel: rim, cone and spout that drops into the tube
let fo = [[5.0, ztop - 20.0], [5.0 + wall, ztop - 20.0], [5.0 + wall, ztop], [R + wall, ztop + cone_h], [R + wall, ztop + cone_h + 20.0],
          [R, ztop + cone_h + 20.0], [R, ztop + cone_h + 0.6], [5.0, ztop + 0.6]];
let pts = [];
for q in fo { pts.push([q[0], 0, q[1]]); }
let funnel = polygon(pts).to_face().revolve("Z", 360);
let seat = cylinder([0, 0, ztop - 10.0], "Z", rt + 3.0, rt + 4.0) - cylinder([0, 0, ztop - 11.0], "Z", rt + 0.3, rt + 6.0);
funnel = funnel + seat;
// measuring tube with a foot and engraved marks
let tube = cylinder(rt, tube_height) - cylinder([0, 0, 3.0], "Z", rt - wall, tube_height);
tube += cylinder([0, 0, 0], "Z", rt + 8.0, 3.0);
let marks = [];
let n = (tube_height / 10.0).floor().to_int();
for i in 1..n {
    marks.push(box_centered(if i % 5 == 0 { 10.0 } else { 5.0 }, 2.0, 0.6).translate([0, -rt, i.to_float() * 10.0]));
}
compound([funnel, tube - compound(marks)])
