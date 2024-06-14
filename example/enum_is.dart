// ignore_for_file: avoid_print

import 'package:common_macros/common_macros.dart';

@EnumIs()
enum Fruit {
  apple,
  orange,
  banana,
  mango,
}

void main() {
  for (final fruit in Fruit.values) {
    final name = fruit.name;
    print('Checking $name');
    print('$name is an apple? ${fruit.isApple}');
    print('$name is an orange? ${fruit.isOrange}');
    print('$name is a banana? ${fruit.isBanana}');
    print('$name is a mango? ${fruit.isMango}');
    print('');
  }
}
