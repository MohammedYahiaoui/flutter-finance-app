import 'package:finance/pages/home.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController pageController = PageController();
  int currentIndex = 0;
  bool isLastPage = false;
  List<PageItem> item = [
    PageItem(
      title: "Title 1", 
      image: "assets/images/finance1.png", 
      subTitle: "subTitle 1",
      ),
      PageItem(
        title: "Title 2", 
        image: "assets/images/finance2.png", 
        subTitle: "SubTitle 2",
        ),
        PageItem(
          title: "Title 3", 
          image: "assets/images/finance3.png", 
          subTitle: "SubTitle 3",
          ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () {
          Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => HomePage(),),(route)=> false);
        }, child: Text("Skip"))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                  if (value + 1 == item.length){
                    setState(() {
                      isLastPage = true;
                    });
                  } else {
                    setState(() {
                      isLastPage = false;
                    });
                  }
                },
                controller: pageController,
                itemBuilder: (context, index) {
                  return item[index];
                },
                itemCount: item.length,
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Text(
                   "${currentIndex + 1}/${item.length}"
                ),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLastPage ? Colors.blue : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    isLastPage ? 
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage(),),(route)=> false)
                     : pageController.nextPage(
                      duration: Duration(microseconds: 400), 
                      curve: Curves.bounceIn
                      );
                  }, 
                  child: Text(
                    isLastPage ? "Get started" : "Next"
                    ),
                    ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class PageItem extends StatelessWidget {
  final String title;
  final String image;
  final String subTitle;
  const PageItem({
    super.key,
    required this.title,
    required this.image,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            image
            ),
        ),
          SizedBox(
            height: 20,
          ),
        Text(
          title,
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          ),
          SizedBox(
            height: 10,
          ),
        Text(
          subTitle,
          ),
      ],
    );
  }
}
