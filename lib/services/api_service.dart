import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jaksimsamil/models/proof_model.dart';
import '../models/challenge_model.dart';
import '../utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;

class ApiService {
  static const String baseUrl = 'https://backend-r08l.onrender.com';

  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  List<ChallengeModel> challenges = []; //전역변수
  ChallengeModel? currentChallenge; // 현재 진행 중인 챌린지

  Future<void> signUp({
    required String nickname,
    required String email,
    required String pw,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nickname': nickname, 'email': email, 'pw': pw}),
    );

    logger.d('Status Code : ${response.statusCode}');

    if (response.statusCode == 201) {
      print('계정 생성 성공');
    } else {
      print('계정생성 실패');
    }
  }

  Future<void> signIn({required String email, required String pw}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/auth/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': email, 'pw': pw}),
    );

    logger.d('Status Code : ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['jwttoken'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', token);

      print('로그인 성공');
    } else {
      print('로그인 실패');
      throw Exception(response.statusCode);
    }
  }

  Future<ChallengeModel> createChallenge({
    required String title,
    required String plan,
    required String category,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      logger.d('챌린지 생성 실패');
      throw Exception('챌린지 생성 실패');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/challenges'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'title': title, 'goal': category, 'plan': plan}),
    );

    print('📦 응답 전체: ${response.body}');

    if (response.statusCode == 201) {
      final newChallenge = ChallengeModel.fromJson(jsonDecode(response.body));

      challenges.add(newChallenge);

      currentChallenge = newChallenge;

      return newChallenge;
    } else {
      throw Exception('챌린지 생성 실패');
    }
  }

  Future<List<dynamic>> getChallenges() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/challenges'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('📦 전체 응답: ${response.body}');

        final decoded = jsonDecode(response.body);

        List<dynamic> jsonList = decoded['challenges'];

        if (jsonList == []) {
          logger.d('챌린지x');
          return [];
        }

        challenges = jsonList
            .map((json) => ChallengeModel.fromJson(json))
            .toList();
        logger.d('불러오기 성공');

        return challenges;
      } else {
        throw Exception('Failed to load challenges : ${response.statusCode}');
      }
    } catch (e) {
      logger.d(e);
      throw Exception('Api Error: $e');
    }
  }

  Future<void> uploadProof({
    required String challengeId,
    required int dayIndex,
    required File imageFile,
  }) async {
    try {
      var imageBytes = await imageFile.readAsBytes();
      var image = img.decodeImage(imageBytes);

      var resized = img.copyResize(image!, width: 800);
      var compressedBytes = img.encodeJpg(resized, quality: 85);

      String base64Image = base64Encode(compressedBytes);



      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/challenges/$challengeId/proof'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'dayIndex': dayIndex, 'imageBase64': base64Image}),
      );

      if (response.statusCode == 200) {
        logger.d('이미지 업로드 완료');
      } else {
        throw Exception('업로드 실패 : ${response.statusCode}');
      }
    } catch (e) {
      logger.d(e);
    }
  }

  Future<void> completeChallenges({required String id}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/challenges/{$id}/complete'),
    );

    if (response.statusCode == 200) {
      logger.d("성공 처리 완료");
      currentChallenge = null;
    } else {
      throw Exception('성공 처리 실패 : ${response.statusCode}');
    }
  }

  Future<void> deleteData(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    try {
      logger.d('삭제 시작');
      final response = await http.delete(
        Uri.parse('$baseUrl/api/v1/challenges/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        print('삭제 성공');
      } else if (response.statusCode == 404) {
        print('삭제 실패: 챌린지가 발견되지 않음. ${response.statusCode}');
        throw Exception('Failed to delete data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<ProofModel> getUploadProof({
    required String id,
    required int dayIndex,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/challenges/$id/proof/$dayIndex'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        logger.d('이미지 불러오기 성공');

        ProofModel proofModel = ProofModel.fromJson(jsonDecode(response.body));

        return proofModel;
      } else {
        throw Exception('업로드 실패 : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('업로드 실패');
      logger.d(e);
    }
  }

  Future<void> resetChallenge({
    required String id,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/v1/challenges/{$id}/reset'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        logger.d('리셋 성공!');


      } else {
        throw Exception('리셋 실패 : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('리셋 실패');
    }
  }

  Future<ChallengeModel?> getChallengeById(String Id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/challenges/$Id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ChallengeModel.fromJson(data);
      } else if (response.statusCode == 404) {
        logger.d('챌린지를 찾을 수 없음');
        return null;
      } else {
        throw Exception('챌린지 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      logger.d('에러: $e');
      return null;
    }
  }
}



