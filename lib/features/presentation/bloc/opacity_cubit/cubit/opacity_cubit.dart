import 'package:flutter_bloc/flutter_bloc.dart';

class OpacityCubit extends Cubit<double> {
  OpacityCubit() : super(0.5);
  double opacity = 0.5;

  void offsetColor(double offset) {
    double newOpacity = (offset / 80).clamp(0.5, 1);

    if (newOpacity != 0) {
      emit(newOpacity);
    }
  }
}
