/// Stores a deep link path that arrived before authentication completed.
/// AuthGate reads and clears this after a successful login + data load.
class PendingDeepLink {
  PendingDeepLink._();

  static String? _path;

  static void set(String path) => _path = path;

  /// Returns the pending path and clears it so it is only consumed once.
  static String? consume() {
    final path = _path;
    _path = null;
    return path;
  }
}
