// Sneeze guard post clamp: 40 mm round collar 30 mm tall for a 25.4 mm post, a 22 mm wing with a 10.5 mm slot 18 mm deep for 10 mm glass, and M6 set-screw holes (5 mm tap) into the post and the glass
let post_d = 25.4; // [19.0, 32.0] Post diameter (mm)
let glass = 10.5; // [6.5, 12.5] Glass slot width (mm)
let height = 30.0; // [20.0, 45.0] Clamp height (mm)
const wing = 22.0;
const slot_depth = 18.0;
let ro = post_d / 2.0 + 7.0;
let body = cylinder([0, 0, 0], "Z", ro, height) + box_from_corners([0, -glass / 2.0 - 5.0, 0], [ro + wing, glass / 2.0 + 5.0, height]);
body = body.fillet(3.0, body.edges("|Z").filter(|e| e.center().x > ro));
body = body - cylinder([0, 0, -1.0], "Z", post_d / 2.0, height + 2.0);
body = body - box_from_corners([ro + wing - slot_depth, -glass / 2.0, -1.0], [ro + wing + 1.0, glass / 2.0, height + 1.0]);
body - cylinder([-ro - 1.0, 0, height / 2.0], "X", 2.5, 8.0) - cylinder([ro + wing - slot_depth / 2.0, -glass / 2.0 - 6.0, height / 2.0], "Y", 2.5, 7.0)
