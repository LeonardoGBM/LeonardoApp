import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Field Focus',
      home: MyCustomForm(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          color: Colors.purple,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isBlack = true;
  String sampleText =
      'Este texto es un ejemplo: el primer boton cambia el texto y cambia el color, el segundo boton realiza una animación en la imagen, el tercer boton lanza una alerta, el cuarto boton reinicia la aplicación y el ultimo boton cierra la aplicacion';
  Color textColor = Colors.white;
  Color backgroundColor = Colors.black;
  bool isGalleryButtonPressed = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.5).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void animateImages() {
    setState(() {
      isGalleryButtonPressed = true;
    });
    _animationController.forward().then((value) {
      setState(() {
        isGalleryButtonPressed = false;
      });
    });
  }

  void changeTextColor() {
    setState(() {
      sampleText = 'Tu texto se ha cambiado de color y de mensaje: esta es la magia de la programación XD';
      textColor = Colors.lightBlue;
    });
  }

  void showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Aviso'),
          content: Text(
              'Bienvenido a la configuración de la App de Leonardo. Si solicitas un cambio, comunícate al correo: lgm.bocon@yavirac.edu.ec'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void changeBackgroundColor() {
    setState(() {
      isBlack = !isBlack;
      backgroundColor = isBlack ? Colors.black : Colors.grey;
    });
  }

  void restartApp() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => MyApp()),
      (Route<dynamic> route) => false,
    );
  }

  void closeApp() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App de Leonardo',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  transform: isGalleryButtonPressed ? Matrix4.rotationZ(0.2) : Matrix4.identity(),
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundColor: Colors.purple,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/ellafreya.jpg',
                        fit: BoxFit.cover,
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: Colors.purple,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/ulqui.jpg',
                      fit: BoxFit.cover,
                      width: 200.0,
                      height: 200.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              sampleText,
              style: TextStyle(fontSize: 20, color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              changeTextColor();
            },
            child: Icon(Icons.color_lens),
            backgroundColor: Colors.pink,
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              animateImages();
            },
            child: Icon(Icons.image),
            backgroundColor: Colors.purple,
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              showAlert();
            },
            child: Icon(Icons.warning),
            backgroundColor: Colors.purple,
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              restartApp();
            },
            child: Icon(Icons.refresh),
            backgroundColor: Colors.orange,
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              closeApp();
            },
            child: Icon(Icons.close),
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
