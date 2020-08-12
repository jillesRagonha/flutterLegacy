import 'package:fllojavirtual/view/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'roda_categoria.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Layout.light(),
            borderRadius: BorderRadius.circular(25),
          ),
          margin: EdgeInsets.only(left: 20, right: 20),
          height: 100,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Text("Promoções"),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Layout.light(0.7),
              borderRadius: BorderRadius.circular(25),
            ),
            margin: EdgeInsets.only(left: 20, right: 20),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: Text("Produto"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            "Categorias",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Layout.light()),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 90,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: RodaCategoria(),
          ),
        ),
      ],
    );
    return Layout.render(context, content);
  }
}
