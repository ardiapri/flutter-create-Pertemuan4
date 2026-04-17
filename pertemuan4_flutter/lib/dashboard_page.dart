import 'package:flutter/material.dart';
import 'dart:math';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(
        title: Text("Quantum Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [

          // 🔥 BACKGROUND QUANTUM (PARTICLE)
          Positioned.fill(
            child: QuantumBackground(),
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.7),
          ),

          Center(
            child: Container(
              width: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.cyanAccent),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // 🔹 ICON 3D GLOW
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.8),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Icon(Icons.account_circle,
                        size: 70, color: Colors.cyanAccent),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "WELCOME",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  SizedBox(height: 15),

                  // Username box
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.cyanAccent),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.cyanAccent),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Username: ${data['username']}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Password box
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.purpleAccent),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock, color: Colors.purpleAccent),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Password: ${data['password']}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.logout),
                    label: Text("EXIT"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      side: BorderSide(color: Colors.redAccent),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔥 QUANTUM BACKGROUND (PARTICLE EFFECT)
class QuantumBackground extends StatefulWidget {
  @override
  _QuantumBackgroundState createState() => _QuantumBackgroundState();
}

class _QuantumBackgroundState extends State<QuantumBackground>
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
          painter: QuantumPainter(controller.value),
        );
      },
    );
  }
}

class QuantumPainter extends CustomPainter {
  final double value;
  final Random random = Random();

  QuantumPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 50; i++) {
      final x = random.nextDouble() * size.width;
      final y =
          (random.nextDouble() * size.height + value * 100) % size.height;

      final paint = Paint()
        ..color = Colors.cyanAccent.withOpacity(0.7);

      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}