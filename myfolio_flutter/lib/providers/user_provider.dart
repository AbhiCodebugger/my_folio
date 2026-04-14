import 'package:flutter/material.dart';
import 'dart:io';
import 'package:myfolio_client/myfolio_client.dart';

import 'package:myfolio_flutter/main.dart';

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

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  int selectedTabIndex = 0;

  void selectTab(int index) {
    selectedTabIndex = index;
    notifyListeners();
  }

  Future<void> init() async {
    try {
      isLoading = true;
      // Fetch everything in parallel
      await Future.wait([
        fetchUserOverview(),
        fetchRoles(),
        fetchProjects(),
        fetchExperiences(),
        fetchEducations(),
        fetchSkills(),
      ]);
    } catch (e) {
      debugPrint('Error during initialization: $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchSkills() async {
    try {
      _skills = await client.portfolio.getSkills();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching skills: $e');
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

  Future<void> fetchProjects() async {
    try {
      _projects = await client.portfolio.getProjectList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching projects: $e');
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

  Future<void> fetchUserOverview() async {
    try {
      User? result = await client.user.getUser();
      if (result != null) {
        _user = result;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching user overview: $e');
    }
  }

  Future<void> fetchRoles() async {
    try {
      _roles = await client.portfolio.getRoles();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching roles: $e');
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

  Future<void> fetchExperiences() async {
    try {
      _experiences = await client.portfolio.getExperiences();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching experiences: $e');
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

  Future<void> fetchEducations() async {
    try {
      _educations = await client.portfolio.getEducations();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching educations: $e');
    }
  }
}
