// Taper candle holder: 22 mm socket 20 mm deep for 7/8 in tapers, 90 mm drip plate, 60 mm stem
let socket = 22.5; // [20.0, 25.0] Candle socket (mm)
let plate = 90.0; // [60.0, 120.0] Drip plate diameter (mm)
let stem_h = 60.0; // [30.0, 120.0] Stem height (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(35.0).vline_to(4.0).arc_to(15.0, 10.0, 8.0, 20.0).vline_to(stem_h).arc_to(18.0, stem_h + 5.0, plate / 2.0, stem_h + 8.0).vline_to(stem_h + 11.0).arc_to(plate / 2.0 - 20.0, stem_h + 9.0, socket / 2.0 + 3.0, stem_h + 14.0).vline_to(stem_h + 34.0).hline_to(0).close();
let body = p.face().revolve("Z", 360);
body - cylinder([0, 0, stem_h + 14.0], "Z", socket / 2.0, 30.0)
