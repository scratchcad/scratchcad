// A tugboat after the 3DBenchy, 60 mm long: a lofted hull with a rising sheer and a raked
// bow, an open deck behind bulwarks, a wheelhouse with arched doors and windows, an
// overhanging roof, a hollow chimney, a deck box at the stern and hawse holes at the bow.
// The stern is at x = 0 and the bow at +X; the keel sits on the XY plane.

// # Hull
let length = 60.0; // [40.0, 90.0] Length (mm)
let beam = 31.0; // [20.0, 45.0] Beam (mm)
let wall = 1.6; // [0.8, 3.0] Hull wall thickness (mm)
let deck_height = 9.0; // [5.0, 13.0] Deck height above the keel (mm)
// # Wheelhouse
let cabin_height = 22.0; // [14.0, 30.0] Wheelhouse height above the deck (mm)
let roof_thickness = 2.0; // [1.0, 4.0] Roof thickness (mm)
let chimney_height = 10.0; // [4.0, 16.0] Chimney height above the roof (mm)

let sx = length / 60.0; // the stations below are drawn for a 60 mm boat
let sy = beam / 31.0;

// Hull stations from the stern to the bow: [x, half beam at the deck, deck edge height, keel
// height], for a 60 x 31 mm boat.
let stations = [
    [0.0, 12.5, 16.0, 3.0],
    [6.0, 14.6, 15.4, 0.6],
    [16.0, 15.5, 15.0, 0.0],
    [28.0, 15.5, 15.4, 0.0],
    [40.0, 14.6, 16.8, 0.4],
    [49.0, 11.6, 19.0, 3.0],
    [55.0, 7.4, 21.0, 7.5],
    [59.0, 2.2, 22.6, 15.0],
];

// A hull section in the plane x: a spline from the port deck edge down round the bilge and
// back up to starboard, closed by a straight line across the deck. The sides flare outward
// toward the deck, and the bottom is flat where the keel allows it.
fn hull_section(x, w, h, k) {
    let d = h - k;
    let pts = [
        [x, w, h],
        [x, w * 0.97, k + d * 0.6],
        [x, w * 0.86, k + d * 0.25],
        [x, w * 0.6, k + d * 0.04],
        [x, 0.0, k],
        [x, -w * 0.6, k + d * 0.04],
        [x, -w * 0.86, k + d * 0.25],
        [x, -w * 0.97, k + d * 0.6],
        [x, -w, h],
    ];
    wire([spline(pts), line([x, -w, h], [x, w, h])])
}

let outer = [];
for s in stations {
    outer.push(hull_section(s[0] * sx, s[1] * sy, s[2], s[3]));
}
let hull = loft(outer, true);

// The deck well: the same stations moved in by the wall thickness, from the transom to just
// short of the bow, standing well above the deck edge and cut off at the deck height.
let inner = [];
let last = stations.len() - 2;
for i in 0..=last {
    let s = stations[i];
    let x = if i == 0 { wall / sx } else if i == last { s[0] - wall * 2.0 / sx } else { s[0] };
    inner.push(hull_section(x * sx, s[1] * sy - wall, s[2] + 10.0, s[3] + wall));
}
let well = loft(inner, true) & box_from_corners([-1, -beam, deck_height], [length, beam, 40]);
hull = hull - well;

// Hawse holes through the bulwarks near the bow.
let hawse_x = 51.0 * sx;
hull = hull - cylinder([hawse_x, -beam, 17.0], "Y", 1.8, beam * 2.0);

// # Wheelhouse: a hollow box with arched doors in its sides, a window in front and one
// behind, under a roof that overhangs it, with the chimney toward its back.
let cabin_x0 = 17.0 * sx;
let cabin_x1 = 37.0 * sx;
let cabin_w = 21.0 * sy;
let cabin_top = deck_height + cabin_height;
let cabin_wall = 1.6;
let cabin = box_from_corners([cabin_x0, -cabin_w / 2.0, deck_height - 1.0], [cabin_x1, cabin_w / 2.0, cabin_top]);
let room = box_from_corners(
    [cabin_x0 + cabin_wall, -cabin_w / 2.0 + cabin_wall, deck_height],
    [cabin_x1 - cabin_wall, cabin_w / 2.0 - cabin_wall, cabin_top + 1.0],
);
cabin = cabin - room;

// An arched opening through both sides: a box with a half cylinder on top.
let door_w = (cabin_x1 - cabin_x0) * 0.55;
let door_x = (cabin_x0 + cabin_x1) / 2.0;
let door_h = cabin_height * 0.5;
let door = box_from_corners([door_x - door_w / 2.0, -beam, deck_height + 2.0], [door_x + door_w / 2.0, beam, deck_height + door_h])
    + cylinder([door_x, -beam, deck_height + door_h], "Y", door_w / 2.0, beam * 2.0);
// Windows: wide in front, a little smaller behind.
let front_window = box_from_corners([cabin_x1 - 5.0, -cabin_w * 0.32, cabin_top - 11.0], [cabin_x1 + 1.0, cabin_w * 0.32, cabin_top - 2.5])
    .fillet(1.0, "|X");
let back_window = box_from_corners([cabin_x0 - 1.0, -cabin_w * 0.27, cabin_top - 10.0], [cabin_x0 + 5.0, cabin_w * 0.27, cabin_top - 3.0])
    .fillet(1.0, "|X");
cabin = cabin - door - front_window - back_window;

let roof = box_from_corners([cabin_x0 - 3.0 * sx, -cabin_w / 2.0 - 2.5, cabin_top], [cabin_x1 + 3.5 * sx, cabin_w / 2.0 + 2.5, cabin_top + roof_thickness])
    .fillet(1.2, "|Z")
    .chamfer(0.5, ">Z");

let chimney_x = cabin_x0 + 4.5 * sx;
let chimney = cylinder([chimney_x, 0, cabin_top + 1.0], "Z", 3.5, roof_thickness + chimney_height - 1.0)
    - cylinder([chimney_x, 0, cabin_top + 1.5], "Z", 1.6, roof_thickness + chimney_height);

// # Deck box at the stern, with a round socket in its top.
let box_x = 7.5 * sx;
let deck_box = box_centered(7.0, 12.0 * sy, 6.0).translate([box_x, 0, deck_height + 2.0]).fillet(0.8, "|Z")
    - cylinder([box_x, 0, deck_height + 2.0], "Z", 2.0, 6.0);

fuse_all([hull, cabin, roof, chimney, deck_box])
