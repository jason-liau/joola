import 'package:flutter/material.dart';
import 'package:joola/src/utils/utils.dart';

class TrainTab extends StatefulWidget {
  final PageController controller = PageController();

  TrainTab({
    super.key,
  });

  @override
  State<TrainTab> createState() => _TrainTabState();
}

class _TrainTabState extends State<TrainTab> {
  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [true, false, false];
    
    return Container(
      alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        padding: const EdgeInsets.all(1),
        child: ToggleButtons(
          onPressed: (int index) {
          },
          isSelected: isSelected,
          renderBorder: false,
          borderRadius: BorderRadius.circular(14.5),
          selectedColor: const Color.fromARGB(255, 64, 64, 162),
          selectedBorderColor: Colors.white,
          tapTargetSize: MaterialTapTargetSize.padded,
          children: <Widget>[
            SizedBox(
              width: (Utils.percentWidth(context, 1) - 60) / 3 - 2,
              child: Text(
                'Classes',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: Utils.percentWidth(context, 0.04),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'calibri'),
              ),
            ),
            SizedBox(
              width: (Utils.percentWidth(context, 1) - 60) / 3 - 2,
              child: Text(
                'Programs',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: Utils.percentWidth(context, 0.04),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'calibri'),
              ),
            ),
            SizedBox(
              width: (Utils.percentWidth(context, 1) - 60) / 3 - 2,
              child: Text(
                'Collections',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: Utils.percentWidth(context, 0.04),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'calibri'),
              ),
            ),
          ],
        ));
  }
}
