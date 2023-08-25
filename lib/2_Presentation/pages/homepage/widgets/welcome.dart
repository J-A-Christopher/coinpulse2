import 'package:coinpulse2/2_Presentation/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: ListView(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: SvgPicture.asset(
                'assets/svg/expenses.svg',
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'A Welcome Message From Our Team:',
            style: TextStyle(color: ColorsUsed.primaryColor, fontSize: 20),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Card(
            color: Colors.grey[100],
            child: const Padding(
              padding: EdgeInsets.all(13.0),
              child: Text(
                "Welcome to Coin Pulse, where your journey towards financial success begins! We're here to empower you with the tools, knowledge, and guidance you need to take control of your finances and achieve your goals. From budgeting like a pro to making informed investment decisions, Coin Pulse is your trusted partner every step of the way. Let's start turning your financial dreams into reality together.",
                style: TextStyle(height: 1.5, fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Card(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Perks you will enjoy are:',
                    //style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const Row(
                    children: [
                      Text(
                        '\u2022',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Streamlined Budgeting',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        '\u2022',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Goal Tracking',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        '\u2022',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Expense Analysis',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        '\u2022',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Financial Education',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        '\u2022',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Data Security',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
