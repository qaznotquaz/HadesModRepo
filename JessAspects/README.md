# Jess' Aspects ★ WIP
*By [fallen_angel.js](https://twitch.tv/qaznotquaz "come watch me on twitch!"), aka `qaznotquaz#3300`*

## Abstract
I had some ideas for new aspects and wanted to implement them - both as a way to give my two cents to the community, and to get my feet wet with understanding how modding this game really works. Hopefully I'm not getting *too* in over my head!

## Requirements
- MagicGonads' [ModUtil](https://www.nexusmods.com/hades/mods/27)
- PonyWarrior's [Aspect Extender](https://www.nexusmods.com/hades/mods/115)
- My [MimicUtil](https://www.nexusmods.com/hades/mods/117/)

Install using [ModImporter](https://www.nexusmods.com/hades/mods/26).

As a note, all subcomponents rely on the included [JessAspectsCore](JessAspectsCore)

## Usage
***★ prototypes are functional! ★***

This mod can be used either as a whole, or as only the pieces you'd like. If you're not worried about only installing some aspects, then you can place the entire [JessAspects](../JessAspects) folder into your `Mods` folder and install it as-is!

If you only want to install particular submodules, you have a few options. For one, you can download the whole package and then comment out the undesired aspects' **Include** statements in the [`modfile.txt`](modfile.txt). For finer control, each module will have a `config.lua` file, and a `modfile.txt`.

Alternatively, you can opt to only download the submodules you would like to use, since each one can function as a self-contained mod. You will need to make sure to install the [JessAspectsCore](JessAspectsCore) if you do this.

## Aspects
- **Functional New Content**
  - [Adamant Rail ★ Annie Oakley](JessNewAspects/LittleSureshot) *(prototype)*
  - [Adamant Rail ★ Aspect of Jess](JessNewAspects/MagicBombs) *(prototype)*
- **Functional Miscellaneous Content**
  - [Stygian Blade ★ Poseidon's Flourish](BoonsAsAspects)
  - [Eternal Spear ★ Hades' Call](BoonsAsAspects) *(known bugs)*
  - [Shield of Chaos ★ Chaos' Favor](BoonsAsAspects)
  - [Heart-Seeking Bow ★ Artemis' Cast](BoonsAsAspects)
  - [Twin Fists ★ Demeter's Strike](BoonsAsAspects)
  - [Adamant Rail ★ Hermes' Evasion](BoonsAsAspects)
- **Unimplemented New Ideas**
  - [Heart-Seeking Bow ★ Robin Hood](JessNewAspects/Philanthropist) *(conceptualized)*
  - [Heart-Seeking Bow ★ Cleopatra](JessNewAspects/temp_Cleopatra)
  - [Twin Fists ★ Mike Tyson](JessNewAspects/temp_MikeTyson)
  - [Eternal Spear ★ Merlin](JessNewAspects/temp_Merlin)
- **Unimplemented Miscellaneous Ideas**
  - [swap spear/shield charge attack with their special](MiscConcepts/InverseAttacks)
  - [can i make a sword that looks like fists?](MiscConcepts/InaccurateGraphics)
  - what about an aspect (or perhaps an entirely new weapon) that lets you "play as" some enemy, NPC, or boss?

## General TODO
- [x] Write the README
- [ ] Look for QA and balance testers
  - [ ] create a google form for polling interest

## Credits for mods heavily referenced:
- [PonyWarrior's **AspectFusion**](https://github.com/PonyWarrior/HadesModRepo/tree/master/AspectFusion)
- [raisins' **Swarm Missiles**](https://www.nexusmods.com/hades/mods/92)
<!--
Commented out since I haven't used this /yet/, but leaving it here because I suspect I /will/.
[Shy's Aspects Rework](https://www.nexusmods.com/hades/mods/65)
-->
