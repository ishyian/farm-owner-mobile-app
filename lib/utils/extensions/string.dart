extension StringExtension on String {
  String capitalize() =>
      isNotEmpty ? this[0].toUpperCase() + substring(1) : this;

  String capitalizeEveryWord() =>
      toLowerCase().split(' ').map((word) => word.capitalize()).join(' ');
}
