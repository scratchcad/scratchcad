// Chain ends holder for joining a chain: 70 mm long 6 mm wide steel strip 3 mm thick with a downturned hook at each end, 10 mm overall height, 3 mm wide hook gaps that catch a roller of each chain end
let length = 70.0; // [50.0, 110.0] Holder length (mm)
let width = 6.0; // [4.0, 10.0] Strip width (mm)
let thickness = 3.0; // [2.0, 4.0] Strip thickness (mm)
const height = 10.0;
const hook = 3.0;
let top = height - thickness;
let profile = polygon([
    [0, 0, height], [0, 0, 0], [2.0 * hook, 0, 0], [2.0 * hook, 0, hook], [hook, 0, hook], [hook, 0, top],
    [length - hook, 0, top], [length - hook, 0, hook], [length - 2.0 * hook, 0, hook], [length - 2.0 * hook, 0, 0],
    [length, 0, 0], [length, 0, height]
]);
profile.to_face().extrude([0, width, 0])
