// Spiky massage ball: 64 mm core with 60 blunt cone spikes 8 mm tall (80 mm over the tips), 6 mm spike bases, evenly spread on a Fibonacci spiral
let core_d = 64.0; // [50.0, 100.0] Core diameter (mm)
let spikes = 60; // [20, 120] Number of spikes
let spike_height = 8.0; // [4.0, 12.0] Spike height (mm)
let spike_base = 6.0; // [4.0, 10.0] Spike base diameter (mm)
let r = core_d / 2.0;
// core turned so its poles sit between spikes (a spike near the pole failed to fuse)
let parts = [sphere(r).rotate_x(90.0)];
let golden = PI() * (3.0 - sqrt(5.0));
for i in 0..spikes {
    let z = 1.0 - 2.0 * (i.to_float() + 0.5) / spikes.to_float();
    let rr = sqrt(1.0 - z * z);
    let th = golden * i.to_float();
    let d = [rr * th.cos(), rr * th.sin(), z];
    let base = [d[0] * (r - 2.0), d[1] * (r - 2.0), d[2] * (r - 2.0)];
    let spike = cone(spike_base / 2.0, 1.2, spike_height + 2.0);
    // orient the cone's Z axis along d: tilt about Y by the polar angle, then turn about Z
    let polar = z.acos() * 180.0 / PI();
    let az = th * 180.0 / PI();
    parts.push(spike.rotate_y(polar).rotate_z(az).translate(base));
}
fuse_all(parts)
