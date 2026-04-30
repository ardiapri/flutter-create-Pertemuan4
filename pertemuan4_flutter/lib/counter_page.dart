import 'package:flutter/material.dart';
import 'dart:math';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  void tambah() {
    setState(() => counter++);
  }

  void kurang() {
    setState(() {
      if (counter > 0) counter--;
    });
  }

  void reset() {
    setState(() => counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quantum Counter"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [

          // 🔥 Background animasi
          Positioned.fill(child: QuantumBackground()),

          Container(
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

                  // 🔹 Icon Glow
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
                    child: Icon(Icons.calculate,
                        size: 60, color: Colors.cyanAccent),
                  ),

                  SizedBox(height: 15),

                  Text(
                    "COUNTER",
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  SizedBox(height: 20),

                  // 🔢 Angka Counter
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.cyanAccent),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "$counter",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // 🔘 Tombol + dan -
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: kurang,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          side: BorderSide(color: Colors.redAccent),
                          padding: EdgeInsets.all(15),
                        ),
                        child: Icon(Icons.remove, color: Colors.redAccent),
                      ),

                      SizedBox(width: 20),

                      ElevatedButton(
                        onPressed: tambah,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          side: BorderSide(color: Colors.cyanAccent),
                          padding: EdgeInsets.all(15),
                        ),
                        child: Icon(Icons.add, color: Colors.cyanAccent),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // 🔄 Reset
                  ElevatedButton.icon(
                    onPressed: reset,
                    icon: Icon(Icons.refresh, color: Colors.purpleAccent),
                    label: Text(
                      "RESET",
                      style: TextStyle(color: Colors.purpleAccent),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      side: BorderSide(color: Colors.purpleAccent),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),

                  SizedBox(height: 10),

                  // 🔙 Back
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text("BACK"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      side: BorderSide(color: Colors.cyanAccent),
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

// 🔥 Background animasi sama seperti dashboard
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