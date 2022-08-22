import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:karbon_ayak_izi_app/model/deneme.dart';
import 'package:karbon_ayak_izi_app/model/footprint_values.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_eight.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_five.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_four.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_nine.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_one.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_seven.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_six.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_ten.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_three.dart';
import 'package:karbon_ayak_izi_app/question_pages/question_two.dart';
import 'package:karbon_ayak_izi_app/screens/result_and_profil_page.dart';

import '../model/question_model.dart';

class CarbonFootprintForm extends StatefulWidget {
  const CarbonFootprintForm({Key? key}) : super(key: key);

  @override
  State<CarbonFootprintForm> createState() => _CarbonFootprintFormState();
}

class _CarbonFootprintFormState extends State<CarbonFootprintForm> {
  late PageController controller;
  int slideIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Future<List<QuestionModel>> questionModelOku() async {
    String okunanString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/question_answers_model.json');
    var jsonObje = jsonDecode(okunanString);
    List<QuestionModel> questionList = (jsonObje as List)
        .map((questions) => QuestionModel.fromMap(questions))
        .toList();
    debugPrint(questionList[0].dropdown[0].questionOne[0].toString());

    return questionList;
  }

  Future<List<DenemeModel>> denemeOku() async {
    String okunanString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/deneme.json');
    var jsonObje = jsonDecode(okunanString);
    List<DenemeModel> questionList = (jsonObje as List)
        .map((questions) => DenemeModel.fromMap(questions))
        .toList();
    debugPrint(questionList.length.toString());

    return questionList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Karbon Ayak İzim',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PageView.builder(
              itemBuilder: (context, index) {
                var question = [index];
                return QuestionOne(index: slideIndex);
              },
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  slideIndex = value;
                });
              },
              // children: [
              //   const IntroPage(),
              //   QuestionOne(
              //     index: slideIndex,
              //   ),
              //   QuestionTwo(index: slideIndex),
              //   QuestionThree(index: slideIndex),
              //   QuestionFour(index: slideIndex),
              //   QuestionFive(index: slideIndex),
              //   QuestionSix(index: slideIndex),
              //   QuestionSeven(index: slideIndex),
              //   QuestionEight(index: slideIndex),
              //   QuestionNine(index: slideIndex),
              //   QuestionTen(index: slideIndex),
              // ],
            ),
          ),
        ),
        bottomSheet: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    controller.animateToPage(slideIndex - 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linear);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              Row(
                children: [
                  for (int i = 0; i < 11; i++)
                    i == slideIndex
                        ? _buildPageIndicator(true)
                        : _buildPageIndicator(false),
                ],
              ),
              slideIndex != 10
                  ? TextButton(
                      onPressed: () {
                        controller.animateToPage(slideIndex + 1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      child: const Text(
                        "NEXT",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultProfilePage(),
                            ));
                      },
                      child: const Text(
                        "FINISH",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                    ),
            ],
          ),
        )
        // : InkWell(
        //     onTap: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) => ResultProfilePage(),));
        //     },
        //     child: Container(
        //       height: 60,
        //       color: Colors.blue,
        //       alignment: Alignment.center,
        //       child: const Text(
        //         "CONTİNUE",
        //         style: TextStyle(
        //             color: Colors.white, fontWeight: FontWeight.w600),
        //       ),
        //     ),
        //   ),
        );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/haberler42218_2.jpg',
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height / 2,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Karbon Ayak İzi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                "Tıpkı bir yere bastığımızda ayak izimizin kalması gibi, üretim, tüketim, seyahat dahil her türlü yaşamsal faaliyetimizle ve kullandığımız ürünlerle ortaya çıkardığımız sera gazlarıyla gezegende bıraktığımız etkidir Karbon Ayak İzi'miz",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ))
          ],
        ),
      ),
    );
  }
}
