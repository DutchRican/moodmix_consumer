part of 'recommendations_bloc.dart';

class RecommendationsState extends Equatable {
  bool isChecking;
  int count;
  bool recommendationsRequested;
  bool isLoading;
  bool hasLoaded;
  bool hasError;
  String? message;
  Recommendations? recommendations;
  RecommendationsState(
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
