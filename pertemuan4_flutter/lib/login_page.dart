import 'package:flutter/material.dart';
import 'dart:math';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Color neonGreen = Color(0xFF00FF00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // 🔥 BACKGROUND MATRIX SUPER WAH
          Positioned.fill(
            child: Stack(
              children: [
                MatrixRain(),

                // 🔹 Glow aura
                Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 1.2,
                      colors: [
                        Colors.green.withOpacity(0.2),
                        Colors.black,
                      ],
                    ),
                  ),
                ),

                // 🔹 Grid digital
                CustomPaint(
                  painter: GridPainter(),
                ),
              ],
            ),
          ),

          // 🔹 Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.2),
                  Colors.purple.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🔹 LOGIN FORM (punya kamu)
          Center(
            child: Container(
              width: 320,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: neonGreen),
                boxShadow: [
                  BoxShadow(
                    color: neonGreen.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "MATRIX LOGIN",
                    style: TextStyle(
                      color: neonGreen,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 20),

                  TextField(
                    controller: usernameController,
                    style: TextStyle(color: neonGreen),
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle:
                          TextStyle(color: neonGreen.withOpacity(0.6)),
                      prefixIcon:
                          Icon(Icons.person, color: neonGreen),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: neonGreen),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: neonGreen, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: neonGreen),
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle:
                          TextStyle(color: neonGreen.withOpacity(0.6)),
                      prefixIcon:
                          Icon(Icons.lock, color: neonGreen),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: neonGreen),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: neonGreen, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/dashboard',
                          arguments: {
                            'username': usernameController.text,
                            'password': passwordController.text,
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        side: BorderSide(color: neonGreen),
                        padding:
                            EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        "ENTER",
                        style: TextStyle(
                          color: neonGreen,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔥 MATRIX RAIN
class MatrixRain extends StatefulWidget {
  @override
  _MatrixRainState createState() => _MatrixRainState();
}

class _MatrixRainState extends State<MatrixRain>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return CustomPaint(
          painter: MatrixPainter(controller.value),
        );
      },
    );
  }
}

class MatrixPainter extends CustomPainter {
  final double value;
  final Random random = Random();

  MatrixPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 100; i++) {
      final x = random.nextDouble() * size.width;
      final y = (random.nextDouble() * size.height + value * 200) %
          size.height;

      final textPainter = TextPainter(
        text: TextSpan(
          text: "01",
          style: TextStyle(color: Colors.green, fontSize: 12),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// 🔥 GRID MATRIX
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.1)
      ..strokeWidth = 0.5;

    double spacing = 30;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}