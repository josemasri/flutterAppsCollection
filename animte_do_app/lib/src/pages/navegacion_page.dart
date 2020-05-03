import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavegacionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('Notification page'),
        ),
        floatingActionButton: BotonFlotante(),
        bottomNavigationBar: BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.bone),
          title: Text('bones'),
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              FaIcon(FontAwesomeIcons.bell),
              Positioned(
                right: 0,
                top: 0,
                child: Builder(
                  builder: (BuildContext context) {
                    final notificationModel =
                        Provider.of<_NotificationModel>(context);
                    return BounceInDown(
                      animate: notificationModel.numero > 0 ? true : false,
                      from: 10,
                      child: Bounce(
                        controller: (controller) =>
                            notificationModel.bounceController = controller,
                        from: 10,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            notificationModel.numero.toString(),
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          title: Text('Notifications'),
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.dog),
          title: Text('My dog'),
        ),
      ],
    );
  }
}

class BotonFlotante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notificationModel =
        Provider.of<_NotificationModel>(context, listen: false);
    return FloatingActionButton(
      onPressed: () {
        notificationModel.numero++;
        if (notificationModel.numero >= 2) {
          notificationModel.bounceController.forward(from: 0.0);
        }
      },
      backgroundColor: Colors.pink,
      child: FaIcon(
        FontAwesomeIcons.play,
      ),
    );
  }
}

class _NotificationModel extends ChangeNotifier {
  int _numero = 0;
  AnimationController bounceController;

  int get numero => _numero;

  set numero(int value) {
    _numero = value;
    notifyListeners();
  }
}
