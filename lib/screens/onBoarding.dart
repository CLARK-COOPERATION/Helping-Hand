import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;

  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  controller: _controller,
                  children: [
                    onBoardingStyle(
                        //'https://assets1.lottiefiles.com/private_files/lf30_of3skn6w.json',
                        'assets/onBoarding1.json',
                        'Improve your Mental Health',
                        'We help you to access your mental health just by asking you questions frequently'),
                    onBoardingStyle(
                        //'https://assets6.lottiefiles.com/packages/lf20_0fhlytwe.json',
                        'assets/onBoarding2.json',
                        'Consult Doctor',
                        'Do you have a busy schedule or feel inconvenient to consult a doctor in the hospital? No worries we provide you online consultancies'),
                    onBoardingStyle(
                        //'https://assets9.lottiefiles.com/packages/lf20_msdmfngy.json',
                        'assets/onBoarding3.json',
                        'Track your data',
                        'We value your privacy and hence we show the users all data we collect for accessing your mental health')
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                      (index) {
                    return Container(
                      height: 10,
                      width: currentIndex == index ? 25 : 10,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 100),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      elevation: 15,
                      shape: const StadiumBorder(),
                      //Colors.tealAccent,
                      padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                    ),
                    onPressed: () {
                      if (currentIndex == 2) {
                        Navigator.pushNamed(context, '/login');
                      } else {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Text(currentIndex == 2 ? 'Continue' : 'Next')),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column onBoardingStyle(String animation, String title, String description) {
    return Column(
      children: [
        Lottie.asset(animation,
            height: MediaQuery.of(context).size.height * 0.4),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}
