# Parts

2610 Rhai scripts for real-world parts, from bearings and bike cranks to lab glassware and
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
| [`antique_furniture_hardware`](antique_furniture_hardware) | 7 |
| [`appliance_spares`](appliance_spares) | 14 |
| [`aquarium_and_irrigation`](aquarium_and_irrigation) | 18 |
| [`archery`](archery) | 7 |
| [`assorted`](assorted) | 30 |
| [`astronomy`](astronomy) | 8 |
| [`automotive_and_bicycle`](automotive_and_bicycle) | 37 |
| [`awnings_and_tarps`](awnings_and_tarps) | 6 |
| [`baby_and_nursery`](baby_and_nursery) | 12 |
| [`baking`](baking) | 8 |
| [`bar_and_restaurant`](bar_and_restaurant) | 11 |
| [`bathroom_and_cleaning`](bathroom_and_cleaning) | 42 |
| [`bbq_and_grill`](bbq_and_grill) | 10 |
| [`bearings_and_linear_motion`](bearings_and_linear_motion) | 29 |
| [`beauty_and_grooming`](beauty_and_grooming) | 6 |
| [`bed_frame_hardware`](bed_frame_hardware) | 7 |
| [`beekeeping_and_fishing`](beekeeping_and_fishing) | 14 |
| [`bicycle_accessories`](bicycle_accessories) | 6 |
| [`blinds_and_curtains`](blinds_and_curtains) | 15 |
| [`books_and_reading`](books_and_reading) | 10 |
| [`calligraphy_and_pens`](calligraphy_and_pens) | 6 |
| [`camera_rigs_and_cinema`](camera_rigs_and_cinema) | 43 |
| [`camping_and_hiking`](camping_and_hiking) | 19 |
| [`car_interior`](car_interior) | 7 |
| [`caravan_and_motorhome`](caravan_and_motorhome) | 8 |
| [`chess_set`](chess_set) | 7 |
| [`classroom_and_science_kits`](classroom_and_science_kits) | 12 |
| [`climbing_and_rope_access`](climbing_and_rope_access) | 8 |
| [`clinic_and_ward_accessories`](clinic_and_ward_accessories) | 40 |
| [`clocks`](clocks) | 10 |
| [`coffee_and_tea`](coffee_and_tea) | 6 |
| [`commercial_kitchen_spares`](commercial_kitchen_spares) | 40 |
| [`computer_and_desk`](computer_and_desk) | 19 |
| [`construction`](construction) | 11 |
| [`cubesat_and_space`](cubesat_and_space) | 8 |
| [`desk_organisers`](desk_organisers) | 40 |
| [`din_rail_and_cabinet_hardware`](din_rail_and_cabinet_hardware) | 41 |
| [`drawing_and_drafting`](drawing_and_drafting) | 18 |
| [`drones_and_rc_2`](drones_and_rc_2) | 6 |
| [`ebike_and_scooter`](ebike_and_scooter) | 10 |
| [`electronics`](electronics) | 34 |
| [`electronics_bench`](electronics_bench) | 14 |
| [`equestrian_and_pets`](equestrian_and_pets) | 8 |
| [`eu_electrical_install`](eu_electrical_install) | 6 |
| [`ev_and_car_accessories`](ev_and_car_accessories) | 40 |
| [`farm_and_livestock`](farm_and_livestock) | 15 |
| [`fasteners`](fasteners) | 70 |
| [`fencing_and_sheds`](fencing_and_sheds) | 7 |
| [`fire_and_emergency`](fire_and_emergency) | 5 |
| [`flooring_and_tiling`](flooring_and_tiling) | 7 |
| [`furniture_and_home_hardware`](furniture_and_home_hardware) | 42 |
| [`furniture_repair`](furniture_repair) | 5 |
| [`garage_and_motorcycle`](garage_and_motorcycle) | 41 |
| [`garage_storage`](garage_storage) | 8 |
| [`garden_and_outdoor`](garden_and_outdoor) | 40 |
| [`gears_and_power_transmission`](gears_and_power_transmission) | 28 |
| [`general_aviation`](general_aviation) | 13 |
| [`geology_and_field_science`](geology_and_field_science) | 8 |
| [`golf`](golf) | 8 |
| [`greenhouse_and_growing`](greenhouse_and_growing) | 40 |
| [`guitar_hardware`](guitar_hardware) | 7 |
| [`ham_radio`](ham_radio) | 8 |
| [`hardware`](hardware) | 28 |
| [`hobby_electronics_enclosures`](hobby_electronics_enclosures) | 41 |
| [`home_brewing`](home_brewing) | 6 |
| [`home_decor`](home_decor) | 14 |
| [`household`](household) | 28 |
| [`hvac_ductwork_metric`](hvac_ductwork_metric) | 41 |
| [`hvac_electrical_and_solar`](hvac_electrical_and_solar) | 41 |
| [`industrial_automation`](industrial_automation) | 10 |
| [`industrial_safety_and_ppe`](industrial_safety_and_ppe) | 42 |
| [`jewellery_making_tools`](jewellery_making_tools) | 6 |
| [`jewellery_watches_and_fashion`](jewellery_watches_and_fashion) | 40 |
| [`joinery_and_woodwork`](joinery_and_woodwork) | 17 |
| [`kitchen`](kitchen) | 40 |
| [`kitchen_storage`](kitchen_storage) | 5 |
| [`lab_automation_and_printer_upgrades`](lab_automation_and_printer_upgrades) | 40 |
| [`lab_ware`](lab_ware) | 39 |
| [`leatherworking`](leatherworking) | 6 |
| [`lighting_fixtures`](lighting_fixtures) | 10 |
| [`locks_and_door_furniture`](locks_and_door_furniture) | 8 |
| [`machine_elements`](machine_elements) | 40 |
| [`marine_and_music`](marine_and_music) | 34 |
| [`mechanical_keyboards`](mechanical_keyboards) | 8 |
| [`mechanisms`](mechanisms) | 18 |
| [`medical_and_bathroom`](medical_and_bathroom) | 40 |
| [`microscopy`](microscopy) | 7 |
| [`mobility_and_accessibility`](mobility_and_accessibility) | 40 |
| [`model_railway`](model_railway) | 16 |
| [`model_rocketry`](model_rocketry) | 13 |
| [`molecular_biology_lab`](molecular_biology_lab) | 7 |
| [`musical_instruments`](musical_instruments) | 18 |
| [`office_and_sports`](office_and_sports) | 24 |
| [`office_furniture`](office_furniture) | 10 |
| [`optics_and_photography`](optics_and_photography) | 40 |
| [`outdoor_furniture`](outdoor_furniture) | 6 |
| [`packaging_and_containers`](packaging_and_containers) | 40 |
| [`percussion`](percussion) | 8 |
| [`pets_audio_and_lighting`](pets_audio_and_lighting) | 15 |
| [`phone_and_tablet_accessories`](phone_and_tablet_accessories) | 9 |
| [`picture_framing`](picture_framing) | 7 |
| [`playground_equipment`](playground_equipment) | 7 |
| [`plumbing`](plumbing) | 26 |
| [`plumbing_and_heating_metric`](plumbing_and_heating_metric) | 41 |
| [`pneumatics_and_hydraulics`](pneumatics_and_hydraulics) | 18 |
| [`pool_spa_and_billiards`](pool_spa_and_billiards) | 10 |
| [`pottery_tools`](pottery_tools) | 6 |
| [`printmaking_and_bookbinding`](printmaking_and_bookbinding) | 8 |
| [`racket_sports`](racket_sports) | 7 |
| [`railings_and_stairs`](railings_and_stairs) | 6 |
| [`raised_beds_and_compost`](raised_beds_and_compost) | 6 |
| [`rc_boats`](rc_boats) | 7 |
| [`retail_and_signage`](retail_and_signage) | 14 |
| [`robotics_and_makers`](robotics_and_makers) | 40 |
| [`sailing_dinghy_fittings`](sailing_dinghy_fittings) | 6 |
| [`server_rack_and_networking`](server_rack_and_networking) | 7 |
| [`sewing_and_crafts`](sewing_and_crafts) | 20 |
| [`shipping_and_logistics`](shipping_and_logistics) | 6 |
| [`skate_and_surf`](skate_and_surf) | 8 |
| [`smart_home`](smart_home) | 7 |
| [`sports_and_fitness`](sports_and_fitness) | 40 |
| [`stoves_and_sauna`](stoves_and_sauna) | 8 |
| [`studio_audio_hardware`](studio_audio_hardware) | 8 |
| [`surveying_and_layout`](surveying_and_layout) | 6 |
| [`swimming_and_diving`](swimming_and_diving) | 6 |
| [`tabletop_gaming`](tabletop_gaming) | 8 |
| [`theatre_film_and_av`](theatre_film_and_av) | 40 |
| [`tool_organisers`](tool_organisers) | 7 |
| [`tools`](tools) | 40 |
| [`toys_and_games`](toys_and_games) | 39 |
| [`tractor_and_mower_spares`](tractor_and_mower_spares) | 6 |
| [`trailers_and_towing`](trailers_and_towing) | 7 |
| [`tripod_accessories`](tripod_accessories) | 5 |
| [`vacuum_cleaner_spares`](vacuum_cleaner_spares) | 5 |
| [`wall_and_ceiling_fixings`](wall_and_ceiling_fixings) | 7 |
| [`watersports`](watersports) | 9 |
| [`weaving_and_spinning`](weaving_and_spinning) | 6 |
| [`wildlife`](wildlife) | 5 |
| [`window_hardware`](window_hardware) | 6 |
| [`winemaking_and_cellar`](winemaking_and_cellar) | 8 |
| [`wooden_train_set`](wooden_train_set) | 7 |
| [`workshop_jigs`](workshop_jigs) | 40 |

## Status on main

The first 779 parts were made with the fixes in #61 to #75, and with them every one validated,
rendered and saved without warnings, except `assorted/flex_coupler`, which is measured
approximately and says so. On main at 508fa1a, 748 of those 779 build cleanly. The other 31 hit
the bugs those PRs fix:

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

Parts added after that were made on main itself, working around its bugs the way an agent would
have to, and build there without warnings. The bugs they ran into are filed from #76 on.
