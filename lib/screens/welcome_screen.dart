import 'package:first_project/screens/dash_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcome-screen';
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

const _duration1 = Duration(seconds: 3);
const _duration2 = Duration(seconds: 2);

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _imgAnim1;
  late Animation<double> _imgAnimEnd1;
  late Animation<double> _textAnim1,
      _textAnim2,
      _textAnim3,
      _textAnim4,
      _textAnim5,
      _textAnim6,
      _textAnim7;
  late Animation<double> _textAnimEnd1,
      _textAnimEnd2,
      _textAnimEnd3,
      _textAnimEnd4,
      _textAnimEnd5,
      _textAnimEnd6,
      _textAnimEnd7;
  late Animation<double> _dotAnim1, _dotAnim2, _dotAnim3, _dotAnim4, _dotAnim5;
  late Animation<double> _dotAnimEnd1,
      _dotAnimEnd2,
      _dotAnimEnd3,
      _dotAnimEnd4,
      _dotAnimEnd5;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _controller1 = AnimationController(vsync: this, duration: _duration1);
    _controller2 = AnimationController(vsync: this, duration: _duration2);
    _imgAnim1 = (CurvedAnimation(
        parent: _controller1,
        curve: const Interval(.0, 0.3, curve: Curves.easeInCubic)));
    _imgAnimEnd1 = CurvedAnimation(
        parent: _controller1,
        curve: const Interval(.6, 1, curve: Curves.easeOut));

    ///
    /// welcome-text animation
    _textAnim1 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.0, .07));
    _textAnimEnd1 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.03, .12));
    _textAnim2 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.10, .19));
    _textAnimEnd2 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.17, .26));
    _textAnim3 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.24, .33));
    _textAnimEnd3 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.31, .40));
    _textAnim4 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.38, .47));
    _textAnimEnd4 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.45, .54));
    _textAnim5 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.52, .61));
    _textAnimEnd5 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.59, .68));
    _textAnim6 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.66, .75));
    _textAnimEnd6 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.73, .82));
    _textAnim7 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.80, .89));
    _textAnimEnd7 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.87, 1));

    ///
    /// dot animation
    _dotAnim1 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.04, .1));
    _dotAnimEnd1 = CurvedAnimation(
        parent: _controller2,
        curve: const Interval(.1, .2, curve: Curves.bounceOut));
    _dotAnim2 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.14, .3));
    _dotAnimEnd2 = CurvedAnimation(
        parent: _controller2,
        curve: const Interval(.3, .4, curve: Curves.bounceOut));
    _dotAnim3 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.34, .5));
    _dotAnimEnd3 = CurvedAnimation(
        parent: _controller2,
        curve: const Interval(.5, .6, curve: Curves.bounceOut));
    _dotAnim4 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.54, .7));
    _dotAnimEnd4 = CurvedAnimation(
        parent: _controller2,
        curve: const Interval(.7, .8, curve: Curves.bounceOut));
    _dotAnim5 =
        CurvedAnimation(parent: _controller2, curve: const Interval(.74, .9));
    _dotAnimEnd5 = CurvedAnimation(
        parent: _controller2,
        curve: const Interval(.9, .96, curve: Curves.bounceOut));
    _controller1.repeat();
    _controller2.repeat();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textWidth = size.width / 10;
    final dotWidth = (textWidth * 2) / 6;
    final dotBetweenWidth = dotWidth / 6;
    return Scaffold(
      backgroundColor: MyColor.bluePrimary,
      body: AnimatedBuilder(
        animation: _controller1,
        builder: (context, _) => Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: SweepGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomCenter,
                    colors: [
                      MyColor.bluePrimary,
                      MyColor.blueSecondary,
                      MyColor.skyPrimary,
                      MyColor.blueSecondary,
                      MyColor.bluePrimary,
                      MyColor.bluePrimary,
                    ],
                  ),
                ),
              ),
            ),
            // soowGood-img animation
            Positioned(
              left: -size.width * .4,
              width: size.width * .8,
              top: size.height * .21,
              child: Opacity(
                opacity: (_imgAnim1.value) - _imgAnimEnd1.value,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, .001)
                    ..scale(.3 + .7 * _imgAnim1.value - .7 * _imgAnimEnd1.value)
                    ..translate((size.width * .5) * _imgAnim1.value -
                        (size.width * .5) * _imgAnimEnd1.value),
                  // ..rotateX(
                  //     (360 * _imgAnim1.value - 360 * _imgAnimEnd1.value) /
                  //         90 *
                  //         pi),
                  child: Image.asset("assets/images/main_logo.png"),
                ),
              ),
            ),

            ///
            /// welcome-text animation
            Positioned(
              bottom: size.height * .1 +
                  15 * _textAnim1.value -
                  15 * _textAnimEnd1.value,
              left: textWidth * 1.5 + textWidth * 0,
              width: textWidth,
              height: textWidth,
              child: Image.asset("assets/images/w.png", fit: BoxFit.fitHeight),
            ),
            Positioned(
              bottom: size.height * .1 +
                  15 * _textAnim2.value -
                  15 * _textAnimEnd2.value,
              left: textWidth * 1.5 + textWidth * 1,
              width: textWidth,
              height: textWidth,
              child: Image.asset("assets/images/e.png", fit: BoxFit.fitHeight),
            ),
            Positioned(
              bottom: size.height * .1 +
                  15 * _textAnim3.value -
                  15 * _textAnimEnd3.value,
              left: textWidth * 1.5 + textWidth * 2,
              width: textWidth,
              height: textWidth,
              child: Image.asset("assets/images/l.png", fit: BoxFit.fitHeight),
            ),
            Positioned(
              bottom: size.height * .1 +
                  15 * _textAnim4.value -
                  15 * _textAnimEnd4.value,
              left: textWidth * 1.5 + textWidth * 3,
              width: textWidth,
              height: textWidth,
              child: Image.asset("assets/images/c.png", fit: BoxFit.fitHeight),
            ),
            Positioned(
              bottom: size.height * .1 +
                  15 * _textAnim5.value -
                  15 * _textAnimEnd5.value,
              left: textWidth * 1.5 + textWidth * 4,
              width: textWidth,
              height: textWidth,
              child: Image.asset("assets/images/o.png", fit: BoxFit.fitHeight),
            ),
            Positioned(
              bottom: size.height * .1 +
                  15 * _textAnim6.value -
                  15 * _textAnimEnd6.value,
              left: textWidth * 1.5 + textWidth * 5,
              width: textWidth,
              height: textWidth,
              child: Image.asset("assets/images/m.png", fit: BoxFit.fitHeight),
            ),
            Positioned(
              bottom: size.height * .1 +
                  15 * _textAnim7.value -
                  15 * _textAnimEnd7.value,
              left: textWidth * 1.5 + textWidth * 6,
              width: textWidth,
              height: textWidth,
              child: Image.asset("assets/images/e.png", fit: BoxFit.fill),
            ),

            ///
            /// dot animation
            Positioned(
              bottom: 20 + 30 * _dotAnim1.value - 30 * _dotAnimEnd1.value,
              left: size.width * .4 + dotWidth * 0,
              width: dotWidth,
              height: 10,
              child: _dotIcon(),
            ),
            Positioned(
              bottom: 20 + 30 * _dotAnim2.value - 30 * _dotAnimEnd2.value,
              left: size.width * .4 + dotWidth * 1 + dotBetweenWidth * 1,
              width: dotWidth,
              height: 10,
              child: _dotIcon(),
            ),
            Positioned(
              bottom: 20 + 30 * _dotAnim3.value - 30 * _dotAnimEnd3.value,
              left: size.width * .4 + dotWidth * 2 + dotBetweenWidth * 2,
              width: dotWidth,
              height: 10,
              child: _dotIcon(),
            ),
            Positioned(
              bottom: 20 + 30 * _dotAnim4.value - 30 * _dotAnimEnd4.value,
              left: size.width * .4 + dotWidth * 3 + dotBetweenWidth * 3,
              width: dotWidth,
              height: 10,
              child: _dotIcon(),
            ),
            Positioned(
              bottom: 20 + 30 * _dotAnim5.value - 30 * _dotAnimEnd5.value,
              left: size.width * .4 + dotWidth * 4 + dotBetweenWidth * 4,
              width: dotWidth,
              height: 10,
              child: _dotIcon(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dotIcon() {
    return const DecoratedBox(
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: MyColor.ashhLight),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
