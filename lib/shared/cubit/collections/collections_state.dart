part of 'collections_cubit.dart';


sealed class CollectionsState {}

final class CollectionsInitial extends CollectionsState {}

class GetCollectionLoading extends CollectionsState {}

class GetCollectionSuccess extends CollectionsState {}

class GetCollectionError extends CollectionsState {
  final String errorMessage;

  GetCollectionError(this.errorMessage);
}
