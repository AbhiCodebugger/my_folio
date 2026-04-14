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
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/file_endpoint.dart' as _i2;
import '../endpoints/portfolio_endpoint.dart' as _i3;
import '../endpoints/user_endpoint.dart' as _i4;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i5;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'file': _i2.FileEndpoint()
        ..initialize(
          server,
          'file',
          null,
        ),
      'portfolio': _i3.PortfolioEndpoint()
        ..initialize(
          server,
          'portfolio',
          null,
        ),
      'user': _i4.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['file'] = _i1.EndpointConnector(
      name: 'file',
      endpoint: endpoints['file']!,
      methodConnectors: {
        'getResumeUrl': _i1.MethodConnector(
          name: 'getResumeUrl',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['file'] as _i2.FileEndpoint).getResumeUrl(session),
        ),
        'getUploadUrl': _i1.MethodConnector(
          name: 'getUploadUrl',
          params: {
            'path': _i1.ParameterDescription(
              name: 'path',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['file'] as _i2.FileEndpoint).getUploadUrl(
                session,
                params['path'],
              ),
        ),
      },
    );
    connectors['portfolio'] = _i1.EndpointConnector(
      name: 'portfolio',
      endpoint: endpoints['portfolio']!,
      methodConnectors: {
        'getRoles': _i1.MethodConnector(
          name: 'getRoles',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .getRoles(session),
        ),
        'getProjectList': _i1.MethodConnector(
          name: 'getProjectList',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .getProjectList(session),
        ),
        'createRoles': _i1.MethodConnector(
          name: 'createRoles',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .createRoles(session),
        ),
        'createProjects': _i1.MethodConnector(
          name: 'createProjects',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .createProjects(session),
        ),
        'createSkills': _i1.MethodConnector(
          name: 'createSkills',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .createSkills(session),
        ),
        'getSkills': _i1.MethodConnector(
          name: 'getSkills',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .getSkills(session),
        ),
        'createExperiences': _i1.MethodConnector(
          name: 'createExperiences',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .createExperiences(session),
        ),
        'getExperiences': _i1.MethodConnector(
          name: 'getExperiences',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .getExperiences(session),
        ),
        'createEducations': _i1.MethodConnector(
          name: 'createEducations',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .createEducations(session),
        ),
        'getEducations': _i1.MethodConnector(
          name: 'getEducations',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['portfolio'] as _i3.PortfolioEndpoint)
                  .getEducations(session),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getUser': _i1.MethodConnector(
          name: 'getUser',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i4.UserEndpoint).getUser(session),
        ),
        'createUser': _i1.MethodConnector(
          name: 'createUser',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['user'] as _i4.UserEndpoint).createUser(session),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i5.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i6.Endpoints()
      ..initializeEndpoints(server);
  }
}
