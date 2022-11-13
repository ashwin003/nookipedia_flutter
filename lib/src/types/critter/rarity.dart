enum Rarity {
  unspecified,
  unknown,
  common,
  uncommon,
  rare,
}

const stringToRarityMap = {
  "": Rarity.unspecified,
  "Unknown": Rarity.unknown,
  "Common": Rarity.common,
  "Uncommon": Rarity.uncommon,
  "Rare": Rarity.rare
};
