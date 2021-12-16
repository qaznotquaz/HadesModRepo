# All Weapons ★ Boons as Aspects.

Did you know that weapon aspects are traits, and are thus in the same category as boons (and much more)? Well, this submodule adds an 'aspect' to each weapon which, instead of functioning differently as a weapon, bestows you with a boon!

Each and every one of these aspects is expanded from its normal form, too - they have five levels of rarity instead of three or four, and they can also _all_ be boosted by pomegranates.

## Aspects
- [x] Stygian Blade ★ Poseidon's Flourish
- [ ] Eternal Spear ★ Hades' Call
- [x] Shield of Chaos ★ Chaos' Favor
- [x] Heart-Seeking Bow ★ Artemis' Cast
- [x] Twin Fists ★ Demeter's Strike
- [x] Adamant Rail ★ Hermes' Evasion

### TODO
- [x] A variety of boons, one for each weapon.
- [x] Writing dramatic README stuff
- [x] fix weapon animations to be more apt (chaos aspect visuals for chaos' favor shield, etc)
- [ ] Debugging
  - [x] Rarity progression doesn't really expect 5 levels
    - [x] Which boons expect what?
    - [x] Do you want to make them go to 5 levels, or reduce the levels available to upgrade?
    - [ ] I think it would work best to make duplicate versions of the aspects that can be edited. they will go up to Legendary.
      - completion: 5/6
  - [x] Traits don't expect to need text to display on the weapon aspect selection/upgrade screen. Implement that text.
    - completion: 5/6
  - [x] ~~I think Artemis steals your ability to cast if she gets annoyed with you.~~ must've been a bug with using the original boon instead of my modified one
  - [ ] equipping artemis' bow and then unequipping it leaves you with the boosted cast until you leave the room. this isn't actually an issue since it clears on entering a run, but why's this happen?
    - this may also cause issues if anyone tries this with the dual-wielding mod, but i don't know
  - [ ] I wonder what happens if you equip Hades' keepsake while also having the call?