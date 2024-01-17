class LoginModel {
  String? status;
  String? token;
  UserData? data;

  LoginModel({this.status, this.token, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;

  UserData({this.email, this.firstName, this.lastName, this.mobile, this.photo});

  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['photo'] = this.photo;
    return data;
  }
}



// class LoginModel {
//   String? status;
//   String? token;
//   Data? data;
//
//   LoginModel({this.status, this.token, this.data});
//
//   LoginModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     token = json['token'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['token'] = this.token;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? username;
//   String? email;
//   String? firstName;
//   String? lastName;
//   bool? isStaff;
//   bool? isSuperuser;
//   bool? isActive;
//   String? dateJoined;
//
//   Data(
//       {this.id,
//         this.username,
//         this.email,
//         this.firstName,
//         this.lastName,
//         this.isStaff,
//         this.isSuperuser,
//         this.isActive,
//         this.dateJoined});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'];
//     email = json['email'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     isStaff = json['is_staff'];
//     isSuperuser = json['is_superuser'];
//     isActive = json['is_active'];
//     dateJoined = json['date_joined'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['email'] = this.email;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['is_staff'] = this.isStaff;
//     data['is_superuser'] = this.isSuperuser;
//     data['is_active'] = this.isActive;
//     data['date_joined'] = this.dateJoined;
//     return data;
//   }
// }
