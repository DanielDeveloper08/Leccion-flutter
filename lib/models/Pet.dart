class Pet {
  String nombre;
  String raza;
  String color;
  String imagenUrl;

  // Constructor
  Pet(this.nombre, this.raza, this.color, this.imagenUrl);

  static Pet? fromXML(Map<String, dynamic> xml) {
    if (xml == null) {
      return null;
    } else {
      return Pet(
        xml["nombre"],
        xml["raza"],
        xml["color"],
        xml["imagenUrl"],
      );
    }
  }

  // Getters
  get Nombre => this.nombre;
  get Raza => this.raza;
  get Color => this.color;
  get ImagenUrl => this.imagenUrl;
}
