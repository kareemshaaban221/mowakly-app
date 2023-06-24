

class LoginModel{
  void status;
  String ?message;
  String ?token;
  UserData ?data;
  LoginModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    token=json['token'];
    data=UserData.fromJson(json['data']);

  }

}
class UserData{
  int ?id ;
  String ?fname;
  String ? lname;
  String ?email;
  var  email_verified_at='null';
  String? gender;
  var date_of_birth;
  var avatar;
  String ?phone;
  List phones=[];
  var  remember_token ='null';
  String ? created_at ;
  String ?updated_at;
  List payment_methods=[];

  // UserData({
  //  this.id,
  //  this.fname,
  //  this.lname,
  //  this.email,
  //  this.gender,
  //  this.date_of_birth,
  //  this.phone,
  //  this.created_at,
  //  this.updated_at,
  // });

  UserData.fromJson(Map<String,dynamic>json){
    id=json['id'];
    fname=json['fname'];
    lname=json['lname'];
    email=json['email'];
    gender=json['gender'];
    date_of_birth=json['date_of_birth'];
    phone=json['phone'];
    phones=json['phones']==null?[]:json['phones'];
    created_at=json['created_at'];
    updated_at=json['updated_at'];
  }
}