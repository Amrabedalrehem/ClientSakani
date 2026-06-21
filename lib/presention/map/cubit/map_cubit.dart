import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/core/const/HomeConst.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(const MapState());

  void selectProperty(PropertyModel? property) {
    if (property == null) {
      emit(state.copyWith(clearSelected: true));
    } else {
      emit(state.copyWith(selectedProperty: property));
    }
  }

  void toggleSavedOnly() {
    emit(state.copyWith(
      showSavedOnly: !state.showSavedOnly,
      clearSelected: true,
    ));
  }
}
