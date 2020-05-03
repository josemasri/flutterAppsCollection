import 'package:backgrounds/src/theme/theme.dart';
import 'package:backgrounds/src/widgets/radial_progress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraficasCircularesPage extends StatefulWidget {
  @override
  _GraficasCircularesPageState createState() => _GraficasCircularesPageState();
}

class _GraficasCircularesPageState extends State<GraficasCircularesPage> {
  double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            porcentaje += 10;
            if (porcentaje > 100) {
              porcentaje = 0;
            }
          });
        },
        child: Icon(Icons.refresh),
      ),
      body: GridView(
        padding: EdgeInsets.symmetric(vertical: 100),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: <Widget>[
          GridTile(
              child: CustomRadialProgress(
            porcentaje: porcentaje,
            color: Colors.red,
          )),
          GridTile(
              child: CustomRadialProgress(
                  porcentaje: porcentaje * 1.2, color: Colors.blue)),
          GridTile(
              child: CustomRadialProgress(
                  porcentaje: porcentaje * 4, color: Colors.amber)),
          GridTile(
              child: CustomRadialProgress(
            porcentaje: porcentaje * 6,
            color: Colors.green,
          )),
        ],
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  final Color color;
  const CustomRadialProgress({
    @required this.porcentaje,
    this.color = Colors.blue,
  });

  final double porcentaje;

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Container(
      width: 300,
      height: 300,
      child: RadialProgress(
        percentage: porcentaje,
        primaryColor: color,
        secondaryColor: themeChanger.currentTheme.textTheme.body1.color,
        primaryStrokeWidth: 20,
        secondaryStrokeWidth: 10,
      ),
    );
  }
}
