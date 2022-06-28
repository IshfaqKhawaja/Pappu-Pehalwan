import 'package:flutter/material.dart';

class ChangeWidthFactor extends StatefulWidget {
  final width;
  final returnFunction;
  final halt;
  final size;
  final current;
  const ChangeWidthFactor({
    Key? key,
    this.width,
    this.returnFunction,
    this.halt = false,
    this.size = 1,
    this.current = 0,
  }) : super(key: key);

  @override
  State<ChangeWidthFactor> createState() => _ChangeWidthFactorState();
}

class _ChangeWidthFactorState extends State<ChangeWidthFactor> {
  double widthFactor = 0.0;

  void changeWidthFactor() async {
    for (double i = 0.0; i < 1; i += 0.0009) {
      await Future.delayed(const  Duration(microseconds:1000));
      if (mounted) {
        setState(() {
          widthFactor = widthFactor + 0.001;
        });
      }
    }
    if (mounted) {
      widget.returnFunction();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    changeWidthFactor();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width - 10,
        margin: const EdgeInsets.only(right: 5),
        height: 3,
        color: Colors.black,
        child: FractionallySizedBox(
          widthFactor: widthFactor,
          heightFactor: 1.0,
          alignment: Alignment.centerLeft,
          child: Container(
            color: Colors.white,
           
          ),
        ));
  }
}
