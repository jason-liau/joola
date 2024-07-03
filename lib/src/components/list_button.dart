import 'package:flutter/material.dart';

class ListButton extends StatelessWidget {
  final List<String> texts;
  final List<Icon> icons;
  final List<VoidCallback?> actions;

  const ListButton({
    super.key,
    required this.texts,
    required this.icons,
    required this.actions
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[350]!),
        borderRadius: const BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: texts.length,
          separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey[350]),
          itemBuilder: (BuildContext context, int i) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: actions[i],
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: icons[i]
                  ),
                  Text(texts[i], style: const TextStyle(fontSize: 18)),
                  Expanded(
                    child: Container(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400, size: 20))
                  )
                ]
              ),
            );
          }
        ),
      )
    );
  }
}