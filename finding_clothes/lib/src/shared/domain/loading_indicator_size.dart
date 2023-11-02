enum LoadingIndicatorSize {
  small,
  standart,
  large;

  double get diameter => switch(this) {
    LoadingIndicatorSize.small => 10,
    LoadingIndicatorSize.standart => 20,
    LoadingIndicatorSize.large => 40
  };

  double get circularIndicatorStrokeWidth => switch(this) {
    LoadingIndicatorSize.small => 1,
    LoadingIndicatorSize.standart => 2,
    LoadingIndicatorSize.large => 4
  };
}