// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cameraApp.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CameraAppAdapter extends TypeAdapter<CameraApp> {
  @override
  final int typeId = 1;

  @override
  CameraApp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CameraApp(
      imageUrl: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CameraApp obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CameraAppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
