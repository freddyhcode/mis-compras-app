part of 'router_provider.dart';

class RouterNotifier extends Notifier<RouterState> {
  final WrapperSecureStorage _storage = WrapperSecureStorageImpl();
  static const String _key = 'has_seen_tutorial';

  @override
  RouterState build() {
    _loadTutorialStatus();
    return const RouterState();
  }

  Future<void> _loadTutorialStatus() async {
    try {
      final hasSeen = await _storage.getKeyValue<bool>(_key);
      state = state.copyWith(
        hasSeenTutorial: hasSeen ?? false,
        isLoading: false,
      );
    } catch (_) {
      state = state.copyWith(hasSeenTutorial: false, isLoading: false);
    }
  }

  Future<void> markTutorialAsCompleted() async {
    await _storage.setKeyValue<bool>(_key, true);
    state = state.copyWith(hasSeenTutorial: true, isLoading: false);
  }

  Future<void> resetTutorial() async {
    await _storage.removeKey(_key);
    state = state.copyWith(hasSeenTutorial: false, isLoading: false);
  }
}
