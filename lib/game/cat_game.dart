import 'package:flame/components/parallax_component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:game1/compenents/cat.dart';
import 'package:flame/game/base_game.dart';
import 'package:flutter/material.dart';
import 'package:game1/compenents/enemy.dart';


class CatGame extends BaseGame with TapDetector{
  Cat _cat;
  Enemy _enemy;

  ParallaxComponent _parallaxComponent;
  TextComponent _textComponent;
  int _score;

  CatGame() {
    _parallaxComponent = ParallaxComponent([
      ParallaxImage('parallax/7.png'),
      ParallaxImage('parallax/6.png'),
      ParallaxImage('parallax/5.png'),
      ParallaxImage('parallax/4.png'),
      ParallaxImage('parallax/3.png'),
      ParallaxImage('parallax/2.png'),
      ParallaxImage('parallax/1.png'),
    ],
      baseSpeed: const Offset(100, 0),
      layerDelta: const Offset(20, 0),
    );

    add(_parallaxComponent);

    _cat = Cat();
    _cat.run();
    add(_cat);

    _enemy=Enemy();
    add(_enemy);

    _score=0;
    _textComponent=TextComponent(_score.toString());
    add(_textComponent);
  }
@override
  void onTapDown(TapDownDetails details) {
    debugPrint('clicked!');
    _cat.jump();
    super.onTapDown(details);
  }

  @override
  void update(double t) {
    //_score +=(60 * t).toInt();
    if(_cat.distance(_enemy)<=20){
      _cat.hit();
    }
    super.update(t);
  }
}
