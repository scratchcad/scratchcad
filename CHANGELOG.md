# Changelog

## [0.5.0](https://github.com/scratchcad/scratchcad/compare/v0.4.0...v0.5.0) (2026-10-23)


### Features

* **crates:** add ruled_loft, which joins sections with straight lines ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** index vectors like arrays ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** loft smoothly through sections without bulging past them, creasing or approximating ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))


### Bug Fixes

* **crates:** bounding boxes are tight on trimmed curved faces ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** extrude outlines drawn on a plane to its positive side ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** fail booleans that go wrong silently, at their line in the script ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** fail fillets and chamfers that return an invalid solid ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** fail fuses larger than their parts and cuts that remove more than their tool ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** fail sweeps that come out invalid ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** fillets and chamfers leave out seams and edges between faces that continue each other ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** let the shapes of a compound tool overlap ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** loft long runs of circles, and start circles where lofts through them won't twist ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** name the face a mesh failed on ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** offset open wires into slots, and fail offsets that cross themselves ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** shell rounded boxes, or fail clearly instead of returning the box unchanged ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** sweep with a pipe shell, which neither crashes on changing helices nor gaps at corners ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* fail instead of falling back or approximating ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* measure shapes on a copy, and fail rather than measure them approximately ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **server:** say when a mesh failed because the shape is invalid ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))


### Performance Improvements

* **crates:** fuse_all fuses every shape in one boolean operation ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))
* **crates:** measure rigid copies with the split of the shape they were copied from ([47fd327](https://github.com/scratchcad/scratchcad/commit/47fd327eb56df9aa5e47f4657a0333109192d849))

## [0.4.0](https://github.com/scratchcad/scratchcad/compare/v0.3.0...v0.4.0) (2026-10-19)


### ⚠ BREAKING CHANGES

* **mcp:** tools and editor for B-rep modelling
* **server:** replace Fidget with OpenCASCADE B-rep modelling

### Features

* exact mass properties, contributor guides and new example renders ([#41](https://github.com/scratchcad/scratchcad/issues/41)) ([508fa1a](https://github.com/scratchcad/scratchcad/commit/508fa1a643325b1e9a4362000cdeebebedbcfe7f))
* **mcp:** tools and editor for B-rep modelling ([ade897a](https://github.com/scratchcad/scratchcad/commit/ade897a98d3e8bd7afaff75d336c4fade28850e0))
* **server:** replace Fidget with OpenCASCADE B-rep modelling ([ade897a](https://github.com/scratchcad/scratchcad/commit/ade897a98d3e8bd7afaff75d336c4fade28850e0))


### Bug Fixes

* **deps:** bump the cargo-minor-patch group across 1 directory with 3 updates ([#35](https://github.com/scratchcad/scratchcad/issues/35)) ([795417f](https://github.com/scratchcad/scratchcad/commit/795417f51396188bd1cc84924f512c9c28d2dcb7))
* **deps:** bump the npm-minor-patch group in /mcp with 4 updates ([#34](https://github.com/scratchcad/scratchcad/issues/34)) ([e69880a](https://github.com/scratchcad/scratchcad/commit/e69880a9c8e36d8050cce2e9d7956709b064572f))
* **deps:** bump the npm-minor-patch group in /mcp with 5 updates ([#31](https://github.com/scratchcad/scratchcad/issues/31)) ([217452f](https://github.com/scratchcad/scratchcad/commit/217452f65feff543ff768e983baf9cb8cc485f48))
* **deps:** bump the npm-minor-patch group in /mcp with 6 updates ([#40](https://github.com/scratchcad/scratchcad/issues/40)) ([6ed6642](https://github.com/scratchcad/scratchcad/commit/6ed6642883c58bfbb8d9f2b93e184df081d481cb))
* **mcp:** stop scratchcad's job when the editor drops a preview ([#38](https://github.com/scratchcad/scratchcad/issues/38)) ([468aae2](https://github.com/scratchcad/scratchcad/commit/468aae201d8c686f4a152368a7a33971c0246887))

## [0.3.0](https://github.com/Zesuperaker/scratchcad/compare/v0.2.0...v0.3.0) (2026-10-07)


### Features

* **mcp:** default editor preview and export detail to 10 ([#27](https://github.com/Zesuperaker/scratchcad/issues/27)) ([aebb94b](https://github.com/Zesuperaker/scratchcad/commit/aebb94b1c54e8f9e5cba6be3a440120e3bf0ce91))
* **mcp:** port the MCP server to TypeScript with a built-in script editor ([#23](https://github.com/Zesuperaker/scratchcad/issues/23)) ([037590b](https://github.com/Zesuperaker/scratchcad/commit/037590bd58d180f393bddff2578e10417256de6f))

## [0.2.0](https://github.com/Zesuperaker/scratchcad/compare/v0.1.1...v0.2.0) (2026-10-04)


### Features

* add scratchcad .mcp.json and udpate readme ([80793a8](https://github.com/Zesuperaker/scratchcad/commit/80793a82123c8363b615e30d81fdc78e28253813))


### Bug Fixes

* **deps:** bump the uv-minor-patch group across 1 directory with 3 updates ([#22](https://github.com/Zesuperaker/scratchcad/issues/22)) ([9bf363a](https://github.com/Zesuperaker/scratchcad/commit/9bf363abc218bbea1e0bb185385d525f3e3009bc))

## Changelog
