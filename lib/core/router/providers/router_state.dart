part of 'router_provider.dart';

class RouterState {
  const RouterState({this.hasSeenTutorial = false, this.isLoading = true});

  final bool hasSeenTutorial;
  final bool isLoading;

  RouterState copyWith({bool? hasSeenTutorial, bool? isLoading}) {
    return RouterState(
      hasSeenTutorial: hasSeenTutorial ?? this.hasSeenTutorial,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
