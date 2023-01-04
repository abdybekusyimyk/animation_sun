import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isFullSun = false;
  Duration duration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future<void>.delayed(duration);
      changeMode(0);
    });
  }

  Future<void> changeMode(int value) async {
    if (value == 1) {
      setState(() {
        isFullSun = true;
      });
    } else {
      setState(() {
        isFullSun = false;
      });
    }
    // await Future<void>.delayed(duration);
    // setState(() {
    //   isFullSun = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> lightBgColors = [
      const Color(0xFF8C2480),
      const Color(0xFFCE587D),
      const Color(0xFFFF9485),
      if (isFullSun) const Color(0xFFFF9D80),
    ];
    var darkBgColors = const [
      Color(0xFF0D1441),
      Color(0xFF283584),
      Color(0xFF376AB2),
    ];

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AnimatedContainer(
        duration: duration,
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: isFullSun ? lightBgColors : darkBgColors,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              bottom: isFullSun ? 30 : -150,
              left: 40,
              duration: duration,
              child: SvgPicture.asset('assets/sun (2).svg'),
            ),
            Positioned(
              bottom: -35,
              left: 0,
              right: 0,
              child: Image.asset('assets/land_tree_light (1).png',
                  height: height * 0.48, fit: BoxFit.fitHeight),
            ),
            Container(
              width: width * 0.9,
              height: 70,
              margin: const EdgeInsets.fromLTRB(20, 100, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DefaultTabController(
                length: 2,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.black,
                  labelStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: const [
                    Tab(
                      text: 'Kyn',
                    ),
                    Tab(
                      text: 'Tun',
                    ),
                  ],
                  onTap: (value) async {
                    await changeMode(value);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
