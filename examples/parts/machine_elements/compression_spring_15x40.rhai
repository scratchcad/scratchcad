// Helical compression spring: 1.5 mm music wire, 15 mm OD, 40 mm free length, 6 active coils, one closed turn and a ground flat at each end
let wire_diameter = 1.5; // [0.5, 4.0] Wire diameter (mm)
let outer_diameter = 15.0; // [5.0, 50.0] Outer diameter (mm)
let free_length = 40.0; // [10.0, 120.0] Free length (mm)
let active_coils = 6; // [2, 6] Active coils
const per_turn = 12;
let d = wire_diameter;
let rm = outer_diameter / 2.0 - d / 2.0;
let pitch = (free_length - 2.0 * d) / active_coils.to_float();
let turns = active_coils + 2;
let pts = [];
let n = turns * per_turn;
for i in 0..=n {
    let u = i.to_float() / per_turn.to_float();
    let z = if u < 1.0 { u * d } else if u < turns.to_float() - 1.0 { d + (u - 1.0) * pitch } else { free_length - (turns.to_float() - u) * d };
    let a = u * 2.0 * PI();
    pts.push([rm * a.cos(), rm * a.sin(), z]);
}
let path = spline(pts);
let start = path.start_point();
let profile = circle(start, path.tangent_at(0.0), d / 2.0);
let coil = profile.to_face().sweep(path);
coil & box_from_corners([-outer_diameter, -outer_diameter, 0.0], [outer_diameter, outer_diameter, free_length])
