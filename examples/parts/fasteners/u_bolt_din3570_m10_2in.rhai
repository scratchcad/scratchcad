// Pipe U-bolt DIN 3570 for 2 in (60.3 mm OD) pipe: M10 round bar, 62 mm inside width, 85 mm legs from the bend centre, 40 mm thread length shown as 1.5 mm pitch rings
let pipe_od = 60.3; // [20.0, 170.0] Pipe outer diameter (mm)
let bar_diameter = 10.0; // [6.0, 20.0] Bar diameter (mm)
let leg_length = 85.0; // [40.0, 200.0] Leg length from the bend centre (mm)
let thread_length = 40.0; // [10.0, 80.0] Thread length (mm)
const pitch = 1.5;
let rb = bar_diameter / 2.0;
let rc = (pipe_od + 1.7 + bar_diameter) / 2.0;
let path = wire([line([-rc, 0, leg_length], [-rc, 0, 0]), arc([-rc, 0, 0], [0, 0, -rc], [rc, 0, 0]), line([rc, 0, 0], [rc, 0, leg_length])]);
let bar = circle([-rc, 0, leg_length], "-Z", rb).to_face().sweep(path);
let tl = min(thread_length, leg_length - 5.0);
let n = (tl / pitch).floor().to_int();
let grooves = [];
for side in [-1.0, 1.0] {
    for i in 0..n {
        let z = leg_length - 1.0 - i.to_float() * pitch;
        grooves.push(polygon([[side * rc + rb + 1.0, 0, z - pitch * 0.45], [side * rc + rb - 0.6, 0, z], [side * rc + rb + 1.0, 0, z + pitch * 0.45]]).to_face().revolve([side * rc, 0, 0], "Z", 360));
    }
}
bar - compound(grooves)
