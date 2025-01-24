import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  String imageName;
  bool isRight;

  CategoryItem({required this.imageName, required this.isRight, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: !isRight ? Alignment.bottomRight : Alignment.bottomLeft,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset("assets/${imageName}.png")),
        Padding(
          padding: const EdgeInsets.only(bottom: 16, right: 16),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(.50),
                borderRadius: BorderRadius.circular(35)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: !isRight
                  ? [
                      Padding(
                        padding: EdgeInsets.only(left: !isRight ? 16 : 0),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 38,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(!isRight
                                ? Icons.arrow_forward_ios
                                : Icons.arrow_back_ios)),
                      )
                    ]
                  : [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(!isRight
                                ? Icons.arrow_forward_ios
                                : Icons.arrow_back_ios)),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: isRight ? 16 : 0),
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 38,
                          ),
                        ),
                      ),
                    ],
            ),
          ),
        )
      ],
    );
  }
}
