import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leccion_morante_keyla/models/Pet.dart';
import 'package:xml/xml.dart';

class XmlPageScreen extends StatefulWidget {
  const XmlPageScreen({Key? key}) : super(key: key);

  @override
  State<XmlPageScreen> createState() => _XmlPageScreenState();
}

class _XmlPageScreenState extends State<XmlPageScreen> {
  Future<List<Pet>> getPetsFromXml(BuildContext context) async {
    final xmlString = await DefaultAssetBundle.of(context)
        .loadString("assets/data/pets.xml");
    List<Pet> pets = [];
    var raw = XmlDocument.parse(xmlString);
    var elements = raw.findAllElements("animal");

    for (var item in elements) {
      pets.add(Pet(
        item.findElements("nombre").first.text,
        item.findElements("raza").first.text,
        item.findElements("color").first.text,
        item.findElements("imagenUrl").first.text,
      ));
    }

    return pets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        titulo(),
        lecturaXml(),
        botonRegresar(context),
      ],
    ));
  }

  Widget lecturaXml() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
    child: FutureBuilder(
      future: getPetsFromXml(context),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return _listInfo(snapshot.data);
        } else if (snapshot.hasError) {
          return const Text("Error");
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    ),
  );
}

  Widget _listInfo(List<Pet>? data) {
  return Container( 
    height: 420, 
    child: ListView.builder(
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        return PetCard(data![index]);
      },
    ),
  );
}


  Widget PetCard(Pet pet){
    return  Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Nombre: ${pet.nombre}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Raza: ${pet.raza}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Color: ${pet.color}"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              pet.imagenUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
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
        'Archivo XML',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget botonRegresar(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20), // Padding solo en el lado izquierdo
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Regresar",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}
