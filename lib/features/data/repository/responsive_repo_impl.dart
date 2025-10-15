import 'package:flutter/material.dart';
import 'package:i_am_abhishek/features/domain/repository/responsive_repo.dart';

class ResponsiveRepoImpl implements ResponsiveRepo {
  @override
  T getResponsiveValue<T>({
    required BuildContext context,
    required T mobile,
    required T web,
  }) {
    var width = MediaQuery.sizeOf(context).width;
    if (width >= 700) {
      return web;
    } else {
      return mobile;
    }
  }
}
