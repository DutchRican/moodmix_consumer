part of 'recommendations_bloc.dart';

abstract class RecommendationsEvent extends Equatable {
  const RecommendationsEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendations extends RecommendationsEvent {
  final String id;
  const GetRecommendations(this.id);
}

class RequestRecommendations extends RecommendationsEvent {
  final Release release;
  const RequestRecommendations(this.release);
}

class ClearRecommendations extends RecommendationsEvent {}
