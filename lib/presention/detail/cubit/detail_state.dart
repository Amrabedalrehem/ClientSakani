part of 'detail_cubit.dart';

abstract class DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final PropertyModel property;
  final bool isSaved;

  DetailLoaded({required this.property, required this.isSaved});

  DetailLoaded copyWith({
    PropertyModel? property,
    bool? isSaved,
  }) {
    return DetailLoaded(
      property: property ?? this.property,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}

class DetailError extends DetailState {
  final String message;
  DetailError(this.message);
}
