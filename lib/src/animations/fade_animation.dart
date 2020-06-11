import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class FadeAnimation extends StatelessWidget {

  final double delay;
  final String begin;
  final Widget child;

  const FadeAnimation({Key key, this.delay, this.child, this.begin }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final type = (begin == 'bottom' || begin == 'top') ? 'translateY' : 'translateX';
    final double translateBegin =  (begin == 'bottom' || begin == 'right') ? 120.0 : -120.0;
    final tween = MultiTrackTween([
      Track('opacity').add(Duration(milliseconds: 500),
        Tween(begin: 0.0, end: 1.0)),
      Track(type).add(Duration(milliseconds: 500),
        Tween(
          begin: translateBegin, 
          end: 0.0), 
          curve: Curves.easeOut
        ),
    ]);
    return ControlledAnimation(
      delay: Duration(
        milliseconds: (500 * delay).round()),
        duration: tween.duration,
        tween: tween,
        child: child,
        builderWithChild: (context, child, animation) => Opacity(
          opacity: animation['opacity'],
          child: Transform.translate(
            offset: Offset(
              type == 'translateX' ? animation[type] : 0, 
              type == 'translateY' ? animation[type] : 0
            ),
            child: child,
          )
        ),
      );
  }
}