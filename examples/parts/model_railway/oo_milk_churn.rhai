// OO scale 17 gallon milk churn: 1:76, 6.6 mm tall, 4 mm body, shoulder, neck and lid with handles
let scale_ = 76.0; // [43.5, 160.0] Scale ratio
let s = 76.0 / scale_;
let profile = sketch("XZ").move_to(0, 0).hline_to(2.0).vline_to(3.8).line_to(1.2, 4.8).vline_to(5.6).hline_to(1.5).vline_to(6.0).line_to(0.8, 6.6).hline_to(0).close();
let churn = profile.face().revolve("Z", 360);
let handles = box_centered(0.4, 4.6, 0.6).translate([0, 0, 4.2]);
(churn + handles).scale(s)
