import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_am_abhishek/core/constants/constants.dart';
import 'package:i_am_abhishek/features/presentation/bloc/cubit/web_view_cubit.dart';

class MobileDefaultAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  const MobileDefaultAppbar({
    super.key,
    required this.opacity,
    required this.scrollController,
    required this.globalKey,
  });
  final double opacity;
  final ScrollController scrollController;
  final List<GlobalKey> globalKey;

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  MobileDefaultAppbarState createState() => MobileDefaultAppbarState();
}

class MobileDefaultAppbarState extends State<MobileDefaultAppbar> {
  double appBarHeight = 100;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      context.read<WebViewCubit>().onSliding(widget.scrollController.offset);
    });
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(() {
      context.read<WebViewCubit>().onSliding(widget.scrollController.offset);
    });
    widget.scrollController.dispose();
    super.dispose();
  }

  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebViewCubit, double>(
      builder: (context, height) {
        return AnimatedContainer(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          duration: Duration(seconds: 5),
          child: AppBar(
            elevation: 0,
            toolbarHeight: height,
            backgroundColor: widget.opacity == 0.5
                ? Colors.transparent
                : Colors.black.withValues(alpha: widget.opacity),
            title: Text(
              ConstValues.userName.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              PopupMenuButton<int>(
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                itemBuilder: (context) => List.generate(
                  ConstValues.appbarText.length,
                  (index) => PopupMenuItem(
                    value: index,
                    child: Text(ConstValues.appbarText[index][0]),
                  ),
                ),
                onSelected: (index) {
                  // Handle menu item selection
                  if (index == 0) {
                    scrollTo(widget.globalKey[0]);
                  } else if (index == 1) {
                    scrollTo(widget.globalKey[1]);
                  } else if (index == 2) {
                    scrollTo(widget.globalKey[2]);
                  } else if (index == 3) {
                    scrollTo(widget.globalKey[3]);
                  } else {
                    scrollTo(widget.globalKey[4]);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

void scrollTo(GlobalKey globalKey) {
  final context = globalKey.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
