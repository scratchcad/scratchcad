// Cable protector ramp: 500 mm section, 250 mm wide trapezoid 50 mm tall, three 30 x 30 mm cable channels underneath, 4 mm tread grooves and a 40 mm dovetail tongue on one end
let length = 500.0; // [300.0, 1000.0] Section length (mm)
let width = 250.0; // [180.0, 400.0] Width (mm)
let height = 50.0; // [30.0, 80.0] Height (mm)
let channel = 30.0; // [15.0, 45.0] Channel size (mm)
let channels = 3; // [1, 5] Number of cable channels
let top = width * 0.45;
let body = polygon("YZ", [[-width / 2.0, 0], [width / 2.0, 0], [top / 2.0, height], [-top / 2.0, height]]).to_face().extrude([length, 0, 0]);
let cuts = [];
let pitch = (top - channel) / (channels.to_float() - 1.0).max(1.0);
for i in 0..channels {
    let y = if channels == 1 { 0.0 } else { -top / 2.0 + channel / 2.0 + i.to_float() * pitch };
    cuts.push(box_from_corners([-1.0, y - channel / 2.0, -1.0], [length + 1.0, y + channel / 2.0, channel]));
}
let grooves = [];
for k in 0..12 { grooves.push(box_from_corners([20.0 + k.to_float() * (length - 40.0) / 11.5, -width, height - 2.0], [24.0 + k.to_float() * (length - 40.0) / 11.5, width, height + 1.0])); }
let tongue = polygon("XY", [[length - 0.01, -15.0], [length + 30.0, -25.0], [length + 30.0, 25.0], [length - 0.01, 15.0]]).to_face().extrude([0, 0, 15.0]).translate([0, width / 2.0 - 40.0, 0]);
body - compound(cuts) - compound(grooves) + tongue
