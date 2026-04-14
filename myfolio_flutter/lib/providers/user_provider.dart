import 'package:flutter/material.dart';
import 'dart:io';
import 'package:myfolio_client/myfolio_client.dart';

import 'package:myfolio_flutter/main.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    _fetchUserOverview();
    fetchRoles();
    fetchProjects();
    fetchExperiences();
    fetchEducations();
    fetchSkills();
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

  Future<void> fetchSkills() async {
    try {
      List<Skill> skills = await client.portfolio.getSkills();
      _skills = skills;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching skills: $e');
      rethrow;
    }
  }

  Future<void> createSkills() async {
    try {
      await client.portfolio.createSkills();
      fetchSkills();
    } catch (e) {
      debugPrint('Error creating skills: $e');
      rethrow;
    }
  }

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

  Future<void> createProjects() async {
    try {
      await client.portfolio.createProjects();
      await fetchProjects();
      // Optionally, fetch updated work skills here
    } catch (e) {
      debugPrint('Error creating work skill: $e');
      rethrow;
    }
  }

  Future<void> fetchProjects() async {
    try {
      List<Project> projects = await client.portfolio.getProjectList();
      _projects = projects;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching projects: $e');
      rethrow;
    }
  }

  Future<void> addUserData() async {
    try {
      await client.user.createUser();
      await _fetchUserOverview();
      await fetchRoles();
    } catch (e) {
      debugPrint('Error creating user: $e');
    }
  }

  Future<void> _fetchUserOverview() async {
    try {
      isLoading = true;
      User? user = await client.user.getUser();
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching user overview: $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> fetchRoles() async {
    try {
      List<Roles> roles = await client.portfolio.getRoles();
      _roles = roles;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching skills: $e');
      rethrow;
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
      List<Experience> experiences = await client.portfolio.getExperiences();
      _experiences = experiences;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching experiences: $e');
      rethrow;
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
      List<Education> educations = await client.portfolio.getEducations();
      _educations = educations;
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching educations: $e');
      rethrow;
    }
  }
}
