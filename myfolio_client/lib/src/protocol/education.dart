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

abstract class Education implements _i1.SerializableModel {
  Education._({
    this.id,
    required this.duration,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    this.grade,
    int? displayOrder,
  }) : displayOrder = displayOrder ?? 0;

  factory Education({
    int? id,
    required String duration,
    required String institution,
    required String degree,
    required String fieldOfStudy,
    String? grade,
    int? displayOrder,
  }) = _EducationImpl;

  factory Education.fromJson(Map<String, dynamic> jsonSerialization) {
    return Education(
      id: jsonSerialization['id'] as int?,
      duration: jsonSerialization['duration'] as String,
      institution: jsonSerialization['institution'] as String,
      degree: jsonSerialization['degree'] as String,
      fieldOfStudy: jsonSerialization['fieldOfStudy'] as String,
      grade: jsonSerialization['grade'] as String?,
      displayOrder: jsonSerialization['displayOrder'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String duration;

  String institution;

  String degree;

  String fieldOfStudy;

  String? grade;

  int? displayOrder;

  /// Returns a shallow copy of this [Education]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Education copyWith({
    int? id,
    String? duration,
    String? institution,
    String? degree,
    String? fieldOfStudy,
    String? grade,
    int? displayOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Education',
      if (id != null) 'id': id,
      'duration': duration,
      'institution': institution,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      if (grade != null) 'grade': grade,
      if (displayOrder != null) 'displayOrder': displayOrder,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EducationImpl extends Education {
  _EducationImpl({
    int? id,
    required String duration,
    required String institution,
    required String degree,
    required String fieldOfStudy,
    String? grade,
    int? displayOrder,
  }) : super._(
         id: id,
         duration: duration,
         institution: institution,
         degree: degree,
         fieldOfStudy: fieldOfStudy,
         grade: grade,
         displayOrder: displayOrder,
       );

  /// Returns a shallow copy of this [Education]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Education copyWith({
    Object? id = _Undefined,
    String? duration,
    String? institution,
    String? degree,
    String? fieldOfStudy,
    Object? grade = _Undefined,
    Object? displayOrder = _Undefined,
  }) {
    return Education(
      id: id is int? ? id : this.id,
      duration: duration ?? this.duration,
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      grade: grade is String? ? grade : this.grade,
      displayOrder: displayOrder is int? ? displayOrder : this.displayOrder,
    );
  }
}
