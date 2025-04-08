// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UrlHistoryAdapter extends TypeAdapter<UrlHistory> {
  @override
  final int typeId = 0;

  @override
  UrlHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UrlHistory(
      site: fields[0] as String,
      originalUrl: fields[1] as String,
      shortUrl: fields[2] as String,
      lastChecked: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UrlHistory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.site)
      ..writeByte(1)
      ..write(obj.originalUrl)
      ..writeByte(2)
      ..write(obj.shortUrl)
      ..writeByte(3)
      ..write(obj.lastChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UrlHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
