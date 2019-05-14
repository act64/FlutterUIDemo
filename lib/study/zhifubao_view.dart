import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZZView extends StatefulWidget {
  @override
  State createState() {
    return ZZViewState();
  }
}

class ZZViewState extends State<ZZView> implements TextInputClient {
  FocusNode focusNode;
  TextInputConnection _textInputConnection;
  TextEditingValue _value;

  bool get _hasInputConnection =>
      _textInputConnection != null && _textInputConnection.attached;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode()
      ..addListener(() {
        if (!focusNode.hasFocus) {
          setState(() {});
        }
      });
    _value = TextEditingValue();
  }

  @override
  void dispose() {
    focusNode.dispose();
    _closeInputConnection();
    super.dispose();
  }

  void _openInputConnection() {
    if (!_hasInputConnection) {
      final TextEditingValue localValue = _value;
      _textInputConnection = TextInput.attach(
        this,
        TextInputConfiguration(
          inputType: TextInputType.number,
          autocorrect: false,
          inputAction: TextInputAction.done,
        ),
      )..setEditingState(localValue);
    }
    FocusScope.of(context).requestFocus(focusNode);
    _textInputConnection.show();
  }

  void _closeInputConnection() {
    if (_hasInputConnection) {
      _textInputConnection.close();
      _textInputConnection = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: InkWell(
                  onTap: _openInputConnection,
                  child: CustomPaint(
                    painter: ZZViewPainter(valueText: _value.text),
                  ),
                ),
                margin: EdgeInsets.fromLTRB(50, 50, 50, 0),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    border: Border.all(
                        color: focusNode.hasFocus
                            ? Colors.blueAccent
                            : Colors.black38)),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  void performAction(TextInputAction action) {
    print(action);
  }

  @override
  void updateEditingValue(TextEditingValue value) {
    print(value.text);
    print(_hasInputConnection);

    if (value.text == _value.text) return;

    if (value.text.contains(RegExp(r"\D"))) {
      _textInputConnection.setEditingState(_value);
      return;
    }
    if (value.text.length == 6) {
      _closeInputConnection();
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (buildContex) {
             final alertDialog = AlertDialog(
              title: Text("password"),
              content: Text(value.text),
              actions: <Widget>[
                FlatButton(
                  child: Text("close"),
                  onPressed: () {
                    _value = TextEditingValue();
                    Navigator.pop(buildContex);
                    setState(() {});

                  },
                )
              ],
            );
            return alertDialog;
          });
    }
    if (value.text.length > 6) {
      if (value.text.substring(0, 6) == _value.text) {
        _textInputConnection.setEditingState(_value);
        return;
      }
      _value = new TextEditingValue(text: value.text.substring(0, 6));
      _textInputConnection.setEditingState(_value);
    } else {
      _value = value;
    }
    setState(() {});
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {}
}

class ZZViewPainter extends CustomPainter {
  String valueText;
  var linepaint = Paint();
  TextPainter tp;
  TextSpan span;

  ZZViewPainter({this.valueText}) : super() {
    linepaint.color = Colors.black38;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var width = size.width;
    var height = size.height;
    if (span == null) {
      span = new TextSpan(
          style: new TextStyle(color: Colors.black, fontSize: height / 2),
          text: '•');
      tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
    }

    for (int i = 1; i < 6; i++) {
      canvas.drawLine(
          Offset(width * i / 6, 0), Offset(width * i / 6, height), linepaint);
    }
    if (valueText.isNotEmpty) {
      for (int i = 0; i < valueText.length; i++) {
        tp.paint(
            canvas,
            Offset(width * i / 6 + (width / 12 - tp.width / 2),
                height / 2 - tp.height / 2));
      }
    }
  }

  @override
  bool shouldRepaint(ZZViewPainter oldDelegate) {
    return valueText != oldDelegate.valueText;
  }
}
