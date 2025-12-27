// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserChatAdapter extends TypeAdapter<UserChat> {
  @override
  final int typeId = 2;

  @override
  UserChat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserChat(
      userId: fields[0] as String,
      messages: (fields[1] as List).cast<ChatMessage>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserChat obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserChatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
