// A mid-stage compressor blisk: a disk with 29 twisted airfoils machined in one piece, a
// bore for the shaft and a mounting flange at the rear. The axis is Z, with the rear face on
// the XY plane.

// # Disk
let tip_diameter = 440.0; // [300.0, 600.0] Outer tip diameter (mm)
let platform_diameter = 241.2; // [160.0, 400.0] Hub platform diameter (mm)
let bore_diameter = 80.0; // [40.0, 140.0] Shaft bore diameter (mm)
let hub_length = 77.5; // [40.0, 120.0] Axial hub length (mm)
let rim_width = 45.0; // [25.0, 80.0] Airfoil rim width (mm)
let web_thickness = 18.0; // [8.0, 40.0] Disk web thickness (mm)
// # Flange
let flange_inner_diameter = 184.0; // [120.0, 300.0] Flange inner shoulder diameter (mm)
let flange_outer_diameter = 202.0; // [130.0, 320.0] Flange outer rim diameter (mm)
// # Airfoils
let blades = 29; // [11, 61] Number of blades
let hub_stagger = 28.0; // [0.0, 60.0] Stagger at the hub, from the axis (degrees)
let tip_stagger = 56.0; // [10.0, 75.0] Stagger at the tip, from the axis (degrees)
let camber = 0.06; // [0.0, 0.12] Camber (fraction of chord)

let r_tip = tip_diameter / 2.0;
let r_platform = platform_diameter / 2.0;
let r_bore = bore_diameter / 2.0;
let r_flange_in = flange_inner_diameter / 2.0;
let r_flange_out = max(flange_outer_diameter / 2.0, r_flange_in + 4.0);
let mid = hub_length / 2.0;

// # Disk: one revolved profile, with the rim centered on the hub, a thinner web between the
// rim and the bore, and the flange running back from the rim to the rear face.
let rim_z0 = mid - rim_width / 2.0;
let rim_z1 = mid + rim_width / 2.0;
let r_rim_in = r_platform - 14.0;
let r_hub = r_bore + 24.0;
let web_z0 = mid - web_thickness / 2.0;
let web_z1 = mid + web_thickness / 2.0;
let taper = 10.0; // radial run of the slopes where the web meets the hub and the rim

let disk = sketch("XZ")
    .move_to(r_bore, 0)
    .hline_to(r_hub)
    .line_to(r_hub + taper, web_z0)
    .hline_to(r_flange_in - taper)
    .line_to(r_flange_in, web_z0 - taper)
    .vline_to(0)
    .hline_to(r_flange_out)
    .vline_to(rim_z0 - 4.0)
    .line_to(r_rim_in, rim_z0)
    .hline_to(r_platform)
    .vline_to(rim_z1)
    .hline_to(r_rim_in)
    .line_to(r_rim_in - taper, web_z1)
    .hline_to(r_hub + taper)
    .line_to(r_hub, hub_length)
    .hline_to(r_bore)
    .close()
    .to_face()
    .revolve("Z", 360);

// # Airfoils: a cambered section with NACA 4-digit thickness, drawn chordwise along u and
// thickwise along v, as a closed spline from the trailing edge round the leading edge. The
// surfaces stop short of the trailing edge, which the spline rounds off through one point on
// the camber line, so it never has to turn back sharply.
fn airfoil(chord, thickness, camber) {
    let n = 14;
    let x_end = 0.95;
    let upper = [];
    let lower = [];
    for i in 0..=n {
        let x = x_end * (1.0 - (i.to_float() / n.to_float() * PI()).cos()) / 2.0; // cosine spacing
        let t = 5.0 * thickness * (0.2969 * x.sqrt() - 0.126 * x - 0.3516 * x * x
            + 0.2843 * x * x * x - 0.1015 * x * x * x * x);
        let c = 4.0 * camber * x * (1.0 - x); // a parabolic camber line
        upper.push([x * chord, c + t * chord]);
        lower.push([x * chord, c - t * chord]);
    }
    // The trailing edge, then the upper surface to the leading edge and the lower one back,
    // without repeating the leading edge point.
    let pts = [[(x_end + 0.02) * chord, 4.0 * camber * x_end * (1.0 - x_end)]];
    for i in 0..n { pts.push(upper[n - i]); }
    for i in 0..=n { pts.push(lower[i]); }
    pts
}

// One section at radius r: the airfoil, centered on its mid-chord and turned by `stagger`
// from the axis, in the plane x = r (y tangential, z axial).
fn section(r, chord, thickness, camber, stagger, z_mid) {
    let a = stagger * PI() / 180.0;
    let pts = [];
    for p in airfoil(chord, thickness, camber * chord) {
        let u = p[0] - chord / 2.0;
        let v = p[1];
        pts.push([r, u * a.sin() + v * a.cos(), z_mid - u * a.cos() + v * a.sin()]);
    }
    spline(pts, true)
}

// Sections from inside the rim to the tip: the chord grows, the profile thins and the
// stagger turns from hub to tip, which gives the blade its twist.
let r_root = r_platform - 6.0;
let span = r_tip - r_root;
let root_chord = rim_width * 0.9 / hub_stagger.to_radians().cos();
let sections = [];
for k in 0..=5 {
    let f = k.to_float() / 5.0;
    let chord = root_chord * (1.0 + 0.15 * f);
    let thickness = 0.09 - 0.05 * f;
    let stagger = hub_stagger + (tip_stagger - hub_stagger) * f;
    sections.push(section(r_root + span * f, chord, thickness, camber, stagger, mid));
}
let blade = loft(sections, true);

// The blades never touch each other, so they go into the fuse as one compound: OpenCASCADE
// then only intersects each blade with the disk, not with its neighbours, which is several
// times faster than fuse_all.
let ring = [];
for i in 0..blades {
    ring.push(blade.rotate_z(i.to_float() * 360.0 / blades.to_float()));
}
disk + compound(ring)
