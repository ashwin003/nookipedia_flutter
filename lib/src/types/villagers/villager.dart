import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'gender.dart';
import 'hobby.dart';
import 'personality.dart';
import 'species.dart';
import 'zodiac.dart';

part 'villager.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Villager extends Equatable {
  /// Name of the villager.
  final String name;

  /// Link to the respective Nookipedia article.
  final String url;

  /// A previous name for the villager. A very small number of villagers changed names between earlier games, such as Sally being known as Hazel in the original game.
  @JsonKey(includeIfNull: true, defaultValue: "")
  final String? altName;

  /// The HTML color code of the background of the villager's name badge that appears above their dialogue box when spoken to in-game.
  /// Note that to date, only New Horizons villagers have this field populated. This field may be useful for styling, such as the accent color for a Discord embed.
  final String titleColor;

  /// The HTML color code of the text of the villager's name badge that appears above their dialogue box when spoken to in-game.
  /// Note that to date, only New Horizons villagers have this field populated.
  final String textColor;

  /// The game's internal identifier for the villager.
  /// Not all villagers have IDs; villagers who appeared in any game including or after Wild World have a consistent ID between games.
  final String id;

  /// Image of the villager from the latest game the villager appeared in. dodo.ac is Nookipedia's CDN server.
  final String imageUrl;

  /// The villager's species.
  final Species species;

  /// The villager's personality.
  /// Note that there are no official in-game personality names; these are names that are commonly used by the community.
  /// In the case of 'sisterly', other common names include 'big sis' and 'uchi'
  final Personality personality;

  /// Gender of the villager. In Animal Crossing, only male and female are used.
  final Gender gender;

  /// Birthday month of the villager.
  /// Note that villager birthdays were not introduced until Wild World.
  /// For villagers who didn't appear in Wild World or any later games, this field will be an empty string.
  final String birthdayMonth;

  /// Birthday day of the villager.
  /// Note that villager birthdays were not introduced until Wild World.
  /// For villagers who didn't appear in Wild World or any later games, this field will be an empty string.
  final String birthdayDay;

  /// The villager's astrological star sign.
  final Zodiac sign;

  /// The villager's quote as it appears on the back of their in-game portrait item.
  /// This will be the quote from the latest game
  /// (i.e. if the villager had varying quotes between Wild World and New Horizons, this will be the New Horizons quote).
  /// For villagers from older games that do not have a quote, this field will be an empty string.
  final String quote;

  /// The villager's default phrase they use throughout conversation. This will be the phrase from the latest game
  /// (i.e. if the villager had varying phrases between Wild World and New Horizons, this will be the New Horizons quote).
  final String phrase;

  /// The villager's default clothing. This will be the clothing from the latest game
  /// (i.e. if the villager had varying phrases between Wild World and New Horizons, this will be the New Horizons clothing).
  final String clothing;

  /// Whether the villager was an island in Animal Crossing for GameCube. Only a small number of villagers (36) were islanders.
  final bool islander;

  /// The first Animal Crossing game the villager appeared in.
  /// `DNM` is Doubutsu no Mori for the Nintendo 64 (Japan-exclusive);
  /// `AC` is Animal Crossing for GameCube;
  /// `E_PLUS` is Doubutsu no Mori e+ for GameCube (expanded port of AC, Japan-exclusive);
  /// `WW` is Wild World for the DS;
  /// `CF` is City Folk for Wii;
  /// `NL` is New Leaf for 3DS;
  /// `WA` is Welcome amiibo, the New Leaf expansion;
  /// `NH` is New Horizons for Switch;
  /// `FILM` is the Doubutsu no Mori Japan-exclusive film;
  /// `HHD` is Happy Home Designer for the Wii; and
  /// `PC` is Pocket Camp for mobile.
  final String debut;

  /// Any phrases used in previous Animal Crossing installations. May be empty.
  final List<String> prevPhrases;

  /// An object that holds villager data specific to New Horizons. If the villager does not appear in New Horizons, this field will be set to null.
  @JsonKey(
    name: "nh_details",
    includeIfNull: false,
    required: false,
    defaultValue: null,
  )
  final NewHorizonDetails? newHorizonDetails;

  /// List of official media the villager appeared in.
  /// `DNM` is Doubutsu no Mori for the Nintendo 64 (Japan-exclusive);
  /// `AC` is Animal Crossing for GameCube;
  /// `E_PLUS` is Doubutsu no Mori e+ for GameCube (expanded port of AC, Japan-exclusive);
  /// `WW` is Wild World for the DS;
  /// `CF` is City Folk for Wii;
  /// `NL` is New Leaf for 3DS;
  /// `WA` is Welcome amiibo, the New Leaf expansion;
  /// `NH` is New Horizons for Switch;
  /// `FILM` is the Doubutsu no Mori Japan-exclusive film;
  /// `HHD` is Happy Home Designer for the Wii; and
  /// `PC` is Pocket Camp for mobile.
  final List<String> appearances;

  const Villager(
    this.name,
    this.url,
    this.altName,
    this.titleColor,
    this.textColor,
    this.id,
    this.imageUrl,
    this.species,
    this.personality,
    this.gender,
    this.birthdayMonth,
    this.birthdayDay,
    this.sign,
    this.quote,
    this.phrase,
    this.clothing,
    this.islander,
    this.debut,
    this.prevPhrases,
    this.newHorizonDetails,
    this.appearances,
  );

  factory Villager.fromJson(Map<String, dynamic> json) =>
      _$VillagerFromJson(json);

  Map<String, dynamic> toJson() => _$VillagerToJson(this);

  @override
  bool operator ==(Object other) => other is Villager && other.id == id;

  @override
  int get hashCode => id.hashCode;

  @override
  List<Object?> get props => [
        name,
        url,
        altName,
        titleColor,
        textColor,
        id,
        imageUrl,
        species,
        personality,
        gender,
        birthdayMonth,
        birthdayDay,
        sign,
        quote,
        phrase,
        clothing,
        islander,
        debut,
        prevPhrases,
        newHorizonDetails,
        appearances,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class NewHorizonDetails extends Equatable {
  final String imageUrl;
  final String photoUrl;
  final String iconUrl;
  final String quote;
  @JsonKey(name: "sub-personality")
  final String subPersonality;
  @JsonKey(name: "catchphrase")
  final String catchPhrase;
  final String clothing;
  final String clothingVariation;
  @JsonKey(name: "fav_styles")
  final List<String> favoriteStyles;
  @JsonKey(name: "fav_colors")
  final List<String> favoriteColors;
  final Hobby hobby;
  final String houseInteriorUrl;
  final String houseExteriorUrl;
  final String houseWallpaper;
  final String houseFlooring;
  final String houseMusic;
  final String houseMusicNote;

  const NewHorizonDetails(
    this.imageUrl,
    this.photoUrl,
    this.iconUrl,
    this.quote,
    this.subPersonality,
    this.catchPhrase,
    this.clothing,
    this.clothingVariation,
    this.favoriteStyles,
    this.favoriteColors,
    this.hobby,
    this.houseInteriorUrl,
    this.houseExteriorUrl,
    this.houseWallpaper,
    this.houseFlooring,
    this.houseMusic,
    this.houseMusicNote,
  );

  factory NewHorizonDetails.fromJson(Map<String, dynamic> json) =>
      _$NewHorizonDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$NewHorizonDetailsToJson(this);

  @override
  List<Object?> get props => [
        imageUrl,
        photoUrl,
        iconUrl,
        quote,
        subPersonality,
        catchPhrase,
        clothing,
        clothingVariation,
        favoriteStyles,
        favoriteColors,
        hobby,
        houseInteriorUrl,
        houseExteriorUrl,
        houseWallpaper,
        houseFlooring,
        houseMusic,
        houseMusicNote,
      ];
}
