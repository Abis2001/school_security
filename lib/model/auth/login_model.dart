class LoginModel{
  String? phoneNumber;
  int? role;
  dynamic? status;
  int? userId;
  String? username;
  String? message;

  LoginModel({this.phoneNumber,this.role,this.status,this.userId,this.username,this.message});

  factory LoginModel.fromMap(Map<String,dynamic> json)=>
  LoginModel(
    phoneNumber: json['phoneNumber']??'null',
    role: json['role']??0,
    status: json['status']??null,
    userId: json['user_id']??0,
    username: json['username']??'null',
    message: json['message']??'null'
  );
}
/*
{
    "phoneNumber": "0000000000",
    "role": 1,
    "status": false,
    "user_id": 3,
    "username": "ex"
}
*/