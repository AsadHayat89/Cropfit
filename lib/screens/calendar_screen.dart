import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime date = DateTime(2022, 12, 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(25, 137, 8, 1),
        title: const Text('Date Picker'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  '${date.month}/${date.day}/${date.year} ',
                //'${date.year}/${date.month}/${date.day} ',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: Text('Select Date'),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  //if cancel => null

                  if (newDate == null) return;

                  //if ok => DateTime
                  setState(() => date = newDate);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
