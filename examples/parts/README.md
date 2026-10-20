# Parts

779 Rhai scripts for real-world parts, from bearings and bike cranks to lab glassware and
chess pieces. Each was written by hand by a Claude agent working through scratchcad's MCP
tools: the agent wrote the script, checked it with `validate_script` and `render_3d`, fixed its
own mistakes, and saved it with `save_script`, as it would for a user. Nothing here was produced
by a generator. They were made to exercise scratchcad end to end with the kind of work agents
do. The bugs they turned up are in the issue tracker, from #42 on.

The first line of each script is the prompt it was written for, with the part's real
dimensions (from standards and catalogues where there are some):

```rhai
// DIN 580 M10 lifting eye bolt
let ring_od = 45.0; // [30, 60] Ring outside diameter (mm)
```

The main dimensions are sliders in the editor. To open a part there, copy it into `./output`
(or ask the agent to save it there).

| folder | parts |
|---|---|
| [`3d_printer_parts`](3d_printer_parts) | 36 |
| [`aerospace_drones_and_rc`](aerospace_drones_and_rc) | 39 |
| [`assorted`](assorted) | 30 |
| [`automotive_and_bicycle`](automotive_and_bicycle) | 37 |
| [`bearings_and_linear_motion`](bearings_and_linear_motion) | 29 |
| [`electronics`](electronics) | 34 |
| [`fasteners`](fasteners) | 70 |
| [`furniture_and_home_hardware`](furniture_and_home_hardware) | 42 |
| [`garden_and_outdoor`](garden_and_outdoor) | 40 |
| [`gears_and_power_transmission`](gears_and_power_transmission) | 28 |
| [`hardware`](hardware) | 28 |
| [`household`](household) | 28 |
| [`kitchen`](kitchen) | 40 |
| [`lab_ware`](lab_ware) | 39 |
| [`machine_elements`](machine_elements) | 40 |
| [`marine_and_music`](marine_and_music) | 34 |
| [`medical_and_bathroom`](medical_and_bathroom) | 40 |
| [`optics_and_photography`](optics_and_photography) | 40 |
| [`plumbing`](plumbing) | 26 |
| [`tools`](tools) | 40 |
| [`toys_and_games`](toys_and_games) | 39 |

## Status on main

With the fixes in #61 to #75, every part validated, rendered and saved without warnings, except
`assorted/flex_coupler`, which is measured approximately and says so. On main at 508fa1a, 748 of
the 779 build cleanly. The other 31 hit the bugs those PRs fix:

| part | on main |
|---|---|
| [`assorted/eyebolt_m10`](assorted/eyebolt_m10.rhai) | reported invalid after measuring (#42, #43) |
| [`assorted/flex_coupler`](assorted/flex_coupler.rhai) | could not be measured (#44) |
| [`fasteners/iso1234_2x20_cotter`](fasteners/iso1234_2x20_cotter.rhai) | reported invalid after measuring (#42, #43) |
| [`hardware/hammond_1590b`](hardware/hammond_1590b.rhai) | shell failed (#51) |
| [`3d_printer_parts/spool_holder_hub`](3d_printer_parts/spool_holder_hub.rhai) | the shell returned a wrong solid, which the final common then emptied (#51) |
| [`electronics/servo_horn_cross`](electronics/servo_horn_cross.rhai) | reported invalid after measuring (#42, #43) |
| [`plumbing/gate_valve_wheel`](plumbing/gate_valve_wheel.rhai) | reported invalid after measuring (#42, #43) |
| [`aerospace_drones_and_rc/fpv_propeller_5x4_5`](aerospace_drones_and_rc/fpv_propeller_5x4_5.rhai) | loft failed (#50) |
| [`furniture_and_home_hardware/curtain_ring_eyelet`](furniture_and_home_hardware/curtain_ring_eyelet.rhai) | reported invalid after measuring (#42, #43) |
| [`furniture_and_home_hardware/towel_ring`](furniture_and_home_hardware/towel_ring.rhai) | reported invalid after measuring (#42, #43) |
| [`tools/brick_trowel`](tools/brick_trowel.rhai) | could not be measured (#44) |
| [`lab_ware/retort_ring_clamp`](lab_ware/retort_ring_clamp.rhai) | reported invalid after measuring (#42, #43) |
| [`toys_and_games/fidget_spinner_tri`](toys_and_games/fidget_spinner_tri.rhai) | fillet failed on seams (#55, #56) |
| [`toys_and_games/pea_whistle`](toys_and_games/pea_whistle.rhai) | reported invalid after measuring (#42, #43) |
| [`optics_and_photography/film_canister_35mm`](optics_and_photography/film_canister_35mm.rhai) | shell failed (#51) |
| [`kitchen/balloon_whisk_8wire`](kitchen/balloon_whisk_8wire.rhai) | reported invalid after measuring (#42, #43) |
| [`kitchen/citrus_reamer`](kitchen/citrus_reamer.rhai) | reported invalid after measuring (#42, #43) |
| [`kitchen/cookie_cutter_round_fluted_60`](kitchen/cookie_cutter_round_fluted_60.rhai) | could not be measured (#44) |
| [`kitchen/egg_cup`](kitchen/egg_cup.rhai) | reported invalid after measuring (#42, #43) |
| [`kitchen/pot_lid_knob`](kitchen/pot_lid_knob.rhai) | reported invalid after measuring (#42, #43) |
| [`kitchen/tea_infuser_ball_45`](kitchen/tea_infuser_ball_45.rhai) | reported invalid after measuring (#42, #43) |
| [`machine_elements/link_arm_100mm`](machine_elements/link_arm_100mm.rhai) | chamfer failed on seams (#55, #56) |
| [`fasteners/eye_bolt_din580_m10`](fasteners/eye_bolt_din580_m10.rhai) | reported invalid after measuring (#42, #43) |
| [`garden_and_outdoor/hummingbird_feeder_flower_port`](garden_and_outdoor/hummingbird_feeder_flower_port.rhai) | fillet failed on seams (#55, #56) |
| [`garden_and_outdoor/outdoor_tap_wheel_handle`](garden_and_outdoor/outdoor_tap_wheel_handle.rhai) | reported invalid after measuring (#42, #43) |
| [`garden_and_outdoor/tent_stake_y_beam_180`](garden_and_outdoor/tent_stake_y_beam_180.rhai) | fillet failed on seams (#55, #56) |
| [`garden_and_outdoor/tube_bird_feeder_250`](garden_and_outdoor/tube_bird_feeder_250.rhai) | reported invalid after measuring (#42, #43) |
| [`medical_and_bathroom/bath_plug_38mm`](medical_and_bathroom/bath_plug_38mm.rhai) | reported invalid after measuring (#42, #43) |
| [`medical_and_bathroom/button_hook_dressing_aid`](medical_and_bathroom/button_hook_dressing_aid.rhai) | could not be measured (#44) |
| [`marine_and_music/boat_propeller_3_blade`](marine_and_music/boat_propeller_3_blade.rhai) | loft failed (#50) |
| [`marine_and_music/d_shackle_8mm`](marine_and_music/d_shackle_8mm.rhai) | reported invalid after measuring (#42, #43) |
