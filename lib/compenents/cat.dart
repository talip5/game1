import 'dart:async';
import 'dart:ui';
import 'package:flame/animation.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/spritesheet.dart';
import 'package:flame/time.dart';

const GRAVITY=1000;

class Cat extends AnimationComponent{
  SpriteSheet catSpritesheet;
  Animation  _runAnimation;
  Animation  _hitAnimation;
  double speedY=0;
  double maxY=0;
  bool isHit;
  Timer _timer;

  Cat():super.empty(){
    catSpritesheet=SpriteSheet(
    imageName: "cat_spritesheet.png",
    textureWidth: 32,
    textureHeight: 32,
    columns: 8,
    rows: 10);

    _runAnimation =
    catSpritesheet.createAnimation(4, from: 0, to: 7, stepTime: 0.1);
    _hitAnimation =
    catSpritesheet.createAnimation(9, from: 0, to: 7, stepTime: 0.1);
    animation = _runAnimation;
    isHit=false;
    _timer=Timer(2,callback: (){
      run();
    },
      repeat: true,
    );
  }
  bool isOnGround(){
    return(y>=maxY);
  }

  @override
  void resize(Size size) {
   width = height=size.width/10;
   //x = size.width+width;
   x=width;
   y =size.height - 30 - height;
   maxY=y;
    super.resize(size);
  }

  @override
  void update(double t) {
    speedY=speedY + GRAVITY * t;
    y=y + speedY * t;
    if(isOnGround()){
      y=maxY;
      speedY=0;
    }
    _timer.update(t);
    super.update(t);
  }
  void run(){
    animation = _runAnimation;
  }
  void hit(){
    if(!isHit){
      isHit=true;
      animation = _hitAnimation;
      _timer.start();
    }
  }
  void jump(){
    if(isOnGround()) {
      speedY = -500;
    }
  }

}