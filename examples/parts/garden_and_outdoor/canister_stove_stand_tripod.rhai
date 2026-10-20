// Fuel canister stand for 230 g screw-top canisters: 92 mm clip-on ring 6 mm tall, three 110 mm legs 3 mm thick tapering to rounded feet
let canister_diameter = 90.0; // [60.0, 110.0] Canister base diameter (mm)
let leg_length = 110.0; // [60.0, 160.0] Leg reach from the ring (mm)
let leg_width = 16.0; // [10.0, 24.0] Leg width at the ring (mm)
let thickness = 3.0; // [2.0, 5.0] Thickness (mm)
let legs = 3; // [3, 4] Number of legs
let ri = canister_diameter / 2.0 + 0.5;
let ro = ri + 2.0;
let ring = cylinder(ro, 6.0) - cylinder([0, 0, -1.0], "Z", ri, 8.0);
let lip = cylinder(ri + 0.1, 1.2) - cylinder([0, 0, -1.0], "Z", ri - 2.0, 3.2);
let leg = polygon([[ri - 1.0, -leg_width / 2.0], [ro + leg_length, -4.0], [ro + leg_length, 4.0], [ri - 1.0, leg_width / 2.0]]).to_face().extrude(thickness);
leg = leg + cylinder([ro + leg_length, 0, 0], "Z", 6.0, thickness);
leg = leg - cylinder([ro + leg_length, 0, -1.0], "Z", 2.0, thickness + 2.0);
let parts = [ring, lip];
for i in 0..legs {
    parts.push(leg.rotate_z(i.to_float() * 360.0 / legs.to_float()));
}
fuse_all(parts)
