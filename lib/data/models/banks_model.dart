class BanksModel {
  String msg;
  List<BankData> data;

  BanksModel({this.msg, this.data});

  BanksModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<BankData>();
      json['data'].forEach((v) {
        data.add(new BankData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankData {
  int id;
  String name;
  String accoutNumber;
  String iban;
  String image;
  String createdAt;
  String updatedAt;

  BankData(
      {this.id,
      this.name,
      this.accoutNumber,
      this.iban,
      this.image,
      this.createdAt,
      this.updatedAt});

  BankData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    accoutNumber = json['accout_number'];
    iban = json['iban'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['accout_number'] = this.accoutNumber;
    data['iban'] = this.iban;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
