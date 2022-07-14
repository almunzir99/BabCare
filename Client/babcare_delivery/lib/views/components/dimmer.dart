import 'package:flutter/material.dart';

class Dimmer extends StatelessWidget {
  final bool show;
  const Dimmer({Key? key, this.show = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      clipBehavior: Clip.hardEdge,
      height: (!show) ? 0.0 : MediaQuery.of(context).size.height,
      width: (!show) ? 0.0 : MediaQuery.of(context).size.width,
      color: Colors.white.withOpacity(0.9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
              height: 40.0, width: 40.0, child: CircularProgressIndicator()),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            "الرجاء الانتظار ...",
            style: TextStyle(color: Colors.grey.shade800, fontSize: 20.0),
          )
        ],
      ),
    );
  }
}
