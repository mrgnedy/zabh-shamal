class UpdateCartModel {
   String msg;
   String data;

  UpdateCartModel({this.msg, this.data});
  UpdateCartModel.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
    data = json['data'];
  }
}