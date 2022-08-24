import 'dart:convert';
import 'package:la_vie/core/network/api_constance.dart';
import 'package:la_vie/core/utils/cache_helper.dart';
import 'package:la_vie/data/models/blog_model.dart';
import 'package:la_vie/data/models/discussion_forum_model.dart';
import 'package:la_vie/data/models/forum_model.dart';
import 'package:la_vie/data/models/plant_model.dart';
import 'package:la_vie/data/models/seed_model.dart';
import 'package:la_vie/data/models/tool_model.dart';
import 'package:la_vie/data/models/user_model.dart';
import 'package:la_vie/domain/entities/forum.dart';
import 'package:la_vie/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:la_vie/presentation/resources/assets_manager.dart';

abstract class BaseRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String firstName, String lastName, String email, String password);
  Future<UserModel> updateUser(String firstName, String lastName, String email, String? address);
  Future<List<PlantModel>> getPlants();
  Future<List<SeedModel>> getSeeds();
  Future<List<ToolModel>> getTools();
  Future<List<DiscussionForumModel>> getDiscussionForum();
  Future<Forum> createForumPost(String title, String description, String imageBase64);
  Future<BlogModel> getBlogs();
}

class RemoteDataSource extends BaseRemoteDataSource{

  @override
  Future<UserModel> login(String email, String password) async {
    http.Response response = await http.post(Uri.parse(ApiConstance.loginPath), body: {
      'email': email,
      'password': password,
    });
    if(response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw(response.reasonPhrase ?? 'An error occurred');
    }
  }

  @override
  Future<UserModel> register(String firstName, String lastName, String email, String password) async {
    http.Response response = await http.post(Uri.parse(ApiConstance.registerPath), body: {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    });
    if(response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw(response.reasonPhrase ?? 'An error occurred');
    }
  }

  @override
  Future<UserModel> updateUser(String firstName, String lastName, String email, String? address) async {
    User user = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.accessToken}',
    };
    http.Response response = await http.patch(Uri.parse(ApiConstance.updateUserPath), headers: headers, body: {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
    });
    if(response.statusCode == 200) {
      return UserModel.fromJsonWithoutUserKey(jsonDecode(response.body), user.accessToken);
    } else {
      throw(response.reasonPhrase ?? 'An error occurred');
    }
  }

  @override
  Future<List<PlantModel>> getPlants() async {
    User user = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.accessToken}',
    };
    http.Response response = await http.get(Uri.parse(ApiConstance.getPlantsPath), headers: headers);
    if(response.statusCode == 200) {
      return List<PlantModel>.from((jsonDecode(response.body)['data'] as List).map((e) => PlantModel.fromJson(e)));
    } else {
      throw(response.reasonPhrase ?? 'An error occurred');
    }
  }

  @override
  Future<List<SeedModel>> getSeeds() async {
    User user = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
    Map<String, String> headers = {
    'Accept': 'application/json',
    'Authorization': 'Bearer ${user.accessToken}',
    };
    http.Response response = await http.get(Uri.parse(ApiConstance.getSeedsPath), headers: headers);
    if(response.statusCode == 200) {
    return List<SeedModel>.from((jsonDecode(response.body)['data'] as List).map((e) => SeedModel.fromJson(e)));
    } else {
    throw(response.reasonPhrase ?? 'An error occurred');
    }
  }

  @override
  Future<List<ToolModel>> getTools() async {
    User user = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.accessToken}',
    };
    http.Response response = await http.get(Uri.parse(ApiConstance.getToolsPath), headers: headers);
    if(response.statusCode == 200) {
      return List<ToolModel>.from((jsonDecode(response.body)['data'] as List).map((e) => ToolModel.fromJson(e)));
    } else {
      throw(response.reasonPhrase ?? 'An error occurred');
    }
  }

  @override
  Future<List<DiscussionForumModel>> getDiscussionForum() async {
    User user = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.accessToken}',
    };
    http.Response response = await http.get(Uri.parse(ApiConstance.getDiscussionForumsPath), headers: headers);
    if(response.statusCode == 200) {
      return List<DiscussionForumModel>.from((jsonDecode(response.body)['data'] as List).map((e) => DiscussionForumModel.fromJson(e)));
    } else {
      throw(response.reasonPhrase ?? 'An error occurred');
    }
  }

  @override
  Future<BlogModel> getBlogs() async {
    User user = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.accessToken}',
    };
    http.Response response = await http.get(Uri.parse(ApiConstance.getBlogsPath), headers: headers);
    if(response.statusCode == 200) {
      List<PlantModel> plants = List<PlantModel>.from((jsonDecode(response.body)['data']['plants'] as List).map((e) => PlantModel.fromJson(e)));
      List<SeedModel> seeds = List<SeedModel>.from((jsonDecode(response.body)['data']['seeds'] as List).map((e) => SeedModel.fromJson(e)));
      List<ToolModel> tools = List<ToolModel>.from((jsonDecode(response.body)['data']['tools'] as List).map((e) => ToolModel.fromJson(e)));
      return BlogModel(plants: plants, seeds: seeds, tools: tools);
    } else {
      throw(response.reasonPhrase ?? 'An error occurred');
    }
  }

  @override
  Future<Forum> createForumPost(String title, String description, String imageBase64) async {
    User user = UserModel.fromLocalJson(json.decode(CacheHelper.getData(key: PREFERENCES_KEY_USER_DATA)));
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.accessToken}',
    };
    http.Response response = await http.post(Uri.parse(ApiConstance.createPostPath), headers: headers, body: {
      'title': title,
      'description': description,
      'imageBase64': imagePath,
    });
    if(response.statusCode == 200) {
      return ForumModel.fromJson(jsonDecode(response.body));
    } else {
      throw(response.reasonPhrase ?? 'An error occurred');
    }
  }
}