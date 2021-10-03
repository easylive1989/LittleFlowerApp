enum GameVisibility {
  public,
  private,
}

extension GameVisibilityExtension on GameVisibility {
  bool isPublic() {
    return this == GameVisibility.public;
  }

  int toInt() {
    return GameVisibility.values.indexOf(this);
  }
}
