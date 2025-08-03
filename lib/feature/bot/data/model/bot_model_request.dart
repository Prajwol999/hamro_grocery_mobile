import 'package:hamro_grocery_mobile/feature/bot/domain/entity/bot_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bot_model_request.g.dart';

@JsonSerializable(
  explicitToJson: true,
) 
class ChatRequestModel {
  final String query;
  final List<HistoryMessageModel> history;

  ChatRequestModel({required this.query, required this.history});

  
  factory ChatRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestModelFromJson(json);

  
  Map<String, dynamic> toJson() => _$ChatRequestModelToJson(this);

  
  factory ChatRequestModel.fromEntities({
    required String query,
    required List<ChatMessageEntity> historyEntities,
  }) {
    return ChatRequestModel(
      query: query,
      history:
          historyEntities
              .map((entity) => HistoryMessageModel.fromEntity(entity))
              .toList(),
    );
  }
}


@JsonSerializable()
class HistoryMessageModel {
  final String role;
  final String text;

  HistoryMessageModel({required this.role, required this.text});

  
  factory HistoryMessageModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryMessageModelToJson(this);

  
  factory HistoryMessageModel.fromEntity(ChatMessageEntity entity) {
    return HistoryMessageModel(
      role: entity.role.name, 
      text: entity.text,
    );
  }
}
