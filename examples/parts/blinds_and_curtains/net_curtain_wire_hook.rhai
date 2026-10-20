// Net curtain wire screw eye: 3 mm thread 8 mm long, 8 mm eye 1.4 mm wire, 5 mm collar
let eye = 8.0; // [5.0, 12.0] Eye outside diameter (mm)
let wire = 1.4; // [1.0, 2.0] Eye wire (mm)
let stud = 8.0; // [5.0, 12.0] Stud length (mm)
let ring = cylinder([0, -wire / 2.0, stud + 1.0 + eye / 2.0], "Y", eye / 2.0, wire) - cylinder([0, -wire, stud + 1.0 + eye / 2.0], "Y", eye / 2.0 - wire, wire * 2.0);
let collar = cylinder([0, 0, stud - 0.01], "Z", 2.5, 1.5);
let s = cylinder([0, 0, 1.5], "Z", 1.5, stud - 1.49) + cone(0.3, 1.5, 1.51);
s + collar + ring
