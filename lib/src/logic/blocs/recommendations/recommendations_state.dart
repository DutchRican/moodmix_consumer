part of 'recommendations_bloc.dart';

abstract class RecommendationsState extends Equatable {
  const RecommendationsState();

  @override
  List<Object?> get props => [];
}

class RecommendationsInitial extends RecommendationsState {}

class RecommendationsLoading extends RecommendationsState {}

class RecommendationsLoaded extends RecommendationsState {
  final Recommendations recommendations;
  const RecommendationsLoaded(this.recommendations);
}

class RecommendationsError extends RecommendationsState {
  final String? message;
  const RecommendationsError(this.message);
}
