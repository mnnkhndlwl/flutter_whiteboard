import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whiteboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DrawingBoard(),
    );
  }
}

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({Key key}) : super(key: key);

  @override
  State<DrawingBoard> createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  Color selectedColor = Colors.black;
  double strokeWidth = 5;
  List<DrawingPoint> drawingPoints = [];
  List<Color> colors = [
    Colors.pink,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.amberAccent,
    Colors.purple,
    Colors.green,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanStart: (details) {
          setState(() {
            drawingPoints.add(
              DrawingPoint(
                details.localPosition,
                Paint()
                  ..color = selectedColor
                  ..isAntiAlias = true
                  ..strokeWidth = strokeWidth
                  ..strokeCap = StrokeCap.round,
              ),
            );
          });
        },
        onPanUpdate: (details) {
          setState(() {
            drawingPoints.add(
              DrawingPoint(
                details.localPosition,
                Paint()
                  ..color = selectedColor
                  ..isAntiAlias = true
                  ..strokeWidth = strokeWidth
                  ..strokeCap = StrokeCap.round,
              ),
            );
          });
        },
        onPanEnd: (details) {
          setState(() {
            drawingPoints.add(null);
          });
        },
        child: CustomPaint(
          painter: _DrawingPainter(drawingPoints),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('WhiteBoard'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              colors.length,
              (index) => _buildColorChose(colors[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorChose(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        height: isSelected ? 50 : 40,
        width: isSelected ? 50 : 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(
                  color: Colors.white,
                  width: 3,
                )
              : null,
        ),
      ),
    );
  }
}

class _DrawingPainter implements CustomPainter {
  final List<DrawingPoint> drawingPoints;

  _DrawingPainter(this.drawingPoints);
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    for (int i = 0; i < drawingPoints.length; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(drawingPoints[i].offset, drawingPoints[i + 1].offset,
            drawingPoints[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
  }

  @override
  bool hitTest(Offset position) {
    // TODO: implement hitTest
    throw UnimplementedError();
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  // TODO: implement semanticsBuilder
  SemanticsBuilderCallback get semanticsBuilder => throw UnimplementedError();

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRebuildSemantics
    throw UnimplementedError();
  }
}

class DrawingPoint {
  Offset offset;
  Paint paint;

  DrawingPoint(this.offset, this.paint);
}
