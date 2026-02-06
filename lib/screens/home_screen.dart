import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:three_day/utils/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _challengeNameEditingController =
  TextEditingController();
  TextEditingController _challengeGoalController = TextEditingController();
  TextEditingController _challengePlanController = TextEditingController();
  late AutovalidateMode _autovalidateMode;

  late bool _isEnavled;



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _challengePlanController.dispose();
    _challengeNameEditingController.dispose();
    _challengeGoalController.dispose();
  }



  void challengeDialog() {
    setState(() {
      _challengeNameEditingController.clear();
      _challengeGoalController.clear();
      _challengePlanController.clear();
      _isEnavled = true;
      _autovalidateMode = AutovalidateMode.disabled;
      _globalKey = GlobalKey<FormState>();
    });
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Form(
            autovalidateMode: _autovalidateMode,
            key: _globalKey,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFD9EAFF),
                borderRadius: BorderRadius.circular(30),
              ),
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.65,

              padding: EdgeInsets.all(9),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      '작심삼일 챌린지 생성',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildInputSection(
                    editingController: _challengeNameEditingController,
                    title: '챌린지 이름',
                    hint: '챌린지 생성이름을 작성 해주세요.',
                    number: '1',

                  ),
                  SizedBox(height: 12),
                  _buildInputSection(
                    editingController: _challengeGoalController,
                    title: '카테고리',
                    hint: 'ex) 다이어트, 건강, 취미, 자기개발',
                    number: '2',
                  ),
                  SizedBox(height: 12),
                  _buildInputSection(
                    editingController: _challengePlanController,
                    title: '챌린지 이름',
                    hint: 'ex) 스쿼트 10회, 물 1L 마시기',
                    number: '3',
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {

                            Navigator.pop(context);

                          },
                          style: ElevatedButton.styleFrom(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15
                            ),
                            backgroundColor: Colors.grey[300],
                          ),
                          child: Text(
                            '취소',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isEnavled ? () {
                            final form = _globalKey.currentState;
                            if (form == null || !form.validate()) {
                              return;
                            }

                            setState(() {
                              _autovalidateMode = AutovalidateMode.always;
                              _isEnavled = false;
                            });

                            logger.d(_challengeGoalController);
                            logger.d(_challengeNameEditingController);
                            logger.d(_challengePlanController);


                            // 여기에 생성 로직

                            Navigator.pop(context);

                          } : null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15
                            ),
                            backgroundColor: Color(0xFF358CFF),
                          ),
                          child: Text(
                            '생성',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _buildInputSection({
    required String number,
    required String title,
    required String hint,
    required TextEditingController editingController,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24.85,
                height: 24.85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9D9D9),
                ),
                child: Center(
                  child: Text(number, style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(width: 10),
              Center(child: Text(title, style: TextStyle(fontSize: 13))),
            ],
          ),
          Divider(color: Color(0xFFF4F4F4), thickness: 1, height: 5),
          TextFormField(
            enabled: true,
            controller: editingController,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.withOpacity(0.5),
              ),
              isDense: true,

              contentPadding: EdgeInsets.symmetric(vertical: 6),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return '내용을 작성해 주세요.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 28.46),
          Text(
            '사용자님, 안녕하세요!',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
          ),
          Text(
            '오늘도 작심삼일을 향해 달려볼까요?',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 23),
          ),
          SizedBox(height: 28.54),
          Container(
            width: double.infinity,
            height: 40.17,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '진행중인 챌린지',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 348,
            decoration: BoxDecoration(
              color: Color(0xFFD1D1D1),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            child: Center(
              //요부분 나중에 챌린지 생성하면 화면 바뀌도록!!
              child: Text(
                '현재 진행중인 챌린지가 없어요.. \n신규 챌린지를 생성하여, 도전해보세요!',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => challengeDialog(),
                  child: Container(
                    width: 102,
                    height: 97,
                    decoration: BoxDecoration(
                      color: Color(0xFFEAF3FE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Color(0xFF4B4B4B),
                            shape: BoxShape.circle,
                          ),
                            child: Icon(Icons.add, color: Colors.white, size: 13),

                        ),

                    ),
                  ),
                ),
                SizedBox(width: 32),
                Center(
                  child: Text('신규 챌린지 생성', style: TextStyle(fontSize: 24)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
