import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class modal_bottom_add_task extends StatefulWidget {
  final Function(String, String) handleSubmit;
  final String? nameTask;
  final String? text_Priority;
  const modal_bottom_add_task({
    super.key,
    required this.handleSubmit,
    this.nameTask,
    this.text_Priority,
  });

  @override
  State<modal_bottom_add_task> createState() => _modal_bottom_add_taskState();
}

class _modal_bottom_add_taskState extends State<modal_bottom_add_task> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController taskController;

  late String priority; // index, you will use this to get the value of choice
  final List<String> options = ["Low", "Medium", "High"];

  @override
  void initState() {
    super.initState();
    taskController = TextEditingController(text: widget.nameTask ?? '');
    priority = widget.text_Priority ?? "Low";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: taskController,
                decoration: const InputDecoration(
                  labelText: 'Enter the task',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your task!'
                    : null,
              ),
              const SizedBox(height: 20),
              const Text(
                "Priority",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              // --------- ChipsChoice ---------
              ChipsChoice<String>.single(
                value: priority,
                onChanged: (val) => setState(() => priority = val),
                choiceItems: C2Choice.listFrom<String, String>(
                  // <Value,Source> => <String,String>
                  source: options,
                  value: (i, v) => v, // this is index
                  label: (i, v) => v, // this is value
                  style: (index, item) {
                    if (item == 'Low') {
                      return C2ChipStyle.filled(
                        color: Colors.green,
                      ); // the property filled is like the prop background color
                    } else if (item == 'Medium') {
                      return C2ChipStyle.filled(color: Colors.orange);
                    } else {
                      return C2ChipStyle.filled(color: Colors.redAccent);
                    }
                  },
                ),
                choiceCheckmark: true,
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.handleSubmit(taskController.text, priority);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.nameTask == null ? 'Add' : 'Save',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
