void runInDebug(void action()) {
  assert(() {
    action();
    return true;
  }());
}
