part of 'recommendations_bloc.dart';

abstract class RecommendationsEvent extends Equatable {
  const RecommendationsEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendations extends RecommendationsEvent {}

class RequestRecommendations extends RecommendationsEvent {
  final Release release;
  const RequestRecommendations(this.release);
}
