// Notebook pen loop clip: slides onto a 2.5 mm hardback cover edge, two 25 x 30 mm jaws 1.6 mm thick with a grip bump, 11 mm pen loop 30 mm tall with a 6 mm entry slit on the outside
let cover = 2.5; // [1.0, 4.0] Cover thickness (mm)
let jaw = 25.0; // [15.0, 35.0] Jaw depth (mm)
let height = 30.0; // [20.0, 50.0] Clip height (mm)
let pen = 11.0; // [8.0, 16.0] Pen diameter (mm)
let t = 1.6; // [1.2, 2.5] Jaw thickness (mm)

let gap = cover - 0.3;
let jaws = box_from_corners([0, -t, 0], [jaw + t, gap + t, height]) - box_from_corners([-1.0, 0, -1.0], [jaw, gap, height + 1.0]);
jaws = jaws + cylinder([jaw * 0.4, gap, 0], "Z", 0.6, height);
let ri = pen / 2.0 + 0.2;
let ro = ri + 1.6;
let xc = jaw + t + ri - 0.2;
let yc = gap / 2.0;
let loop_ = cylinder([xc, yc, 0], "Z", ro, height) - cylinder([xc, yc, -1.0], "Z", ri, height + 2.0);
loop_ = loop_ - box_from_corners([xc + ri - 1.0, yc - 3.0, -1.0], [xc + ro + 1.0, yc + 3.0, height + 1.0]);
let clip = jaws + loop_;
clip.fillet(0.5, clip.edges("|Y").filter(|e| e.center().z > height - 0.01 || e.center().z < 0.01).filter(|e| e.center().x < jaw - 0.1))
