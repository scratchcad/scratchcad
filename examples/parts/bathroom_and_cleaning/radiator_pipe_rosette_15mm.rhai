// Radiator pipe cover rosette for 15 mm copper: 40 mm conical cover 10 mm tall, 15.5 mm bore, 1.4 mm wall
let pipe_d = 15.5; // [10.0, 28.0] Pipe hole (mm)
let cover_d = 40.0; // [30.0, 60.0] Cover diameter (mm)
let height = 10.0; // [6.0, 18.0] Cover height (mm)
let wall = 1.4; // [1.0, 2.5] Wall thickness (mm)
let rp = pipe_d / 2.0;
let ro = cover_d / 2.0;
let pts = [[rp, 0, height], [rp, 0, height - wall], [rp + 0.8, 0, height - wall], [ro - wall, 0, 2.0 - wall * 0.5], [ro - wall, 0, 0], [ro, 0, 0], [ro, 0, 2.0], [rp + 1.8, 0, height]];
polygon(pts).to_face().revolve("Z", 360)
