
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';
@JsonSerializable()
class BaseResponse{
  @JsonKey(name:"status")
  int? status;
  @JsonKey(name:"name")
  String? name;
  @JsonKey(name:"message")
  String? message;



  // BaseResponse(this.message, this.name);
  // factory BaseResponse.fromJson(Map<String,dynamic> json)=> _$BaseResponseFromJson(json);
  // Map<String,dynamic> toJson()=> _$BaseResponseToJson(this);
}
@JsonSerializable()
class CustomerResponse{
  @JsonKey(name:"id")
  String? id;
  @JsonKey(name:"name")
  String? name;
  @JsonKey(name:"numOfNotifications")
  int? numOfNotifications;

  CustomerResponse(this.id, this.name, this.numOfNotifications);
  factory CustomerResponse.fromJson(Map<String,dynamic> json)=> _$CustomerResponseFromJson(json);
  Map<String,dynamic> toJson()=> _$CustomerResponseToJson(this);
}
@JsonSerializable()
class ContactResponse{
  @JsonKey(name:"email")
  String? email;
  @JsonKey(name:"link")
  String? link;
  @JsonKey(name:"phone")
  String? phone;

  ContactResponse(this.email, this.link, this.phone);
  factory ContactResponse.fromJson(Map<String,dynamic> json)=> _$ContactResponseFromJson(json);
  Map<String,dynamic> toJson()=> _$ContactResponseToJson(this);
}
@JsonSerializable()
class AuthenticationResponse extends BaseResponse{
  @JsonKey(name:"customer")
  CustomerResponse? customer;
  @JsonKey (name:"contacts")
  ContactResponse? contacts;

  AuthenticationResponse(this.customer, this.contacts)  ;
  factory AuthenticationResponse.fromJson(Map<String,dynamic> json)=> _$AuthenticationResponseFromJson(json);
  Map<String,dynamic> toJson()=> _$AuthenticationResponseToJson(this);
}

