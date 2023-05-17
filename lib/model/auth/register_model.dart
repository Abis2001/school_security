class RegisterModel{
  String? message;
  RegisterModel({ this.message});
  factory RegisterModel.fromMap(Map<String,dynamic> json)=>
  RegisterModel(
    message: json['message']??'null'
  );
}
/*

{
    "message": "User created successfully."
}

{
    "code": 409,
    "message": "A user with that email already exists.",
    "status": "Conflict"
}

{
    "phoneNumber": "0000000000",
    "role": 1,
    "status": false,
    "user_id": 3,
    "username": "ex"
}
*/