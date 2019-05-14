import 'package:flutter/material.dart';
import 'dart:math';

class AnimationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimationViewState();
  }
}

class ReversTween extends Tween<double> {
  final double threshold;

  ReversTween(this.threshold, {double begin, double end})
      : super(begin: begin, end: end) {
    assert(threshold > 0);
    assert(threshold < 1);
  }

  @override
  double transform(double t) {
    assert(threshold > 0.0);
    assert(threshold < 1.0);
    assert(begin != null);
    assert(end != null);
    double v = t;
    if (t <= threshold) {
      v = (t / threshold);
    } else {
      v = (1 - t) / (1 - threshold);
    }
    return begin + (end - begin) * v;
  }
}

class AnimationViewState extends State<AnimationView>
    with TickerProviderStateMixin {
  AnimationController controller;

  var scaleAnimation = ReversTween(0.6, begin: 1.0, end: 3.0);

  var rotationAnimation = ReversTween(0.6, begin: 0, end: 2 * pi);

  var tranformAnimation = ReversTween(0.6, begin: 0, end: 66);

  IntTween countDown = IntTween(begin: 5, end: 1);
  double screenHeight = 0;

  Animation scaleValue;
  Animation rotationValue;
  Animation transFormValue;

  AnimationViewState() : super() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _startAnimationRotate() async {
    try {
      controller.reset();
      scaleValue = null;
      transFormValue = null;
      rotationValue = rotationAnimation.animate(controller);
    } catch (e) {
      print(e);
    }
    try {
      await controller.forward().orCancel;
    } catch (e) {
      print(e);
    }
  }

  void _startAnimationScale() async {
    try {
      controller.reset();
      scaleValue = scaleAnimation.animate(
          CurvedAnimation(parent: controller, curve: Curves.decelerate));
      rotationValue = null;
      transFormValue = null;
    } catch (e) {
      print(e);
    }
    try {
      await controller.forward().orCancel;
    } catch (e) {
      print(e);
    }
  }

  void _startAnimationTranslate() async {
    try {
      controller.reset();
      transFormValue = tranformAnimation.animate(
          CurvedAnimation(parent: controller, curve: Curves.decelerate));
      rotationValue = null;
      scaleValue = null;
    } catch (e) {
      print(e);
    }
    try {
      await controller.forward().orCancel;
    } catch (e) {
      print(e);
    }
  }

  void _startStatge() async {
    try {
      controller.reset();
      transFormValue = tranformAnimation.animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.0,
            0.5,
          )));
      rotationValue = rotationAnimation.animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.5,
            1,
          )));
      scaleValue = scaleAnimation.animate(CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.5,
            1,
          )));
    } catch (e) {
      print(e);
    }
    try {
      await controller.forward().orCancel;
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (screenHeight == 0.0) {
      screenHeight = MediaQuery.of(context).size.height * 0.4;
    }
    return Column(
      children: <Widget>[
        Container(
          height: screenHeight,
          child: Center(
            child: AnimatedBuilder(
                animation: controller,
                builder: (context, widgt) {
                  return Transform(
                    transform: Matrix4.rotationZ(rotationValue?.value ?? 0),
                    alignment: Alignment.center,
                    child: Transform.scale(
                      scale: scaleValue?.value ?? 1,
                      child: Transform.translate(
                          offset: Offset(transFormValue?.value ?? 0,
                              1.618 * (transFormValue?.value ?? 0)),
                          child: Image(
                            image: AssetImage("images/lenna.jpg"),
                            fit: BoxFit.fill,
                          )),
                    ),
                  );
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text("平移"),
              onPressed: _startAnimationTranslate,
            ),
            RaisedButton(
              child: Text("缩放"),
              onPressed: _startAnimationScale,
            ),
            RaisedButton(
              child: Text("旋转"),
              onPressed: _startAnimationRotate,
            ),
            RaisedButton(
              child: Text("顺序播放"),
              onPressed: _startStatge,
            )
          ],
        )
      ],
    );
  }
}
