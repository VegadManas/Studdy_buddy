import 'package:flutter/material.dart';

class OnBoardingCard extends StatelessWidget {
  final String image, title, description, buttontext;
  final Function onPressed;
  const OnBoardingCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttontext,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  description,
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () => onPressed(),
            minWidth: 300,
            color: Colors.blue,
            child: Text(buttontext),
          ),
        ],
      ),
    );
  }
}
