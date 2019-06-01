import 'package:flutter/material.dart';
import 'package:flutterhackathon/Components/app_button.dart';
import 'package:flutterhackathon/Screens/Login/login_screen.dart';
import 'package:flutterhackathon/Theme/theme.dart';
import 'package:flutterhackathon/Utils/app_size.dart';
import 'package:flutterhackathon/Utils/utils.dart';
import 'package:flutterhackathon/components/backgroud_gredient_widget.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    appLogs("TutorialScreen", tag: "Screen");

    _pageController = new PageController();
  }

  updateCurrentPage(int page) {
    setState(() {
      _currentPage = page;
    });
    appLogs("_currentPage:$_currentPage");
  }

  List<TutorialPage> _pageList = [
    TutorialPage(
      image: Assets.iconIllus1,
      heading: Strings.tutorialHeading1,
      subHeading: Strings.tutorialSubHeading1,
    ),
    TutorialPage(
      image: Assets.iconIllus2,
      heading: Strings.tutorialHeading2,
      subHeading: Strings.tutorialSubHeading2,
    ),
    TutorialPage(
      image: Assets.iconIllus3,
      heading: Strings.tutorialHeading3,
      subHeading: Strings.tutorialSubHeading3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundGradientWidget(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: updateCurrentPage,
                  children: _pageList.map((page) {
                    return PageViewWidget(page: page);
                  }).toList(),
                ),
              ),
              PageIndicator(
                currentPage: _currentPage,
                length: _pageList.length,
                bottomOffset: (screenHeight * 0.14),
              ),
              Padding(
                padding: EdgeInsets.all(Sizes.s15),
                child: AppButton(
                  onTap: () async {
                    AppRoutes.makeFirst(context, LoginScreen());
                  },
                  title: Strings.getStarted,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Sizes.s5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class PageViewWidget extends StatelessWidget {
  final TutorialPage page;

  const PageViewWidget({Key key, @required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(Sizes.s15),
            child: Image(
              image: AssetImage(page.image),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: Sizes.s20, horizontal: Sizes.s10),
          child: Text(
            page.heading,
            style: TextStyles.welcomeTitle,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: Sizes.s20, horizontal: Sizes.s10),
          child: Text(
            page.subHeading,
            style: TextStyles.welcomeSubTitle,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int length;
  final double bottomOffset;

  const PageIndicator({
    Key key,
    @required this.currentPage,
    @required this.length,
    @required this.bottomOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List pageList = new List.generate(length, (index) => index);
    List<Widget> children = List();
    pageList.forEach((index) {
      children.add(TabPageSelectorIndicator(
        backgroundColor: currentPage == index ? Colors.white : AppColors.secondary,
        borderColor: currentPage == index ? Colors.white : AppColors.secondary,
        size: 12.0,
      ));
    });
    return Center(
      // bottom: bottomOffset,
      // width: screenSize.width,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}

class TutorialPage {
  String image;
  String heading;
  String subHeading;

  TutorialPage({this.image, this.heading, this.subHeading});
}
