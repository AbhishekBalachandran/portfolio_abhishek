import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_abhishek/config/theme/app_theme.dart';
import 'package:i_am_abhishek/features/presentation/bloc/cubit/web_view_cubit.dart';
import 'package:i_am_abhishek/features/presentation/bloc/opacity_cubit/cubit/opacity_cubit.dart';
import 'package:i_am_abhishek/features/presentation/pages/web_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WebViewCubit()),
        BlocProvider(create: (context) => OpacityCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: LayoutBuilder(
          builder: (context, constant) {
            return WebView();
          },
        ),
      ),
    );
  }
}
