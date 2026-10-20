// PTO shaft guard cone retaining clip: 50 degree arc of a 104 mm ring, 3 mm thick and 14 mm tall, with a 2.5 mm hook lip 2 mm deep along its lower inner edge that snaps into the guard bearing ring groove, a 3 mm locating pip on the inside face, and a 10 mm finger tab 8 mm long at one end
let ring_d = 104.0; // [70.0, 140.0] Guard ring diameter (mm)
let arc = 50.0; // [30.0, 80.0] Clip arc (degrees)
let height = 14.0; // [10.0, 20.0] Clip height (mm)
let thickness = 3.0; // [2.0, 4.5] Clip thickness (mm)
const lip = 2.5;
const lip_h = 2.0;
const tab_len = 8.0;
let ri = ring_d / 2.0;
let ro = ri + thickness;
let profile = polygon([[ri - lip, 0, 0], [ro, 0, 0], [ro, 0, height], [ri, 0, height], [ri, 0, lip_h], [ri - lip, 0, lip_h]]);
let body = profile.to_face().revolve("Z", arc);
let tab = box_from_corners([ri, -tab_len, height / 2.0 - 5.0], [ro, 0.5, height / 2.0 + 5.0]);
let tab = tab.fillet(2.0, tab.edges("|X and <Y"));
let pip = sphere([ri, 0, height * 0.6], 1.5).rotate_z(arc / 2.0);
fuse_all([body, tab, pip])
