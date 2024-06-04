// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportDbAdapter extends TypeAdapter<ReportDb> {
  @override
  final int typeId = 1;

  @override
  ReportDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReportDb(
      id_support: fields[0] as int,
      id_client: fields[1] as int,
      problem: fields[2] as String,
      time_started: fields[3] as DateTime,
      time_end: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ReportDb obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id_support)
      ..writeByte(1)
      ..write(obj.id_client)
      ..writeByte(2)
      ..write(obj.problem)
      ..writeByte(3)
      ..write(obj.time_started)
      ..writeByte(4)
      ..write(obj.time_end);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
