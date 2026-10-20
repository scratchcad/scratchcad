// Push-in end cap for a 50 mm mailing tube (47 mm bore): 52 mm flange 2 mm thick with a lift tab, 15 mm hollow plug 1.5 mm wall with six friction ribs and a lead-in chamfer
let tube_bore = 47.0; // [20.0, 100.0] Tube inside diameter (mm)
let flange_diameter = 52.0; // [22.0, 110.0] Flange diameter (mm)
let plug_length = 15.0; // [8.0, 30.0] Plug length (mm)
let wall = 1.5; // [1.0, 3.0] Plug wall (mm)
let ribs = 6; // [0, 12] Number of friction ribs
let rp = tube_bore / 2.0 - 0.3;
let rf = max(flange_diameter / 2.0, rp + 1.5);
let cap = cylinder(rf, 2.0).fillet(0.6, ">Z");
let plug = cylinder([0, 0, -plug_length], "Z", rp, plug_length + 0.1) - cylinder([0, 0, -plug_length - 1.0], "Z", rp - wall, plug_length + 1.0);
// lead-in chamfer on the outer bottom edge only
plug = plug.chamfer(min(0.8, wall / 2.0), plug.edges("%CIRCLE and <Z").sort_by(|e| e.radius()).last());
cap = cap + plug;
let rib_parts = [cap];
for i in 0..ribs {
    rib_parts.push(cylinder([rp - 0.2, 0, -plug_length + 2.0], "Z", 0.6, plug_length - 2.0).rotate_z(i.to_float() * 360.0 / ribs.to_float()));
}
cap = fuse_all(rib_parts);
// lift tab over the edge
cap + box_from_corners([-6.0, rf - 3.0, 0], [6.0, rf + 5.0, 1.2]).fillet(2.0, "|Z and >Y")
