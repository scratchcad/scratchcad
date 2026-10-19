// An ISO 4014 M10 x 40 hex bolt (26 mm of coarse thread) and a matching ISO 4032 hex nut,
// side by side. The threads have the 60 degree ISO profile.

// # Thread
let diameter = 10.0; // [6.0, 16.0] Thread diameter (mm)
let thread_pitch = 1.5; // [0.75, 2.5] Thread pitch (mm)
let thread_length = 26.0; // [10.0, 40.0] Thread length (mm)
// # Bolt
let bolt_length = 40.0; // [20.0, 60.0] Bolt length under the head (mm)
let head_height = 6.4; // [3.0, 12.0] Head height (mm)
let across_flats = 16.0; // [10.0, 26.0] Width across flats (mm)
// # Nut
let nut_height = 8.4; // [4.0, 14.0] Nut height (mm)
let spacing = 26.0; // [20.0, 50.0] Distance between bolt and nut (mm)

let thread_length = min(thread_length, bolt_length);
let across_flats = max(across_flats, diameter * 1.3);
let r_major = diameter / 2.0;
let depth = 0.6134 * thread_pitch; // ISO external thread depth
let r_minor = r_major - depth;
let tan30 = (30.0 * PI() / 180.0).tan();
let r_corner = across_flats / sqrt(3.0); // across corners / 2

// A thread: a loft through copies of `section` (drawn in the XZ plane), each turned about Z and
// raised by the pitch per turn, 12 to a turn. Every turn ends on an exact copy of the section.
fn helical(section, pitch, turns) {
    let per_turn = 12;
    let sections = [];
    for i in 0..=(turns * per_turn) {
        let t = i.to_float() / per_turn.to_float();
        sections.push(section.rotate_z(t * 360.0).translate([0, 0, t * pitch]));
    }
    loft(sections, true)
}

// A thread section in the XZ plane, centered on height z0: 60 degree flanks from r_root out
// to a flat of `crest` at r_out, on a straight stem from r_in that sinks into the core (or the
// bore) so the boolean overlaps it well.
fn thread_section(r_in, r_root, r_out, crest, z0, tan30) {
    let w = crest / 2.0 + (r_out - r_root) * tan30;
    polygon([
        [r_in, 0, z0 - w],
        [r_root, 0, z0 - w],
        [r_out, 0, z0 - crest / 2.0],
        [r_out, 0, z0 + crest / 2.0],
        [r_root, 0, z0 + w],
        [r_in, 0, z0 + w],
    ])
}

// A hex prism with both ends chamfered at 30 degrees, as on bolt heads and nuts.
fn chamfered_hex(r_corner, across_flats, height, tan30) {
    let pts = [];
    for i in 0..6 {
        let a = (i * 60 + 30).to_float() * PI() / 180.0;
        pts.push([r_corner * a.cos(), r_corner * a.sin()]);
    }
    let hex = polygon(pts).to_face().extrude(height);
    // Chamfers start just inside the flats and cut the corners off.
    let r0 = across_flats * 0.475;
    let drop = (r_corner + 1.0 - r0) * tan30;
    let envelope = sketch("XZ")
        .move_to(0, 0)
        .hline_to(r0)
        .line_to(r_corner + 1.0, drop)
        .vline_to(height - drop)
        .line_to(r0, height)
        .hline_to(0)
        .close()
        .to_face()
        .revolve("Z", 360);
    hex & envelope
}

// # Bolt: the head stands on the XY plane and the shank points up.
let head = chamfered_hex(r_corner, across_flats, head_height, tan30);
let top = head_height + bolt_length;
let thread_start = top - thread_length;

let shank = cylinder([0, 0, head_height - 0.5], "Z", r_major, thread_start - head_height + 0.5);
// The thread runs from just above the shank to past the tip, and the core past the thread
// (booleans struggle where a cylinder's end cuts across a thread). A 45 degree chamfer down
// to the minor diameter then cuts the tip, and the thread with it.
let turns = (thread_length / thread_pitch).ceiling().to_int() + 1;
let core = cylinder([0, 0, thread_start - 0.1], "Z", r_minor, (turns + 2).to_float() * thread_pitch);
let section = thread_section(r_minor - 1.0, r_minor - 0.05, r_major, thread_pitch / 8.0, thread_start + thread_pitch / 2.0, tan30);
let ridge = helical(section, thread_pitch, turns);

let tip = sketch("XZ")
    .move_to(r_minor - 0.2, top)
    .line_to(r_major + 2.0, top - (r_major + 2.2 - r_minor))
    .vline_to(thread_start + (turns + 3).to_float() * thread_pitch)
    .hline_to(0)
    .vline_to(top)
    .close()
    .to_face()
    .revolve("Z", 360);

let bolt = fuse_all([head, shank, core, ridge]) - tip;

// # Nut: a chamfered hex with a bore at the internal thread's minor diameter, and a thread
// groove that runs out of both faces.
let nut_depth = 0.5413 * thread_pitch; // ISO internal thread depth
let r_bore = r_major - nut_depth;
let body = chamfered_hex(r_corner, across_flats, nut_height, tan30);
let groove_section = thread_section(r_bore - 1.0, r_bore - 0.05, r_major + 0.1, thread_pitch / 8.0, -thread_pitch, tan30);
let groove_turns = (nut_height / thread_pitch).ceiling().to_int() + 2;
let groove = helical(groove_section, thread_pitch, groove_turns);
// Booleans struggle where a cylinder's end cuts across a thread, so the bore runs past the
// groove at both ends, and the two make one threaded rod that cuts the nut.
let bore = cylinder([0, 0, -3.0 * thread_pitch], "Z", r_bore, (groove_turns + 4).to_float() * thread_pitch);
// 90 degree countersinks at both ends of the bore.
let sink = cone(r_major + 0.4, 0, r_major + 0.4);
let sinks = [sink.translate([0, 0, -0.4]), sink.mirror("XY").translate([0, 0, nut_height + 0.4])];
let nut = body - fuse_all([bore + groove] + sinks);

[bolt, nut.translate([spacing, 0, 0])]
