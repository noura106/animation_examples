import 'dart:ffi';

import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _colorAnimation;
  Animation?  _sizeAnimation;
  Animation ? _curveAnimation;
  bool isFav=false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _colorAnimation=ColorTween(begin: Colors.grey[400],end: Colors.red).animate(_controller!);
    _sizeAnimation= TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(tween: Tween<double>(begin: 30,end: 50), weight: 50),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 50,end: 30), weight: 50),
    ]).animate(_controller!);
    _curveAnimation=CurvedAnimation(parent: _controller!, curve: Curves.slowMiddle);

    _controller!.addListener(() {
      print(_controller!.value);
      print(_colorAnimation!.value);
    });

    _controller!.addStatusListener((status) {
      print(status);
      if(status==AnimationStatus.completed){
        setState(() {
          isFav=true;
        });
      }
      if(status==AnimationStatus.dismissed){
        setState(() {
          isFav=false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller!,
      builder:(BuildContext context,_){
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation!.value,
            size: _sizeAnimation!.value,
          ),
          onPressed: () {
            isFav? _controller!.reverse(): _controller!.forward();
          },
        );
      }
    );
  }
}
