// Vertical blind vane hanger: 89 mm vane clip, 13 mm wide hook 28 mm tall, slot 90 x 1.5 mm, 4 mm stem
let vane = 89.0; // [64.0, 127.0] Vane width (mm)
let t = 2.0; // [1.5, 3.0] Thickness (mm)
let clip = box_from_corners([-vane / 2.0 - 3.0, -t, 0], [vane / 2.0 + 3.0, t, 14.0]) - box_from_corners([-vane / 2.0, -0.75, 2.0], [vane / 2.0, 0.75, 15.0]);
let c = clip.fillet(2.0, clip.edges("|Y and <Z"));
let stem = cylinder([0, 0, 13.99], "Z", 2.0, 10.0);
let hook = box_from_corners([-6.5, -t, 23.99], [6.5, t, 28.0]) - box_from_corners([-4.0, -t - 1.0, 25.0], [4.0, t + 1.0, 27.0]);
c + stem + hook
