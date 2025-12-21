import 'package:app_course_code/ViewModels/Lesson/ViewModelLessons.dart';
import 'package:app_course_code/Views/Lesson/embeding/embedingImagesQuill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:provider/provider.dart';

class Lessoncontents extends StatefulWidget {
  const Lessoncontents({super.key});

  @override
  State<Lessoncontents> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Lessoncontents> {
  QuillController? _controller;
  bool _initialized = false;

  void _initQuill(List<dynamic> ops) {
    final delta = Delta.fromJson(ops);
    final document = Document.fromDelta(delta);

    _controller = QuillController(
      document: document,
      selection: const TextSelection.collapsed(offset: 0),
    );

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<Viewmodellessons>();

    if (viewModel.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final lessonContent = viewModel.lessonContents;
    if (lessonContent == null) {
      return const Scaffold(body: Center(child: Text('No content')));
    }

    if (!_initialized) {
      _initQuill(lessonContent.ops);
    }

    return Scaffold(
      body: AbsorbPointer(
        child: QuillEditor(
          controller: _controller!,
          focusNode: FocusNode(),
          scrollController: ScrollController(),
          config: QuillEditorConfig(
            readOnlyMouseCursor: SystemMouseCursors.disappearing,
            scrollable: true,
            autoFocus: false,
            expands: false,
            padding: const EdgeInsets.all(16),
            embedBuilders: [ImageEmbedBuilder()],
          ),
        ),
      ),
    );
  }
}
