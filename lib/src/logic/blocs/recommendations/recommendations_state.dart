part of 'recommendations_bloc.dart';

class RecommendationsState extends Equatable {
  final bool isChecking;
  final int count;
  final bool recommendationsRequested;
  final bool isLoading;
  final bool hasLoaded;
  final bool hasError;
  final String? message;
  final Recommendations? recommendations;
  const RecommendationsState(
      {this.count = 0,
      this.isChecking = false,
      this.hasError = false,
      this.hasLoaded = false,
      this.isLoading = false,
      this.message,
      this.recommendations,
      this.recommendationsRequested = false});

  @override
  List<Object?> get props => [count, isChecking];
}
