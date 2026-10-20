// Baby toy C-link: 45 x 30 mm oval C, 6 mm round section, 5 mm opening
let length = 45.0; // [30.0, 60.0] Link length (mm)
let width = 30.0; // [20.0, 34.0] Link width (mm)
let section = 6.0; // [4.0, 8.0] Section (mm)
let gap = 5.0; // [3.0, 8.0] Opening (mm)
let outer = box_centered(length, width, section).translate([0, 0, section / 2.0]);
let o = outer.fillet(width / 2.0 - 0.01, outer.edges("|Z"));
let inner = box_centered(length - 2.0 * section, width - 2.0 * section, section + 2.0).translate([0, 0, section / 2.0]);
let i = inner.fillet(width / 2.0 - section - 0.01, inner.edges("|Z"));
let c = o - i - box_centered(gap, section + 2.0, section + 2.0).translate([0, width / 2.0 - section / 2.0, section / 2.0]);
c.fillet(section / 2.0 - 0.5, c.edges("not |Z"))
