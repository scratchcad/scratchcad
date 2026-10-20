// DIN 580 style lifting eye bolt M12 for a cabinet roof: 54 mm eye with a 30 mm hole and 10 mm thick ring, 30 mm collar 8 mm tall, M12 shank 20 mm long, 1 mm chamfers on the ring
let thread_d = 12.0; // [8.0, 20.0] Thread size (mm)
let shank_len = 20.0; // [12.0, 40.0] Thread length (mm)
const eye_od_k = 4.5;
const eye_id_k = 2.5;
let eye_od = thread_d * eye_od_k;
let eye_id = thread_d * eye_id_k;
let ring_t = thread_d * 0.85;
let collar_d = eye_id;
let collar_h = thread_d * 0.65;
let ring = cylinder([0, -ring_t / 2.0, 0], "Y", eye_od / 2.0, ring_t);
let ring = ring.chamfer(1.0, ring.edges("%CIRCLE"));
let ring = ring - cylinder([0, -ring_t, 0], "Y", eye_id / 2.0, ring_t * 2.0);
let zc = collar_h + eye_od / 2.0 - 2.0;
let ring = ring.translate([0, 0, zc]);
let collar = cylinder([0, 0, 0], "Z", collar_d / 2.0, collar_h + 2.5);
let neck = box_centered(eye_id * 0.6, ring_t, 4.0).translate([0, 0, collar_h + 1.0]);
let shank = cylinder([0, 0, -shank_len], "Z", thread_d / 2.0, shank_len + 0.5);
let shank = shank.chamfer(1.0, shank.edges("<Z"));
ring + collar + neck + shank
