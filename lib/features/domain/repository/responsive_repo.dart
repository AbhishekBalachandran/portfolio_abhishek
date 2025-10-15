import 'package:flutter/material.dart';

abstract class ResponsiveRepo {
  T getResponsiveValue<T>({
    required BuildContext context,
    required T mobile,
    required T web,
  });
}
