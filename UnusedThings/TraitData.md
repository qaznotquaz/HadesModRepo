# Unused Traits

*from TraitData.lua, sorted by appearance in the file.*

---

## WrathDamageBuffTrait
#### Helptext
> n/a

#### Notes
> this trait has a unique `DamagePerSuperStock` field, which provides a percent bonus to damage output based on how full your God Gauge is.

#### Other
* **Source:** Zeus, presumably
* **Icon:** [Zeus_08](BoonIcons/Zeus_08_Large.png)
* **Functional:** presumably
* **Misc:** this boon icon  not used in the game normally, but is also used by the unused `AmmoFieldTrait`.

## RetainTempHealthTrait
#### Notes
> empty tier 1 trait, not referenced anywhere

## ShieldLoadAmmo_PoseidonRangedTrait
#### Helptext
> **Flood Flare**
> 
> Your **Cast** damages foes around you and knocks them away.
> 
> Blast Damage: **60**/**90**/**120**/**150**

#### Notes
> this may look a little familiar - that's because it is! getting poseidon's Flood Flare is totally natural in-game, but you're not actually getting this trait. instead, you're getting his normal `PoseidonRangedTrait`, which has a `TraitDependencyTextOverrides` field that changes the helptext when you have the Beowulf aspect!
> 
> in fact, it's even in the loot tables for poseidon - but, this trait a `Skip` field set to `true`. there's only one other trait with this field, but quite a few elements of removed early-access content have this value. this field is checked when the game determines the eligibility of a proposed gamestate.

#### Other
* **Source:** Poseidon
* **Icon:** [Poseidon_02](BoonIcons/Poseidon_02_Large.png)
* **Functional:** presumably
* **Misc:** `ShieldLoadAmmo_DionysusRangedTrait` is also like this

## SlamStunTrait
#### Helptext
> n/a

#### My Two Cents
> like the actually-used Breaking Waves boon (aka `SlamExplosionTrait`), this has the field `AddOnSlamWeapons = {"PoseidonCollisionBlast"}`. it differs by adding **3**/**4.5**/**6**/**7.5** second stun instead of an explosion, which feels kind of busted.

#### Other
* **Source:** Poseidon, presumably
* **Icon:** [Poseidon_08](BoonIcons/Poseidon_08_Large.png)
* **Functional:** presumably

## OnEnemyDeathDefenseBuffTrait
#### Helptext
> n/a

#### My Two Cents
> this trait gives zag a **30%** damage reduction buff for **5** seconds every time an enemy dies. i can see why it was removed

#### Other
* **Source:** Poseidon, presumably
* **Icon:** n/a
* **Functional:** unlikely, missing `RarityLevels` and `Icon`.

## ReducedEnemySpawnsTrait
#### Helptext
> n/a

#### My Two Cents
> provides a `SpawnMultiplier` of **0.8**/**1.2**/**1.6**/**2.0**, reducing enemy spawns by **20%** at common rarity, but boosting them by **20%**/**60%**/**100%** at higher rarities. i assume this would've been fixed if the trait were properly implemented.

#### Other
* **Source:** unclear.
* **Icon:** n/a
* **Functional:** unlikely, missing `Icon`.
* **Trivia:**

## HealthBonusTrait
#### Helptext
> n/a

#### My Two Cents
> provides a `MaxHealth` bonus of **20**/**30**/**40**/**50**.

#### Other
* **Source:** unclear.
* **Icon:** n/a
* **Functional:** unlikely, missing `Icon`
* **Trivia:** i almost skipped this thinking it was `Tough Skin`, or perhaps `Spiked Collar`, until i checked and realized it's not referenced anywhere else.

## CriticalStunTrait
#### Helptext
> n/a

#### My Two Cents
> provides a **1**/**1.5**/**2.5**/**2.7** second stun on critting an enemy.

#### Other
* **Source:** Artemis, presumably
* **Icon:** [Artemis_05](BoonIcons/Artemis_05_Large.png)
* **Functional:** presumably

## ArtemisShoutBuffTrait
#### Helptext
> n/a

#### My Two Cents
> boosts artemis' call to have a bonus **3%**/**4.5%**/**6%**/**7.5%** critical chance. this one seems pretty cool, i wonder why it was cut?

#### Other
* **Source:** Artemis, presumably
* **Icon:** [Artemis_04](BoonIcons/Artemis_04_Large.png)
* **Functional:** could be, unless the `0` duration on the effect means it never goes off.

## MarkedDropGoldTrait
#### Helptext
> **Wanted Dead**
> 
> You earn **Coin** for the first **Marked** foe you slay in each **Encounter**.
> 
> **Marked** Kill Reward: **20**/**30**/**40**/**50**

#### My Two Cents
> this is so cool. it's even commented out in the `LinkedUpgrades` part of her lootdata! shame it was cut, i'll bet the bonus gold was just too much.

#### Other
* **Source:** Artemis, presumably
* **Icon:** [Artemis_06](BoonIcons/Artemis_06_Large.png)
* **Functional:** presumably

<!--
## Template
#### Helptext
>

#### My Two Cents
>

#### Other
* **Source:**
* **Icon:** [](BoonIcons/.png)
* **Functional:**
* **Trivia:**
-->
