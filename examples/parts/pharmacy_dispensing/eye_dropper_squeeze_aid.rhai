// Eye dropper bottle squeeze aid: split ring with a 26 mm bore, 3 mm wall and 14 mm tall for a 10 ml dropper bottle, slotted 6 mm at the back, with two 3 mm squeeze arms running 45 mm back from either side of the slot and thickened to 9 mm over their last 18 mm as finger grips
let bottle_d = 26.0; // [20.0, 32.0] Bottle diameter (mm)
let wall = 3.0; // [2.0, 4.0] Ring wall (mm)
let ring_h = 14.0; // [10.0, 20.0] Ring height (mm)
let arm_len = 45.0; // [30.0, 60.0] Arm length (mm)
let gap = 6.0; // [4.0, 10.0] Slot width (mm)
const grip_len = 18.0;
let ri = bottle_d / 2.0;
let ro = ri + wall;
let y_end = ri + arm_len;
let arm = box_from_corners([gap / 2.0, ri, 0], [gap / 2.0 + wall, y_end, ring_h]);
let grip = box_from_corners([gap / 2.0, y_end - grip_len, 0], [gap / 2.0 + wall + 6.0, y_end, ring_h]);
let grip = grip.fillet(2.5, grip.edges("|Z and >X"));
let side = arm + grip;
let ring = cylinder(ro, ring_h) - cylinder([0, 0, -1.0], "Z", ri, ring_h + 2.0);
let aid = fuse_all([ring, side, side.mirror("YZ")]);
aid - box_from_corners([-gap / 2.0, 0, -1.0], [gap / 2.0, y_end + 1.0, ring_h + 1.0])
