/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Experience implements _i1.SerializableModel {
  Experience._({
    this.id,
    required this.duration,
    required this.company,
    required this.position,
  });

  factory Experience({
    int? id,
    required String duration,
    required String company,
    required String position,
  }) = _ExperienceImpl;

  factory Experience.fromJson(Map<String, dynamic> jsonSerialization) {
    return Experience(
      id: jsonSerialization['id'] as int?,
      duration: jsonSerialization['duration'] as String,
      company: jsonSerialization['company'] as String,
      position: jsonSerialization['position'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String duration;

  String company;

  String position;

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Experience copyWith({
    int? id,
    String? duration,
    String? company,
    String? position,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Experience',
      if (id != null) 'id': id,
      'duration': duration,
      'company': company,
      'position': position,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExperienceImpl extends Experience {
  _ExperienceImpl({
    int? id,
    required String duration,
    required String company,
    required String position,
  }) : super._(
         id: id,
         duration: duration,
         company: company,
         position: position,
       );

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Experience copyWith({
    Object? id = _Undefined,
    String? duration,
    String? company,
    String? position,
  }) {
    return Experience(
      id: id is int? ? id : this.id,
      duration: duration ?? this.duration,
      company: company ?? this.company,
      position: position ?? this.position,
    );
  }
}
