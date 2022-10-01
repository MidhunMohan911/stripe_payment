class Product {
  String name;
  int price;
  bool isAdded;
  String image;

  Product(
      {required this.price,
      required this.name,
      required this.image,
      this.isAdded = false});
}
