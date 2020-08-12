import 'dart:math';

import 'package:flutter/material.dart';

import '../layout.dart';

//enun para identificar o lado que esta girando a roda
enum SwipeDirection { left, right }

class RodaCategoria extends StatefulWidget {
  @override
  _RodaCategoriaState createState() => _RodaCategoriaState();
}

class _RodaCategoriaState extends State<RodaCategoria>
    with SingleTickerProviderStateMixin {
  //entendendo animação - Tween com valor 1 = 360º
  //entendendo animação - Transform.rotate 360º = pi*2
  AnimationController _controller;
  List<Map<String, dynamic>> itens;

//variaveis para controlar o angulo /grau de giro de cada item
  double _startDegree = 0.0;
  double _endDegree = 0.0;

  //controle do lado que o usuario esta arrastando a roda
  double _dragInitial = 0;
  SwipeDirection _swipeDirection;
  //controle do item atual que esta exibido na roda
  int _currentItem = 0;

  @override
  void initState() {
    super.initState();
    //iniciando a animação
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    itens = _getListaCategorias();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 2,
                offset: Offset(2, 0),
                color: Layout.dark(.3),
              ),
            ],
          ),
          width: size.width,
          height: size.width,
          margin: EdgeInsets.only(top: 10, bottom: 10),
        ),
        RotationTransition(
          turns:
              Tween(begin: _startDegree, end: _endDegree).animate(_controller),
          child: GestureDetector(
            onTap: () {
              print(itens[_currentItem]);
            },
            onHorizontalDragStart: (details) {
              _dragInitial = details.globalPosition.dx;
            },
            onHorizontalDragUpdate: (details) {
              _swipeDirection = SwipeDirection.right;

              if ((details.globalPosition.dx - _dragInitial) < 0) {
                _swipeDirection = SwipeDirection.left;
              }
            },
            onHorizontalDragEnd: (details) {
              _startDegree = _endDegree;
              _controller.reset();
              switch (_swipeDirection) {
                case SwipeDirection.left:
                  _endDegree -= (1 / itens.length);
                  _currentItem++;
                  if (_currentItem > itens.length - 1) {
                    _currentItem = 0;
                  }

                  break;
                case SwipeDirection.right:
                  _endDegree += (1 / itens.length);
                  _currentItem--;
                  if (_currentItem < 0) {
                    _currentItem = itens.length - 1;
                  }
                  break;

                default:
              }
              _swipeDirection = null;
              setState(() {
                _controller.forward();
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Layout.secondaryDark(),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: _getCategorias(context),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 10, bottom: 10),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _getCategorias(BuildContext context) {
    var angleFactor = (pi * 2) / itens.length;
    var angle = -angleFactor;
    List<Widget> result = [];
    result.add(
      ClipRRect(
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width),
        child: Image.asset(
          'assets/images/bg-catwheel.png',
          fit: BoxFit.cover,
        ),
      ),
    );

    for (Map<String, dynamic> item in _getListaCategorias()) {
      angle += angleFactor;
      result.add(
        Transform.rotate(
          angle: angle,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Icon(
                    item['icon'],
                    color: Layout.light(),
                    size: 32,
                  ),
                ),
                Text(
                  item['text'],
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Layout.light(),
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return result;
  }

  List<Map<String, dynamic>> _getListaCategorias() {
    return [
      {"id": 1, "icon": Icons.favorite, "text": "Estilo"},
      {"id": 2, "icon": Icons.filter_drama, "text": "Teen"},
      {"id": 3, "icon": Icons.flight, "text": "Viagem"},
      {"id": 4, "icon": Icons.store_mall_directory, "text": "Trabalho"},
      {"id": 5, "icon": Icons.style, "text": "Casual"},
      {"id": 6, "icon": Icons.supervised_user_circle, "text": "Executivo"},
      {"id": 7, "icon": Icons.switch_video, "text": "Esportes"},
      {"id": 8, "icon": Icons.thumb_up, "text": "Clássicos"},
    ];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
