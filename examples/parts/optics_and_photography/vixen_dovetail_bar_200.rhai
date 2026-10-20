// Vixen-style telescope dovetail bar: 200 mm long, 44 mm wide at the base, 15 mm tall, 15 deg dovetail flanks, 8 mm safety groove underneath, M6 and 1/4-20 mounting holes along the centre
let length = 200.0; // [100.0, 400.0] Bar length (mm)
let base_width = 44.0; // [42.0, 46.0] Base width (mm)
let height = 15.0; // [10.0, 20.0] Bar height (mm)
let flank_angle = 15.0; // [10.0, 20.0] Flank angle from vertical (deg)
let hole_pitch = 30.0; // [20.0, 60.0] Mounting hole pitch (mm)
let w = base_width / 2.0;
let top = w - height * (flank_angle * PI() / 180.0).tan();
let profile = polygon("YZ", [[-w, 0], [-4.0, 0], [-4.0, 3.0], [4.0, 3.0], [4.0, 0], [w, 0], [top, height], [-top, height]]);
let bar = profile.to_face().extrude([length, 0, 0]).translate([-length / 2.0, 0, 0]);
bar = bar.chamfer(0.8, "|Y");
let n = ((length - 20.0) / hole_pitch).floor().to_int() + 1;
let holes = [];
for i in 0..n {
    let x = (i.to_float() - (n - 1).to_float() / 2.0) * hole_pitch;
    // alternate M6 clearance holes counterbored from the top and 1/4-20 tap-drill holes
    if i % 2 == 0 {
        holes.push(cylinder([x, 0, -1.0], "Z", 3.3, height + 2.0) + cylinder([x, 0, height - 6.0], "Z", 5.5, 7.0));
    } else {
        holes.push(cylinder([x, 0, -1.0], "Z", 2.55, height + 2.0));
    }
}
bar - compound(holes)
