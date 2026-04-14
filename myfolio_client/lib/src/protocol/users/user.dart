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
import 'package:myfolio_client/src/protocol/protocol.dart' as _i2;

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.name,
    required this.title,
    required this.summary,
    required this.imagePath,
    required this.socialUrls,
    required this.phoneNumber,
    required this.email,
    required this.location,
    required this.resumeUrl,
  });

  factory User({
    int? id,
    required String name,
    required String title,
    required String summary,
    required String imagePath,
    required List<String> socialUrls,
    required String phoneNumber,
    required String email,
    required String location,
    required String resumeUrl,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      title: jsonSerialization['title'] as String,
      summary: jsonSerialization['summary'] as String,
      imagePath: jsonSerialization['imagePath'] as String,
      socialUrls: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['socialUrls'],
      ),
      phoneNumber: jsonSerialization['phoneNumber'] as String,
      email: jsonSerialization['email'] as String,
      location: jsonSerialization['location'] as String,
      resumeUrl: jsonSerialization['resumeUrl'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String title;

  String summary;

  String imagePath;

  List<String> socialUrls;

  String phoneNumber;

  String email;

  String location;

  String resumeUrl;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? name,
    String? title,
    String? summary,
    String? imagePath,
    List<String>? socialUrls,
    String? phoneNumber,
    String? email,
    String? location,
    String? resumeUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      'name': name,
      'title': title,
      'summary': summary,
      'imagePath': imagePath,
      'socialUrls': socialUrls.toJson(),
      'phoneNumber': phoneNumber,
      'email': email,
      'location': location,
      'resumeUrl': resumeUrl,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String name,
    required String title,
    required String summary,
    required String imagePath,
    required List<String> socialUrls,
    required String phoneNumber,
    required String email,
    required String location,
    required String resumeUrl,
  }) : super._(
         id: id,
         name: name,
         title: title,
         summary: summary,
         imagePath: imagePath,
         socialUrls: socialUrls,
         phoneNumber: phoneNumber,
         email: email,
         location: location,
         resumeUrl: resumeUrl,
       );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? name,
    String? title,
    String? summary,
    String? imagePath,
    List<String>? socialUrls,
    String? phoneNumber,
    String? email,
    String? location,
    String? resumeUrl,
  }) {
    return User(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      imagePath: imagePath ?? this.imagePath,
      socialUrls: socialUrls ?? this.socialUrls.map((e0) => e0).toList(),
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      location: location ?? this.location,
      resumeUrl: resumeUrl ?? this.resumeUrl,
    );
  }
}
