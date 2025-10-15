import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_am_abhishek/core/constants/constants.dart';
import 'package:i_am_abhishek/features/presentation/bloc/opacity_cubit/cubit/opacity_cubit.dart';
import 'package:i_am_abhishek/features/presentation/widgets/mobile_appbar.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  // double _opacity = 0.5;
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey passionKey = GlobalKey();
  final GlobalKey expKey = GlobalKey();
  final GlobalKey resumeKey = GlobalKey();
  final GlobalKey workKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  late Animation<Offset> _textSlideAnimation;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _imageSlideAnimation;
  String backgroundImage =
      'https://images.pexels.com/photos/1054218/pexels-photo-1054218.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _textSlideAnimation =
        Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: const Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
        );
    scrollController.addListener(() {
      double offset = scrollController.offset;
      final newImage = offset < 1000
          ? 'https://images.pexels.com/photos/1054218/pexels-photo-1054218.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
          : 'https://cdn.bhdw.net/im/coffee-laptop-phone-on-the-table-wallpaper-79508_w635.webp';

      if (newImage != backgroundImage) {
        setState(() {
          backgroundImage = newImage;
        });
      }
      context.read<OpacityCubit>().offsetColor(offset);
    });
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _imageSlideAnimation =
        Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: const Offset(0.0, 0.0),
        ).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
        );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _animationController.dispose();
    super.dispose();
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

  int demoIndex = -1;
  bool blingicon = false;
  List<bool> hoverStates = List.generate(6, (index) => false);
  List<bool> hoverProjectStates = List.generate(7, (index) => false);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              backgroundImage,
              key: ValueKey(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  height: 700,
                  width: double.infinity,
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SlideTransition(
                              position: _textSlideAnimation,
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: Text(
                                  "HI, I'M  ${ConstValues.userName.toUpperCase()}",
                                  style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            SlideTransition(
                              position: _imageSlideAnimation,
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: Text(
                                  'Flutter Developer'.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                        IconButton(
                          onPressed: () {
                            scrollTo(aboutKey);
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //about
                Container(
                  key: aboutKey,
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        SizedBox(height: 90),
                        headText('A Little Bit About Me'),
                        SizedBox(height: 16),
                        CircleAvatar(
                          radius: 82,
                          backgroundImage: AssetImage(
                            'assets/images/Profile.png',
                          ),
                        ),
                        SizedBox(height: 16),
                        subText(
                          context,
                          '''I am currently working as a Junior Flutter Developer at Reubro International, where I am responsible for developing and deploying applications. I specialize in building cross-platform mobile applications using Flutter, ensuring smooth performance and a great user experience. I am passionate about writing clean, maintainable code and continuously improving my skills. I enjoy working in collaborative environments where I can contribute to innovative solutions and grow as a developer.''',
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.40,
                          padding: EdgeInsets.all(12),
                          width: MediaQuery.sizeOf(context).width * 0.70,
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'TL;DR?  Self Proclamations:'.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 19,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 60),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    ConstValues.proclamations.length,
                                    (index) => SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                          0.16,
                                      width:
                                          MediaQuery.sizeOf(context).width *
                                          0.18,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,

                                        children: [
                                          ConstValues.proclamations[index][1],
                                          subText(
                                            context,
                                            ConstValues.proclamations[index][0],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                  ),
                ),

                //passion
                Container(
                  padding: EdgeInsets.all(8),
                  key: passionKey,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      SizedBox(height: 90),
                      headText('What i do'),
                      SizedBox(height: 20),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          3,
                          (index) => SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    5,
                                    63,
                                    110,
                                  ),
                                  radius: 57,
                                  child: IconButton(
                                    autofocus: false,
                                    padding: EdgeInsets.zero,
                                    icon: Icon(
                                      Icons.laptop,
                                      color: Colors.white,
                                      size: 43,
                                    ),
                                    color: Color.fromARGB(255, 2, 85, 153),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Development'.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 20),
                                subText(
                                  context,
                                  '''With a strong foundation in computer science, I'm passionate about web design and development, and interested in mobile app development. As I grow as a developer, I hope to write clean, readable code that can be used by others and leveraged to create beautiful software.''',
                                ),
                                SizedBox(height: 90),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //experiance
                Container(
                  padding: EdgeInsets.all(8),
                  key: expKey,

                  width: double.infinity,
                  color: const Color.fromARGB(255, 248, 248, 248),
                  child: Column(
                    children: [
                      SizedBox(height: 90),
                      headText('Experiance'),
                      SizedBox(height: 20),
                      subText(
                        context,
                        '''I've been doing Flutter development for about 1.5 years now, and I'm always eager to learn more in this fast paced industry.''',
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            width: width * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Text(
                                    "Some technologies I've worked with:"
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.2,
                                  child: GridView.count(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(0),
                                    crossAxisCount: 5,
                                    children: List.generate(6, (index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            hoverStates[index] =
                                                !hoverStates[index];
                                          });
                                        },
                                        onHover: (value) {
                                          setState(() {
                                            hoverStates[index] = value;
                                          });
                                        },
                                        child: AnimatedSwitcher(
                                          duration: Duration(milliseconds: 600),
                                          child: Image.asset(
                                            'assets/images/icons8-flutter-logo-96.png',
                                            key: ValueKey(
                                              'hover-$index-${hoverStates[index]}',
                                            ),
                                            color: hoverStates[index]
                                                ? null
                                                : Colors.grey,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: width * 0.6,
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Where I've Worked:".toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                    'assets/svgs/logo (2).svg',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(0), // Adjust if needed
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ), // Adjust blur strength
                    child: Container(
                      key: resumeKey,
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                      color: const Color.fromARGB(
                        80,
                        238,
                        238,
                        238,
                      ), // semi-transparent
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Check out my résumé!'.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 29,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          InkWell(
                            onHover: (value) {
                              setState(() {
                                blingicon = value;
                              });
                            },
                            onTap: () {
                              setState(() {
                                blingicon = !blingicon;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                                color: blingicon
                                    ? Colors.white24
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Grab A Copy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  key: workKey,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 90),
                      headText("What I've Done"),
                      SizedBox(height: 8),
                      subText(context, "more coming soon!"),
                      SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.46,
                        child: GridView.count(
                          childAspectRatio: 400 / 190,
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                            7,
                            (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onHover: (value) {
                                  setState(() {
                                    hoverProjectStates[index] = value;
                                  });
                                },
                                onTap: () {
                                  setState(() {
                                    hoverProjectStates[index] =
                                        !hoverProjectStates[index];
                                  });
                                  _showSlideDialog(
                                    context,
                                    "assets/images/Screenshot 2025-05-09 133340.png",
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/Screenshot 2025-05-09 133340.png',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 600),
                                      color: hoverProjectStates[index]
                                          ? const Color.fromARGB(95, 54, 54, 54)
                                          : Colors.transparent,
                                      child: Center(
                                        child: Icon(
                                          Icons.saved_search_rounded,
                                          color: hoverProjectStates[index]
                                              ? Colors.white
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                    hoverProjectStates[index]
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 20,
                                                color: const Color.fromARGB(
                                                  255,
                                                  3,
                                                  73,
                                                  129,
                                                ),
                                                child: Text(
                                                  'Project name',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'PlayfairDisplay',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  key: contactKey,
                  width: double.infinity,
                  height: 400,
                  color: Colors.grey.shade200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20,
                    children: [
                      FaIcon(FontAwesomeIcons.paperPlane, size: 43),
                      headText('Get In Touch!'),
                      subText(
                        context,
                        'Whether you have an idea for a project or just want to chat, feel free to shoot me an email!',
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),

                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 136, 42, 42),
                          ),
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Grab A Copy',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //appbar
          BlocBuilder<OpacityCubit, double>(
            builder: (context, opacity) {
              return Column(
                children: [
                  MobileDefaultAppbar(
                    globalKey: [
                      aboutKey,
                      passionKey,
                      expKey,
                      workKey,
                      contactKey,
                    ],
                    opacity: opacity,
                    scrollController: scrollController,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSlideDialog(BuildContext context, String imagePath) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'SlideDialog',
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return const SizedBox.shrink(); // Required but unused
      },
      transitionBuilder: (_, animation, __, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0, -1), // from top
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

        return SingleChildScrollView(
          child: SlideTransition(
            position: offsetAnimation,
            child: Center(
              child: Material(
                color: Colors.white,
                elevation: 10,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(7),
                        color: Colors.black45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            Text(
                              'Project name',
                              style: TextStyle(
                                fontFamily: 'PlayfairDisplay',
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              height: MediaQuery.sizeOf(context).width * 0.3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            subText(
                              context,
                              '''This site was my final project for 5D Foundations: Experience and Drawing. Dubbed "The Emotion Machine", the goal for the project was to use HTML and CSS to create a website which elicits an emotion from the user's interaction with it or engages its user with a particular sort of experience in mind.''',
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                CustomAnimatedButton(
                                  text: 'Android Link',
                                  onHover: (value) {},
                                ),
                                Text(
                                  'Or',
                                  style: TextStyle(
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                CustomAnimatedButton(text: 'iOS Link'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(height: 40, color: Colors.black45),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  SizedBox subText(BuildContext context, String text) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'PlayfairDisplay',
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Text headText(String text) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(fontWeight: FontWeight.w200, fontSize: 29),
    );
  }
}

class CustomAnimatedButton extends StatelessWidget {
  const CustomAnimatedButton({
    super.key,
    this.onTap,
    this.onHover,
    required this.text,
  });
  final void Function()? onTap;
  final void Function(bool)? onHover;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: onHover,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color.fromARGB(255, 0, 82, 150),
          ),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 16,
              color: const Color.fromARGB(255, 0, 82, 150),
            ),
          ),
        ),
      ),
    );
  }
}
