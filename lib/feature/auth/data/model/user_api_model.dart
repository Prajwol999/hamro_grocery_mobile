// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// import '../../domain/entity/auth_entity.dart';



// part 'user_api_model.g.dart';

// @JsonSerializable()
// class UserApiModel extends Equatable {
  
//   @JsonKey(name: '_id', includeIfNull: false)
//   final String? id;

//   @JsonKey(name: 'fullName')
//   final String fullName;

//   final String email;
//   final String? password;

//   const UserApiModel({
//     this.id,
//     required this.fullName,
//     required this.email,
    
//     this.password,
//   });

//   factory UserApiModel.fromJson(Map<String, dynamic> json) =>
//       _$UserApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  
//   AuthEntity toEntity() {
//     return AuthEntity(
//       userId: id,
//       fullName: fullName,
//       email: email,
//       password: password ?? '',
//     );
//   }

  
//   factory UserApiModel.fromEntity(AuthEntity entity) {
//     return UserApiModel(
      
//       id: entity.userId,
//       fullName: entity.fullName,
//       email: entity.email,
//       password: entity.password,
//     );
//   }

//   @override
  
//   List<Object?> get props => [id, fullName, password, email];
// }