import 'package:flare_flutter/flare/math/mat2d.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare.dart';

class PenguinDance extends StatefulWidget {
  @override
  _PenguinDanceState createState() => _PenguinDanceState();
}

class _PenguinDanceState extends State<PenguinDance>
    implements FlareController {
  double _rockAmount = 0.5;
  double _speed = 1.0;
  double _rockTime = 0.0;
  bool _isPaused = false;

  ActorAnimation _rock;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    _rockTime += elapsed * _speed;
    _rock.apply(_rockTime % _rock.duration, artboard, _rockAmount);
    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _rock = artboard.getAnimation("music_walk");
  }

  @override
  void setViewTransform(Mat2D viewTransform) {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: FlareActor(
                "assets/Penguin.flr",
                alignment: Alignment.center,
                isPaused: _isPaused,
                fit: BoxFit.cover,
                animation: "walk",
                controller: this,
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Rock Level",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Slider(
                      activeColor: Colors.black,
                      inactiveColor: Colors.black38,
                      value: _rockAmount,
                      min: 0.0,
                      max: 1.5,
                      divisions: null,
                      onChanged: (double value) {
                        setState(() {
                          _rockAmount = value;
                        });
                      },
                    ),
                    Slider(
                      activeColor: Colors.black,
                      inactiveColor: Colors.black38,
                      value: _speed,
                      min: 0.2,
                      max: 5.0,
                      divisions: null,
                      onChanged: (double value) {
                        setState(() {
                          _speed = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 5.0,
              left: 0.0,
              right: 0.0,
              child: IconButton(
                iconSize: 50.0,
                color: Colors.black,
                icon: _isPaused
                    ? Icon(
                  Icons.play_circle_filled,
                )
                    : Icon(
                  Icons.pause_circle_filled,
                ),
                onPressed: () {
                  setState(() {
                    _isPaused = !_isPaused;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
