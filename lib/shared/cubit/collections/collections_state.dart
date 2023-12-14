part of 'collections_cubit.dart';

sealed class CollectionsState {}

final class CollectionsInitial extends CollectionsState {}

class GetCollectionLoading extends CollectionsState {}

class GetCollectionSuccess extends CollectionsState {}

class GetCollectionError extends CollectionsState {
  final String errorMessage;

  GetCollectionError(this.errorMessage);
}

class AddCollectionLoading extends CollectionsState {}

class AddCollectionSuccess extends CollectionsState {}

class AddCollectionError extends CollectionsState {
  final String errorMessage;

  AddCollectionError(this.errorMessage);
}

class DeleteCollectionLoading extends CollectionsState {}

class DeleteCollectionSuccess extends CollectionsState {}

class DeleteCollectionError extends CollectionsState {
  final String errorMessage;

  DeleteCollectionError(this.errorMessage);
}
