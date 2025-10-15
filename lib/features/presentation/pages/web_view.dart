import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i_am_abhishek/core/constants/constants.dart';
import 'package:i_am_abhishek/features/data/repository/responsive_repo_impl.dart';
import 'package:i_am_abhishek/features/domain/repository/responsive_repo.dart';
import 'package:i_am_abhishek/features/presentation/bloc/opacity_cubit/cubit/opacity_cubit.dart';
import 'package:i_am_abhishek/features/presentation/pages/sections/social_media.dart';
import 'package:i_am_abhishek/features/presentation/widgets/default_appbar.dart';

import 'package:url_launcher/url_launcher.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  String backgroundImage =
      'https://images.pexels.com/photos/691668/pexels-photo-691668.jpeg';
  // double _opacity = 0.5;
  final GlobalKey startKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey passionKey = GlobalKey();
  final GlobalKey expKey = GlobalKey();
  final GlobalKey resumeKey = GlobalKey();
  final GlobalKey workKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  late Animation<Offset> _textSlideAnimation;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _fromDownSlideAnimation;

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
          ? 'https://images.pexels.com/photos/691668/pexels-photo-691668.jpeg'
          : 'https://images.pexels.com/photos/317356/pexels-photo-317356.jpeg';

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
    _fromDownSlideAnimation =
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

  int demoIndex = -1;
  bool blingicon = false;
  List<bool> hoverStates = List.generate(
    ConstValues().skills.length,
    (index) => false,
  );
  List<bool> hoverProjectStates = List.generate(
    ConstValues().projects.length,
    (index) => false,
  );
  bool getInTouchIcon = false;
  final ResponsiveRepo _responsiveRepo = ResponsiveRepoImpl();

  @override
  Widget build(BuildContext context) {
    var responseSize = _responsiveRepo.getResponsiveValue(
      context: context,
      mobile: false,
      web: true,
    );
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: FadeInImage(
              key: ValueKey(backgroundImage),
              placeholder: NetworkImage(backgroundImage),
              image: NetworkImage(backgroundImage),
              fadeInDuration: Duration(milliseconds: 300),
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              key: startKey,
              children: [
                GreetingSection(
                  textSlideAnimation: _textSlideAnimation,
                  fadeAnimation: _fadeAnimation,
                  fromDownSlideAnimation: _fromDownSlideAnimation,
                  aboutKey: aboutKey,
                ),

                //about
                if (_responsiveRepo.getResponsiveValue(
                  context: context,
                  mobile: false,
                  web: true,
                ))
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
                              'assets/images/Profile.JPG',
                            ),
                          ),
                          SizedBox(height: 16),
                          subText(
                            context,
                            text: ConstValues.aboutMeDescription,
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.39,
                            padding: EdgeInsets.all(12),
                            width: MediaQuery.sizeOf(context).width * 0.60,
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'TL;DR?  Self Proclamations:'.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 23,
                                    ),
                                  ),
                                  SizedBox(height: 60),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      ConstValues.proclamations.length,
                                      (index) => SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                            0.18,
                                        child: Column(
                                          spacing: 20,
                                          children: [
                                            ConstValues.proclamations[index][1],
                                            subText(
                                              context,
                                              text: ConstValues
                                                  .proclamations[index][0],
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
                  )
                else
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
                              'assets/images/Profile.JPG',
                            ),
                          ),
                          SizedBox(height: 16),
                          subText(
                            context,
                            text: ConstValues.aboutMeDescription,
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.40,
                            padding: EdgeInsets.all(12),
                            width: MediaQuery.sizeOf(context).width * 0.70,
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                              text: ConstValues
                                                  .proclamations[index][0],
                                              fontSize: 12,
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
                      responseSize
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                ConstValues().whatIDo.length,
                                (index) => SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.25,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            Icons.code_rounded,
                                            color: Colors.white,
                                            size: 43,
                                          ),
                                          color: Color.fromARGB(
                                            255,
                                            2,
                                            85,
                                            153,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        ConstValues().whatIDo[index][0]
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      subText(
                                        context,
                                        text: ConstValues().whatIDo[index][1],
                                      ),
                                      SizedBox(height: 90),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                ConstValues().whatIDo.length,
                                (index) => SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          color: Color.fromARGB(
                                            255,
                                            2,
                                            85,
                                            153,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        ConstValues().whatIDo[index][0],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      subText(
                                        context,
                                        fontSize: 12,
                                        text: ConstValues().whatIDo[index][1],
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

                //experience
                Container(
                  padding: EdgeInsets.all(8),
                  key: expKey,

                  width: double.infinity,
                  color: const Color.fromARGB(255, 248, 248, 248),
                  child: Column(
                    children: [
                      SizedBox(height: 90),
                      headText('Experience'),
                      SizedBox(height: 20),
                      subText(
                        context,
                        text:
                            '''I've been doing Flutter development for about 2 years now, and I'm always eager to learn more in this fast paced industry.''',
                      ),
                      SizedBox(height: 20),
                      responseSize
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            fontSize: 20,
                                          ),
                                          textAlign: responseSize
                                              ? TextAlign.left
                                              : TextAlign.center,
                                        ),
                                      ),
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          return SizedBox(
                                            height: responseSize
                                                ? MediaQuery.sizeOf(
                                                        context,
                                                      ).height *
                                                      0.6
                                                : MediaQuery.sizeOf(
                                                        context,
                                                      ).height *
                                                      0.2,
                                            child: GridView.count(
                                              mainAxisSpacing: 16,
                                              crossAxisSpacing: 16,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.all(0),
                                              crossAxisCount:
                                                  constraints.maxWidth >= 900
                                                  ? 5
                                                  : constraints.maxWidth >= 600
                                                  ? 4
                                                  : 3,
                                              children: List.generate(
                                                ConstValues().skills.length,
                                                (index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        hoverStates[index] =
                                                            !hoverStates[index];
                                                      });
                                                    },
                                                    onHover: (value) {
                                                      setState(() {
                                                        hoverStates[index] =
                                                            value;
                                                      });
                                                    },
                                                    child: AnimatedSwitcher(
                                                      duration: Duration(
                                                        milliseconds: 600,
                                                      ),
                                                      child: ColorFiltered(
                                                        colorFilter:
                                                            responseSize
                                                            ? hoverStates[index]
                                                                  ? ColorFilter.mode(
                                                                      Colors
                                                                          .transparent,
                                                                      BlendMode
                                                                          .multiply,
                                                                    )
                                                                  : _colorMatrix()
                                                            : ColorFilter.mode(
                                                                Colors
                                                                    .transparent,
                                                                BlendMode
                                                                    .multiply,
                                                              ),
                                                        child: AnimatedContainer(
                                                          duration: Duration(
                                                            milliseconds: 600,
                                                          ),
                                                          padding:
                                                              const EdgeInsets.all(
                                                                32.0,
                                                              ),
                                                          child: FadeInImage.assetNetwork(
                                                            width:
                                                                constraints
                                                                    .maxWidth *
                                                                0.8,
                                                            height:
                                                                constraints
                                                                    .maxHeight *
                                                                0.8,
                                                            placeholder:
                                                                ConstValues()
                                                                    .skills[index][2],
                                                            fit: BoxFit.contain,
                                                            image: ConstValues()
                                                                .skills[index][2],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: width * 0.2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Where I've Worked:".toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 20,
                                        ),
                                        textAlign: responseSize
                                            ? TextAlign.left
                                            : TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        child: Image.asset(
                                          'assets/images/opineinfotech_logo.jpeg',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            fontSize: 20,
                                          ),
                                          textAlign: responseSize
                                              ? TextAlign.left
                                              : TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        // height:
                                        //     MediaQuery.sizeOf(context).height *
                                        //     0.6,
                                        child: GridView.count(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.all(0),
                                          crossAxisCount: 2,
                                          shrinkWrap: true,
                                          children: List.generate(
                                            ConstValues().skills.length,
                                            (index) {
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
                                                  duration: Duration(
                                                    milliseconds: 600,
                                                  ),
                                                  child: ColorFiltered(
                                                    colorFilter: responseSize
                                                        ? hoverStates[index]
                                                              ? ColorFilter.mode(
                                                                  Colors
                                                                      .transparent,
                                                                  BlendMode
                                                                      .multiply,
                                                                )
                                                              : _colorMatrix()
                                                        : ColorFilter.mode(
                                                            Colors.transparent,
                                                            BlendMode.multiply,
                                                          ),
                                                    child: AnimatedContainer(
                                                      duration: Duration(
                                                        milliseconds: 600,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                            32.0,
                                                          ),
                                                      child: FadeInImage.assetNetwork(
                                                        width:
                                                            (MediaQuery.of(
                                                              context,
                                                            ).size.width *
                                                            0.9),
                                                        height:
                                                            (MediaQuery.of(
                                                                  context,
                                                                ).size.width *
                                                                0.9) *
                                                            9 /
                                                            16,
                                                        placeholder: ConstValues()
                                                            .skills[index][2],
                                                        fit: BoxFit.fitHeight,
                                                        image: ConstValues()
                                                            .skills[index][2],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: responseSize
                                      ? width * 0.2
                                      : width * 0.3,

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Where I've Worked:".toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 18,
                                        ),
                                        textAlign: responseSize
                                            ? TextAlign.left
                                            : TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        child: SvgPicture.asset(
                                          'assets/images/opineinfotech_logo.jpeg',
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

                //resume
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
                          SizedBox(height: 90),
                          Text(
                            'Check out my résumé!'.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 29,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onHover: (value) {
                              setState(() {
                                blingicon = value;
                              });
                            },
                            onTap: () async {
                              setState(() {
                                blingicon = !blingicon;
                              });

                              final Uri url = Uri.parse(
                                'https://drive.google.com/uc?export=view&id=${ConstValues.resumeFileId}',
                              );
                              try {
                                await launchUrl(url);
                              } catch (e) {
                                throw 'Error: $e';
                              }
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: responseSize
                                  ? blingicon
                                        ? width * 0.18
                                        : width * 0.16
                                  : width * 0.4,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                                color: blingicon
                                    ? Colors.white38
                                    : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  'Grab A Copy',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 90),
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
                      subText(context, text: "more coming soon!"),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(10),
                        // height: MediaQuery.sizeOf(context).height * 0.3,
                        child: GridView.count(
                          shrinkWrap: true,
                          childAspectRatio: 400 / 190,
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                            ConstValues().projects.length,
                            (index) => Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(1, 1),
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onHover: responseSize
                                    ? (value) {
                                        setState(() {
                                          hoverProjectStates[index] = value;
                                        });
                                      }
                                    : (value) {},
                                onTap: responseSize
                                    ? () {
                                        setState(() {
                                          hoverProjectStates[index] =
                                              !hoverProjectStates[index];
                                        });
                                        _showSlideDialog(
                                          context,
                                          ConstValues().projects[index][0],
                                          ConstValues().projects[index][1],
                                          ConstValues().projects[index][2],
                                        );
                                      }
                                    : () {
                                        _showSlideDialog(
                                          context,
                                          ConstValues().projects[index][0],
                                          ConstValues().projects[index][1],
                                          ConstValues().projects[index][2],
                                        );
                                      },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            ConstValues().projects[index][0],
                                          ),
                                          fit: BoxFit.fitWidth,
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
                                                height: 30,
                                                color: const Color.fromARGB(
                                                  255,
                                                  3,
                                                  73,
                                                  129,
                                                ),
                                                child: Text(
                                                  ConstValues()
                                                      .projects[index][1],
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'PlayfairDisplay',
                                                    fontSize: 16,
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
                //contact
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
                        text:
                            'Whether you have an idea for a project or just want to chat, feel free to shoot me an email!',
                      ),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            getInTouchIcon = value;
                          });
                        },
                        onTap: () {
                          setState(() {
                            getInTouchIcon = !getInTouchIcon;
                          });
                          _launchEmail('abhishekbambady2019@gmail.com');
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 600),
                          width: responseSize
                              ? blingicon
                                    ? width * 0.18
                                    : width * 0.16
                              : width * 0.3,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: getInTouchIcon
                                  ? const Color.fromARGB(255, 3, 76, 136)
                                  : Colors.black,
                            ),
                            color: !getInTouchIcon
                                ? Colors.transparent
                                : const Color.fromARGB(255, 3, 76, 136),
                          ),
                          child: Center(
                            child: Text(
                              'Say Hello',
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 20,
                                color: !getInTouchIcon
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //social media
                SocialMediaSection(
                  onTapRocket: () {
                    _scrollTo(startKey);
                  },
                ),
              ],
            ),
          ),

          //appbar
          BlocBuilder<OpacityCubit, double>(
            builder: (context, opacity) {
              return Column(
                children: [
                  DefaultAppBar(
                    globalKey: [
                      aboutKey,
                      passionKey,
                      expKey,
                      workKey,
                      contactKey,
                    ],
                    opacity: opacity,
                    scrollController: scrollController,
                    web: responseSize,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  ColorFilter _colorMatrix() {
    return ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  void _showSlideDialog(
    BuildContext context,
    String imagePath,
    String name,
    String description,
  ) {
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
                              name,
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
                            subText(context, text: description),
                            SizedBox(height: 30),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   spacing: 10,
                            //   children: [
                            //     CustomAnimatedButton(
                            //       text: 'Android Link',
                            //       onHover: (value) {},
                            //     ),
                            //     Text(
                            //       'Or',
                            //       style: TextStyle(
                            //         fontFamily: 'PlayfairDisplay',
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300,
                            //       ),
                            //       textAlign: TextAlign.center,
                            //     ),
                            //     CustomAnimatedButton(text: 'iOS Link'),
                            //   ],
                            // ),
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

  SizedBox subText(
    BuildContext context, {
    String text = '',
    double fontSize = 16,
  }) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'PlayfairDisplay',
          fontSize: fontSize,
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

class GreetingSection extends StatelessWidget {
  const GreetingSection({
    super.key,
    required Animation<Offset> textSlideAnimation,
    required Animation<double> fadeAnimation,
    required Animation<Offset> fromDownSlideAnimation,
    required this.aboutKey,
  }) : _textSlideAnimation = textSlideAnimation,
       _fadeAnimation = fadeAnimation,
       _fromDownSlideAnimation = fromDownSlideAnimation;

  final Animation<Offset> _textSlideAnimation;
  final Animation<double> _fadeAnimation;
  final Animation<Offset> _fromDownSlideAnimation;
  final GlobalKey aboutKey;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  position: _fromDownSlideAnimation,
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
                _scrollTo(aboutKey);
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
    );
  }
}

void _scrollTo(GlobalKey globalKey) {
  final context = globalKey.currentContext;
  if (context != null) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
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

Future<void> _launchEmail(String emailAddress) async {
  Uri uri = Uri.parse('mailto:$emailAddress?subject=Greetings&body=Hello,');

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw Exception('Could not launch email app');
  }
}
