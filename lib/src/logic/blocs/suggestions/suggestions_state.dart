part of 'suggestions_bloc.dart';

abstract class SuggestionsState extends Equatable {
  const SuggestionsState();

  @override
  List<Object?> get props => [];
}

class SuggestionsInitial extends SuggestionsState {}

class SuggestionsLoading extends SuggestionsState {}

class SuggestionsLoaded extends SuggestionsState {
  final List<Release> releases;
  const SuggestionsLoaded(this.releases);
}

class SuggestionsError extends SuggestionsState {
  final String? message;
  const SuggestionsError(this.message);
}
