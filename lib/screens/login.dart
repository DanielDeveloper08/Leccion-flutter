import 'package:flutter/material.dart';
import 'package:leccion_morante_keyla/screens/xmlPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String keyla_morante_password = '',
    keyla_morante_usuario = '',
    claveFija = "999",
    usuarioFijo = "admin";

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(),
    );
  }

  Widget cuerpo() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/newFondo.webp"), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [titulo(), campos(), footer()],
      ),
    );
  }

  Widget titulo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      alignment: Alignment.center,
      color: Colors.black,
      child: const Text(
        'Desarrollo Movil',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget campos() {
    return Column(
      children: [
        usuario(),
        const SizedBox(height: 20),
        contrasena(),
        const SizedBox(height: 80),
        botonConectar(),
      ],
    );
  }

  Widget usuario() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          const SizedBox(
            width: 80,
            child: Text(
              'Usuario',
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (val) {
                setState(() {
                  keyla_morante_usuario = val;
                });
              },
              decoration: const InputDecoration(
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contrasena() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          const SizedBox(
            width: 80,
            child: Text(
              'Contrasena',
              style: TextStyle(),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (val) {
                setState(() {
                  keyla_morante_password = val;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget botonConectar() {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        onPressed: () {
          if (keyla_morante_password == claveFija &&
              keyla_morante_usuario == usuarioFijo) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const XmlPageScreen()));
          } else {
            mostrarAlerta(context);
          }
        },
        child: const Text(
          "Conectar",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alerta"),
          content: Text("La contraseña o usuario no son válidos."),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  Widget footer() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child:
          Text('Derecho reservados a la Futura Ing. en Software Keila Morante'),
    );
  }
}
