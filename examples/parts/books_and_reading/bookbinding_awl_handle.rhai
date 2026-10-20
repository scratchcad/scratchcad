// Bookbinding awl handle: 90 mm mushroom handle 30 mm head, 2 mm needle bore 25 mm deep with 4 mm ferrule boss
let length = 90.0; // [60.0, 120.0] Handle length (mm)
let head = 30.0; // [22.0, 40.0] Palm head diameter (mm)
let p = sketch("XZ").move_to(0, 0).hline_to(3.5).vline_to(8.0).line_to(8.0, 14.0).line_to(10.0, length - 25.0).line_to(head / 2.0, length - 12.0).line_to(head / 2.0 - 2.0, length - 4.0).line_to(head / 2.0 - 8.0, length).hline_to(0).close();
p.face().revolve("Z", 360) - cylinder([0, 0, -1], "Z", 1.0, 26.0)
