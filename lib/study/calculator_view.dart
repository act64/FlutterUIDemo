import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expressions/expressions.dart';

class CalcuteDataModel {
  String showText;

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return showText == (other.showText);
  }
}

class CalcuteDataContext extends InheritedWidget {
  CalcuteDataContext({Widget child}) : super(child: child);

  CalcuteDataModel calcuteDataModel;

  VoidCallback doRefresh;

  static CalcuteDataContext of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CalcuteDataContext);
  }

  @override
  bool updateShouldNotify(CalcuteDataContext oldWidget) {
    return calcuteDataModel != oldWidget?.calcuteDataModel;
  }
}

class CalculateMainView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalculateMainState();
  }
}

class ShowTextValueView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShowTextValueState();
  }
}

class ShowTextValueState extends State<ShowTextValueView> {
  @override
  void initState() {

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if   (CalcuteDataContext.of(context).doRefresh==null){
      CalcuteDataContext.of(context).doRefresh = (){
        setState(() {

        });
      };
    }
    return Text(
        CalcuteDataContext.of(context)?.calcuteDataModel?.showText ?? "");
  }
}

typedef void ClickKeyBoardCallback(String clickStr);

class CalculateMainState extends State<CalculateMainView> {
  String showText = "";

  @override
  Widget build(BuildContext context) {
    return CalcuteDataContext(
        child: Column(
      children: <Widget>[
        Expanded(
          child: Center(child: ShowTextValueView()),
        ),
        NumCalculateView(
          clickKeyBoardCallback: (str) {},
        )
      ],
    ));
  }
}

typedef void OntapedCallback();

class ClickItem extends StatefulWidget {
  OntapedCallback _ontapedCallback;
  String showtext;

  ClickItem(this.showtext, {OntapedCallback ontapCallback}) : super() {
    _ontapedCallback = ontapCallback;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClickItemState(showtext, ontapCallback: _ontapedCallback);
  }
}

class ClickItemState extends State<ClickItem> {
  String clicktext;
  OntapedCallback _ontapedCallback;

  ClickItemState(this.clicktext, {OntapedCallback ontapCallback}) : super() {
    _ontapedCallback = ontapCallback;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: () {
            if (_ontapedCallback != null) {
              _ontapedCallback();
            }

            if (CalcuteDataContext.of(context).calcuteDataModel == null) {
              CalcuteDataContext.of(context).calcuteDataModel =
                  new CalcuteDataModel();
              CalcuteDataContext.of(context).calcuteDataModel.showText = "";
            }
            var calcuteDataContext = CalcuteDataContext.of(context);
            if (this.clicktext == "=") {
              try {
                Expression expression = Expression.parse(
                    "${calcuteDataContext.calcuteDataModel.showText}");
                final evaluator = const ExpressionEvaluator();
                var r = evaluator.eval(expression, Map());
                calcuteDataContext.calcuteDataModel.showText = "${r}";
              } catch (e) {
                print(e);
              }
            } else if (this.clicktext == "删") {
              calcuteDataContext.calcuteDataModel.showText =
                  calcuteDataContext.calcuteDataModel.showText.substring(
                      0,
                      calcuteDataContext.calcuteDataModel.showText.length -
                          1);
            } else {
              calcuteDataContext.calcuteDataModel.showText += this.clicktext;
            }
            calcuteDataContext.doRefresh();
          },
          child: Container(child: Center(child: Text(clicktext)))),
    );
  }
}

class NumCalculateView extends StatelessWidget {
  ClickKeyBoardCallback clickKeyBoardCallback;

  NumCalculateView({this.clickKeyBoardCallback});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height * 4 / 7,
          child: Row(children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClickItem(
                    "7",
                    ontapCallback: () {
                      clickKeyBoardCallback("7");
                    },
                  ),
                  ClickItem(
                    "4",
                    ontapCallback: () {
                      clickKeyBoardCallback("4");
                    },
                  ),
                  ClickItem(
                    "1",
                    ontapCallback: () {
                      clickKeyBoardCallback("1");
                    },
                  ),
                  ClickItem(
                    ".",
                    ontapCallback: () {
                      clickKeyBoardCallback(".");
                    },
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(children: <Widget>[
              ClickItem(
                "8",
                ontapCallback: () {
                  clickKeyBoardCallback("8");
                },
              ),
              ClickItem(
                "5",
                ontapCallback: () {
                  clickKeyBoardCallback("5");
                },
              ),
              ClickItem(
                "2",
                ontapCallback: () {
                  clickKeyBoardCallback("2");
                },
              ),
              ClickItem(
                "0",
                ontapCallback: () {
                  clickKeyBoardCallback("0");
                },
              ),
            ])),
            Expanded(
                child: Column(children: <Widget>[
              ClickItem(
                "9",
                ontapCallback: () {
                  clickKeyBoardCallback("9");
                },
              ),
              ClickItem(
                "6",
                ontapCallback: () {
                  clickKeyBoardCallback("6");
                },
              ),
              ClickItem(
                "3",
                ontapCallback: () {
                  clickKeyBoardCallback("3");
                },
              ),
              ClickItem(
                "删",
                ontapCallback: () {
                  clickKeyBoardCallback("删");
                },
              ),
            ])),
            Expanded(
                child: Column(children: <Widget>[
              ClickItem(
                "+",
                ontapCallback: () {
                  clickKeyBoardCallback("+");
                },
              ),
              ClickItem(
                "-",
                ontapCallback: () {
                  clickKeyBoardCallback("-");
                },
              ),
              ClickItem(
                "*",
                ontapCallback: () {
                  clickKeyBoardCallback("*");
                },
              ),
              ClickItem(
                "/",
                ontapCallback: () {
                  clickKeyBoardCallback("/");
                },
              ),
              ClickItem(
                "=",
                ontapCallback: () {
                  clickKeyBoardCallback("=");
                },
              ),
            ])),
          ]),
        ));
  }
}
