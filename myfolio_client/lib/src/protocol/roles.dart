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

abstract class Roles implements _i1.SerializableModel {
  Roles._({
    this.id,
    required this.title,
    required this.description,
    this.yearsOfExperience,
  });

  factory Roles({
    int? id,
    required String title,
    required String description,
    int? yearsOfExperience,
  }) = _RolesImpl;

  factory Roles.fromJson(Map<String, dynamic> jsonSerialization) {
    return Roles(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      yearsOfExperience: jsonSerialization['yearsOfExperience'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String description;

  int? yearsOfExperience;

  /// Returns a shallow copy of this [Roles]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Roles copyWith({
    int? id,
    String? title,
    String? description,
    int? yearsOfExperience,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Roles',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RolesImpl extends Roles {
  _RolesImpl({
    int? id,
    required String title,
    required String description,
    int? yearsOfExperience,
  }) : super._(
         id: id,
         title: title,
         description: description,
         yearsOfExperience: yearsOfExperience,
       );

  /// Returns a shallow copy of this [Roles]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Roles copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    Object? yearsOfExperience = _Undefined,
  }) {
    return Roles(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      yearsOfExperience: yearsOfExperience is int?
          ? yearsOfExperience
          : this.yearsOfExperience,
    );
  }
}
