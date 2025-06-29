import 'package:json_annotation/json_annotation.dart';
part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignUpRequestBody {
  @JsonKey(name: 'username')
  final String userName;
  final String email;
  final String password;
 

  SignUpRequestBody({
    required this.userName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$SignUpRequestBodyToJson(this);
}
