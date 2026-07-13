import 'package:flutter/material.dart';
import 'dart:io';
import 'package:myfolio_client/myfolio_client.dart';

import 'package:myfolio_flutter/bootstrap.dart';
import 'package:myfolio_flutter/utils/retry.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    init();
  }
  static String urlPrefix = 'assets/images';

  User? _user;
  User? get user => _user;

  List<Roles> _roles = [];
  List<Roles> get roles => _roles;

  List<Project> _projects = [];
  List<Project> get projects => _projects;

  List<Skill> _skills = [];
  List<Skill> get skills => _skills;

  List<Experience> _experiences = [];
  List<Experience> get experiences => _experiences;

  List<Education> _educations = [];
  List<Education> get educations => _educations;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _loadFailed = false;
  bool get loadFailed => _loadFailed;

  String _loadingMessage = 'Loading...';
  String get loadingMessage => _loadingMessage;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int selectedTabIndex = 0;

  void selectTab(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }

  Future<void> retry() => init();

  Future<void> init() async {
    _loadFailed = false;
    _loadingMessage = 'Loading...';
    isLoading = true;

    final loaded = await retryUntilSuccess(
      maxAttempts: 12,
      delay: const Duration(seconds: 5),
      onRetry: (attempt) {
        _loadingMessage = 'Connecting to server...';
        notifyListeners();
        debugPrint('Server not ready, retrying ($attempt/11)...');
      },
      action: _loadAllData,
    );

    if (!loaded) {
      _loadFailed = true;
      _loadingMessage = 'Could not reach server';
      debugPrint('Failed to load data after all retry attempts.');
    }

    isLoading = false;
  }

  Future<bool> _loadAllData() async {
    final results = await Future.wait([
      fetchUserOverview(),
      fetchRoles(),
      fetchProjects(),
      fetchExperiences(),
      fetchEducations(),
      fetchSkills(),
    ]);

    return results.every((success) => success);
  }

  Future<bool> fetchSkills() async {
    try {
      _skills = await client.portfolio.getSkills();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error fetching skills: $e');
      return false;
    }
  }

  Future<void> createSkills() async {
    try {
      await client.portfolio.createSkills();
      await fetchSkills();
    } catch (e) {
      debugPrint('Error creating skills: $e');
      rethrow;
    }
  }

  Future<void> createProjects() async {
    try {
      await client.portfolio.createProjects();
      await fetchProjects();
    } catch (e) {
      debugPrint('Error creating projects: $e');
      rethrow;
    }
  }

  Future<bool> fetchProjects() async {
    try {
      _projects = await client.portfolio.getProjectList();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error fetching projects: $e');
      return false;
    }
  }

  Future<void> addUserData() async {
    try {
      await client.user.createUser();
      await init();
    } catch (e) {
      debugPrint('Error creating user: $e');
    }
  }

  Future<bool> fetchUserOverview() async {
    try {
      User? result = await client.user.getUser();
      if (result != null) {
        _user = result;
        notifyListeners();
      }
      return true;
    } catch (e) {
      debugPrint('Error fetching user overview: $e');
      return false;
    }
  }

  Future<bool> fetchRoles() async {
    try {
      _roles = await client.portfolio.getRoles();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error fetching roles: $e');
      return false;
    }
  }

  Future<void> createRoles() async {
    try {
      await client.portfolio.createRoles();
      await fetchRoles();
    } catch (e) {
      debugPrint('Error creating skill: $e');
      rethrow;
    }
  }

  Future<bool> uploadResume(File file) async {
    try {
      isLoading = true;

      // 1. Get upload URL
      var uploadUrl = await client.file.getUploadUrl('resume.pdf');
      if (uploadUrl == null) {
        debugPrint('Failed to get upload URL');
        return false;
      }

      // 2. Upload file
      var request = await HttpClient().putUrl(Uri.parse(uploadUrl));
      request.headers.add(HttpHeaders.contentTypeHeader, 'application/pdf');
      request.headers.contentLength = await file.length();
      await request.addStream(file.openRead());
      var response = await request.close();

      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error uploading resume: $e');
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<String?> getResumeUrl() async {
    try {
      return await client.file.getResumeUrl();
    } catch (e) {
      debugPrint('Error fetching resume url: $e');
      return null;
    }
  }

  Future<bool> fetchExperiences() async {
    try {
      _experiences = await client.portfolio.getExperiences();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error fetching experiences: $e');
      return false;
    }
  }

  Future<void> createExperiences() async {
    try {
      await client.portfolio.createExperiences();
      await fetchExperiences();
    } catch (e) {
      debugPrint('Error creating experiences: $e');
      rethrow;
    }
  }

  Future<void> createEducations() async {
    try {
      await client.portfolio.createEducations();
      await fetchEducations();
    } catch (e) {
      debugPrint('Error creating educations: $e');
      rethrow;
    }
  }

  Future<bool> fetchEducations() async {
    try {
      _educations = await client.portfolio.getEducations();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error fetching educations: $e');
      return false;
    }
  }
}
