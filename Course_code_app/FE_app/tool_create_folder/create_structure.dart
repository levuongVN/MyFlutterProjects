import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('❌ Vui lòng nhập tên feature. Ví dụ: dart tool/create_structure.dart lesson');
    exit(1);
  }

  final featureName = args.first;
  final base = 'lib/features/$featureName';

  final folders = [
    '$base/domain/entities',
    '$base/domain/repositories',
    '$base/domain/usecases',
    '$base/data/models',
    '$base/data/repositories',
    '$base/data/datasources',
    '$base/presentation/pages',
    '$base/presentation/providers',
    '$base/presentation/widgets',
  ];

  for (var dir in folders) {
    Directory(dir).createSync(recursive: true);
    print('✅ Created: $dir');
  }

  print('\n🎉 Feature "$featureName" đã được tạo xong!');
}
