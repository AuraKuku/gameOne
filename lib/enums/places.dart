/// Enum representing different place names
enum PlaceName {
  defaultPlace('default'),
  office('office'),
  toilet('toilet'),
  city('city'),
  home('home'),
  park('park'),
  shop('shop');

  const PlaceName(this.value);
  final String value;

  static PlaceName fromString(String value) {
    return PlaceName.values.firstWhere(
      (place) => place.value == value,
      orElse: () => PlaceName.defaultPlace,
    );
  }
}