import 'package:ezeehome_webview/Screens/Home.dart';
import 'package:ezeehome_webview/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  var controller = PageController();
  bool isFirstPage = true;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.kScaffolodBackgroundColor,
      body: Stack(
        children: [
          Container(
            // padding: EdgeInsets.only(bottom: 50),
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  isFirstPage = index == 0;
                });
                setState(() {
                  isLastPage = index == 3;
                });
              },
              children: [
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 48,
                              right: 32,
                            ),
                            child: GestureDetector(
                              onTap: () {
                               SkipOrDone();
                              },
                              // arrow back button
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'Skip',
                                    style: TextStyle(
                                      color: MyColors.kGreyColor,
                                      fontFamily: 'Monospace',
                                    ),
                                  )),
                            ),
                          ),
                          Image.asset(
                              'assets/boarding/boarding screen (1).png'),
                        ]),
                  ],
                ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 48,
                              right: 32,
                            ),
                            child: GestureDetector(
                              onTap: () {
                             SkipOrDone();
                              },
                              // arrow back button
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'Skip',
                                    style: TextStyle(
                                      color: MyColors.kGreyColor,
                                      fontFamily: 'Monospace',
                                    ),
                                  )),
                            ),
                          ),
                          Image.asset(
                              'assets/boarding/boarding screen (2).png'),
                        ]),
                  ],
                ),
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 48,
                              right: 32,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                SkipOrDone();
                              },
                              // arrow back button
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'Skip',
                                    style: TextStyle(
                                      color: MyColors.kGreyColor,
                                      fontFamily: 'Monospace',
                                    ),
                                  )),
                            ),
                          ),
                          Image.asset(
                              'assets/boarding/boarding screen (3).png'),
                        ]),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/boarding/boarding screen (4).png'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: MyColors.kScaffolodBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 8),
        height: 80,
        child: Row(
          children: [
            isLastPage
                ? Container(
                    // decoration: BoxDecoration(
                    //     color: MyColors.kGreyColor,
                    //     borderRadius: BorderRadius.circular(70)),
                    child: TextButton(
                        onPressed: () {
                          controller.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  )
                : SizedBox(),
            Spacer(),
            Center(
              child: isLastPage
                  ? SizedBox()
                  : SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: ExpandingDotsEffect(
                          activeDotColor: MyColors.kmainColor,
                          dotColor: MyColors.kGreyColor),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: Duration(microseconds: 500),
                          curve: Curves.easeIn),
                    ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: MyColors.kGreyColor,
                  borderRadius: BorderRadius.circular(70)),
              child: isLastPage
                  ? TextButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                        SkipOrDone();
                      },
                      child: Text(
                        'Agree',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                  : IconButton(
                      onPressed: () {
                        controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      icon: Icon(
                        Icons.arrow_forward_outlined,
                        color: MyColors.kScaffolodBackgroundColor,
                      )),
            )
          ],
        ),
      ),
      // ),
    );
  }

  void SkipOrDone() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('showHome', true);
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }
}
