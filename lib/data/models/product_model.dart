class ProductModel {
  List<Products> products;

  ProductModel({this.products});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int productId;
  int qty;
  int packageId;
  int shudderId;
  int orderService;
  int power;
  String notes;
  String arrivalTime;
  String resturant;

  Products(
      {this.productId,
      this.qty,
      this.packageId,
      this.shudderId,
      this.orderService,
      this.power,
      this.notes,
      this.arrivalTime,
      this.resturant});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    qty = json['qty'];
    packageId = json['package_id'];
    shudderId = json['shudder_id'];
    orderService = json['order_service'];
    power = json['power'];
    notes = json['notes'];
    arrivalTime = json['arrival_time'];
    resturant = json['resturant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['package_id'] = this.packageId;
    data['shudder_id'] = this.shudderId;
    data['order_service'] = this.orderService;
    data['power'] = this.power;
    data['notes'] = this.notes;
    data['arrival_time'] = this.arrivalTime;
    data['resturant'] = this.resturant;
    return data;
  }
}
