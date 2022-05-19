import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExtraTaskCard extends StatelessWidget {
  final String projectType;
  final String taskType;

  const ExtraTaskCard(
      {Key? key, required this.projectType, required this.taskType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.lightGreen.shade50,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  projectType,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  width: size.width * .4,
                  child: Text(
                    taskType,
                    maxLines: 3,
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
