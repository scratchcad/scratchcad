// Pill crusher mortar and pestle: 60 mm mortar 35 mm tall with a 40 mm spherical bowl and pour lip, 90 mm pestle with a 30 mm ball end and grip flare
let mortar_diameter = 60.0; // [45.0, 90.0] Mortar diameter (mm)
let mortar_height = 35.0; // [25.0, 50.0] Mortar height (mm)
let bowl_diameter = 40.0; // [25.0, 70.0] Bowl diameter (mm)
let pestle_length = 90.0; // [60.0, 130.0] Pestle length (mm)
let rm = mortar_diameter / 2.0;
let rbowl = min(bowl_diameter / 2.0, rm - 5.0);
let hm = mortar_height;
let mortar = sketch("XZ").move_to(0, 0).hline_to(rm - 6.0).line_to(rm, 8.0).vline_to(hm - 2.0).line_to(rm - 2.0, hm).hline_to(0).close().to_face().revolve("Z", 360);
mortar -= sphere([0, 0, hm + rbowl * 0.25], rbowl);
mortar -= box_from_corners([rm - 5.0, -4.0, hm - 3.0], [rm + 1.0, 4.0, hm + 1.0]).rotate([rm, 0, hm], "Y", -15.0);
let rp = rbowl * 0.75;
let pestle = sketch("XZ").move_to(0, 0).hline_to(rp * 0.6).line_to(rp * 0.45, pestle_length * 0.6).line_to(rp * 0.75, pestle_length - 6.0)
    .arc_to(rp * 0.6, pestle_length - 1.0, 0, pestle_length).close().to_face().revolve("Z", 360);
pestle = pestle + sphere([0, 0, 0], rp);
compound([mortar, pestle.translate([0, 0, hm + rbowl * 0.25 - rbowl + rp + 0.5])])
