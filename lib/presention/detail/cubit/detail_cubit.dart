import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';
import 'package:flutter_application_1/data/repo/SavedRepository.dart';
import 'package:flutter_application_1/presention/home/component/ConfirmUnsaveDialog.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final SavedRepository _repo;

  DetailCubit({SavedRepository? repo})
      : _repo = repo ?? SavedRepository(),
        super(DetailLoading());

  Future<void> fetchDetails(PropertyModel initial) async {
    emit(DetailLoading());
    try {
      final details = await _repo.getApartmentById(int.parse(initial.id));
      final property = details ?? initial;
      emit(DetailLoaded(
        property: property,
        isSaved: _repo.isSaved(property.id),
      ));
    } catch (e) {
      emit(DetailLoaded(
        property: initial,
        isSaved: _repo.isSaved(initial.id),
      ));
    }
  }

  Future<void> toggleSave(BuildContext context) async {
    final current = state;
    if (current is! DetailLoaded) return;

    if (current.isSaved) {
      final confirm = await showConfirmUnsaveDialog(context);
      if (confirm != true) return;
    }

    await _repo.toggleSaved(current.property.id);
    emit(current.copyWith(isSaved: _repo.isSaved(current.property.id)));
  }
}
