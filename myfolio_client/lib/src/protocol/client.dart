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
import 'dart:async' as _i2;
import 'package:myfolio_client/src/protocol/roles.dart' as _i3;
import 'package:myfolio_client/src/protocol/projects.dart' as _i4;
import 'package:myfolio_client/src/protocol/skills.dart' as _i5;
import 'package:myfolio_client/src/protocol/experience.dart' as _i6;
import 'package:myfolio_client/src/protocol/education.dart' as _i7;
import 'package:myfolio_client/src/protocol/users/user.dart' as _i8;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i9;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i10;
import 'protocol.dart' as _i11;

/// {@category Endpoint}
class EndpointFile extends _i1.EndpointRef {
  EndpointFile(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'file';

  /// Returns a signed URL for the user's resume.
  /// The file is expected to be uploaded to 'public' storage with path 'resume.pdf'.
  _i2.Future<String?> getResumeUrl() => caller.callServerEndpoint<String?>(
    'file',
    'getResumeUrl',
    {},
  );

  _i2.Future<String?> getUploadUrl(String path) =>
      caller.callServerEndpoint<String?>(
        'file',
        'getUploadUrl',
        {'path': path},
      );
}

/// {@category Endpoint}
class EndpointPortfolio extends _i1.EndpointRef {
  EndpointPortfolio(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'portfolio';

  _i2.Future<List<_i3.Roles>> getRoles() =>
      caller.callServerEndpoint<List<_i3.Roles>>(
        'portfolio',
        'getRoles',
        {},
      );

  _i2.Future<List<_i4.Project>> getProjectList() =>
      caller.callServerEndpoint<List<_i4.Project>>(
        'portfolio',
        'getProjectList',
        {},
      );

  _i2.Future<List<_i3.Roles>> createRoles() =>
      caller.callServerEndpoint<List<_i3.Roles>>(
        'portfolio',
        'createRoles',
        {},
      );

  _i2.Future<List<_i4.Project>> createProjects() =>
      caller.callServerEndpoint<List<_i4.Project>>(
        'portfolio',
        'createProjects',
        {},
      );

  _i2.Future<List<_i5.Skill>> createSkills() =>
      caller.callServerEndpoint<List<_i5.Skill>>(
        'portfolio',
        'createSkills',
        {},
      );

  _i2.Future<List<_i5.Skill>> getSkills() =>
      caller.callServerEndpoint<List<_i5.Skill>>(
        'portfolio',
        'getSkills',
        {},
      );

  _i2.Future<List<_i6.Experience>> createExperiences() =>
      caller.callServerEndpoint<List<_i6.Experience>>(
        'portfolio',
        'createExperiences',
        {},
      );

  _i2.Future<List<_i6.Experience>> getExperiences() =>
      caller.callServerEndpoint<List<_i6.Experience>>(
        'portfolio',
        'getExperiences',
        {},
      );

  _i2.Future<List<_i7.Education>> createEducations() =>
      caller.callServerEndpoint<List<_i7.Education>>(
        'portfolio',
        'createEducations',
        {},
      );

  _i2.Future<List<_i7.Education>> getEducations() =>
      caller.callServerEndpoint<List<_i7.Education>>(
        'portfolio',
        'getEducations',
        {},
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i8.User?> getUser() => caller.callServerEndpoint<_i8.User?>(
    'user',
    'getUser',
    {},
  );

  _i2.Future<void> createUser() => caller.callServerEndpoint<void>(
    'user',
    'createUser',
    {},
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i9.Caller(client);
    serverpod_auth_core = _i10.Caller(client);
  }

  late final _i9.Caller serverpod_auth_idp;

  late final _i10.Caller serverpod_auth_core;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i11.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    file = EndpointFile(this);
    portfolio = EndpointPortfolio(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointFile file;

  late final EndpointPortfolio portfolio;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'file': file,
    'portfolio': portfolio,
    'user': user,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
