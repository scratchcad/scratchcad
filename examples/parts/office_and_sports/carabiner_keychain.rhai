// Keychain carabiner (non-climbing): D shape 60 x 32 mm of 5 mm wire, with a straight gate 30 mm long on a 1 mm hinge gap
let len = 60.0; // [40.0, 80.0] Length (mm)
const rod = 2.5;
let path = polyline([[0, 0, 0], [len - 16.0, 0, 0], [len, 0, 10.0], [len, 0, 22.0], [len - 16.0, 0, 32.0], [10.0, 0, 32.0], [0, 0, 22.0], [0, 0, 6.0]]);
let frame = circle([0, 0, 0], [1, 0, 0], rod).to_face().sweep(path);
let gate = cylinder([1.0, 0, 6.5], "Z", 1.8, 14.0);
compound([frame, gate])
