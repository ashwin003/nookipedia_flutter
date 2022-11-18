/// Rarity of the [Critter]s.
enum Rarity {
  unspecified,
  unknown,
  common,
  veryCommon,
  uncommon,
  rare,
  veryRare,
}

/// @nodoc
const stringToRarityMap = {
  "": Rarity.unspecified,
  "Unknown": Rarity.unknown,
  "Common": Rarity.common,
  "Very common": Rarity.veryCommon,
  "Very Common": Rarity.veryCommon,
  "Uncommon": Rarity.uncommon,
  "Rare": Rarity.rare,
  "Very rare": Rarity.veryRare,
};
