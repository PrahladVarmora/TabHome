extension Interpolate on String {
  String interpolate(List<String> params) {
    String result = this;
    for (int i = 1; i < params.length + 1; i++) {
      result = result.replaceFirst('{#}', params[i - 1]);
    }
    return result;
  }
}
