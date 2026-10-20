// Door viewer peephole for a 35-55 mm door: 14 mm barrel with a 28 mm front flange and recessed lens, separate 24 mm rear eyepiece sleeve
let door = 45.0; // [35.0, 55.0] Door thickness (mm)
let barrel = cylinder([0, 0, 0], "Y", 7.0, door - 10.0) + cylinder([0, -2.0, 0], "Y", 14.0, 2.0).fillet(1.0, "<Y") - cylinder([0, -1.0, 0], "Y", 6.2, door);
let lens = cylinder([0, -1.5, 0], "Y", 6.2, 3.0) - cylinder([0, -2.5, 0], "Y", 5.0, 1.5);
let rear = cylinder([0, door, 0], "Y", 12.0, 2.5) + cylinder([0, door - 25.0, 0], "Y", 6.0, 25.0) - cylinder([0, door - 26.0, 0], "Y", 4.5, 30.0);
compound([barrel + lens, rear])
