import 'package:flutter/material.dart';

class AdvantageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildAdvantage(String title, String subtitle) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
            size: 50
          ),

          SizedBox(
            width: 8,
          ),

          Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),

              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white
                ),
              )
            ]
          )
        ],
      );
    }

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey))
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 8,
        runSpacing: 16,
        children: [
          _buildAdvantage("+45.000 alunos", "Didática garantida"),
          _buildAdvantage("+45.000 alunos", "Didática garantida"),
          _buildAdvantage("+45.000 alunos", "Didática garantida"),
        ],
      )
    );
  }
}