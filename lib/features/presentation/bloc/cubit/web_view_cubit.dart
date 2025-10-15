import 'package:flutter_bloc/flutter_bloc.dart';

class WebViewCubit extends Cubit<double> {
  WebViewCubit() : super(200);
  final double maxHeight = 100;
  final double minHeight = 56;
  void onSliding(double offset) {
    double newHeight = (maxHeight - offset).clamp(minHeight, maxHeight);
    emit(newHeight);
  }

  
}
