import 'package:flutter/material.dart';

class GiveMeTheLectureMarks extends StatefulWidget {
  final int elemanSayisi;
  const GiveMeTheLectureMarks({required this.elemanSayisi, Key? key})
      : super(key: key);

  @override
  State<GiveMeTheLectureMarks> createState() => _GiveMeTheLectureMarksState();
}

class _GiveMeTheLectureMarksState extends State<GiveMeTheLectureMarks> {
  final _form = GlobalKey<FormState>();

  late double average;
  late List<String> creditsInput;
  late List<String> marks;

  final List<TextEditingController> _controllerList = [];

  @override
  void initState() {
    super.initState();
    creditsInput = List<String>.filled(widget.elemanSayisi, '1');
    marks = List<String>.filled(widget.elemanSayisi, '1');

    for (var i = 0; i < widget.elemanSayisi; i++) {
      _controllerList.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    _form.currentState?.dispose();
    super.dispose();
  }

  double _calculate() {
    List<int> creditNew = [];
    List<double> marksNew = [];
    List<double> weight = [];
    List<double> creditPerLecture = [];
    double overalWeight = 0;
    int overalCredit = 0;
    double averageGpa = 0;
    for (var i = 0; i < widget.elemanSayisi; i++) {
      creditNew.add(int.parse(creditsInput[i]));
      marksNew.add(double.parse(_controllerList[i].text));

      if (marksNew[i] > 100 || marksNew[i] < 0) {
        weight.add(0);
      } else if (marksNew[i] >= 90) {
        weight.add(4.0);
      } else if (marksNew[i] >= 85) {
        weight.add(3.7);
      } else if (marksNew[i] >= 80) {
        weight.add(3.3);
      } else if (marksNew[i] >= 75) {
        weight.add(3.0);
      } else if (marksNew[i] >= 70) {
        weight.add(2.7);
      } else if (marksNew[i] >= 65) {
        weight.add(2.3);
      } else if (marksNew[i] >= 60) {
        weight.add(2.0);
      } else if (marksNew[i] >= 56) {
        weight.add(1.7);
      } else if (marksNew[i] >= 53) {
        weight.add(1.3);
      } else if (marksNew[i] >= 50) {
        weight.add(1.0);
      } else if (marksNew[i] >= 40) {
        weight.add(0.7);
      } else {
        weight.add(0.0);
      }
    }

    for (var i = 0; i < widget.elemanSayisi; i++) {
      overalCredit += creditNew[i];
      creditPerLecture.add(creditNew[i] * weight[i]);
      overalWeight += creditPerLecture[i];
    }

    averageGpa = overalWeight / overalCredit;

    return averageGpa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text(
          'BiCGPA',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Expanded(
              child: IntrinsicHeight(
                child: Form(
                  key: _form,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.elemanSayisi,
                    itemBuilder: (context, i) {
                      return buildCourseInput(i);
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text(
                'CALCULATE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                primary: Colors.indigo,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseInput(int i) {
    return Column(
      children: [
        TextFormField(
          controller: _controllerList[i],
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          autofocus: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            icon: const Icon(
              Icons.menu_book,
              size: 28,
            ),
            border: const OutlineInputBorder(),
            labelText: 'Lecture ${i + 1}',
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            hintText: 'Enter grade (0-100)',
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          validator: (newValue) {
            final number = int.tryParse(newValue ?? '');
            if (number == null || number < 0 || number > 100) {
              return 'Please enter a valid number between 0 and 100';
            } else {
              return null;
            }
          },
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Credits',
              labelStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            dropdownColor: Colors.white,
            value: creditsInput[i],
            onChanged: (value) {
              setState(() {
                creditsInput[i] = value!;
              });
            },
            items: const <String>['1', '2', '3', '4'].map(
              (value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ).toList()),
        const SizedBox(height: 20),
      ],
    );
  }

  void _submitForm() {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      average = _calculate();
      debugPrint('$average');
      Navigator.pushNamed(context, '/AverageInfo', arguments: average);
      for (int i = 0; i < widget.elemanSayisi; i++) {
        debugPrint("submit button içinde mark $i: ${_controllerList[i].text}");
      }
      _form.currentState!.reset();
    }
  }
}
