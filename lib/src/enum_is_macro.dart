import 'dart:async';

import 'package:macros/macros.dart';

// FIXME: remove ClassDeclarationsMacro when enums are fully supported
macro class EnumIs
    implements ClassDeclarationsMacro, EnumDeclarationsMacro {
  const EnumIs();

  @override
  Future<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final superclass = clazz.superclass;
    if (superclass == null || superclass.identifier.name != '_Enum') {
      builder.report(
        Diagnostic(
          DiagnosticMessage('Only enums can be annotated with @EnumIs'),
          Severity.error,
        ),
      );
    }

    final fields = (await builder.fieldsOf(clazz))
        .where((f) => f.identifier.name != 'values');

    for (final field in fields) {
      addGetter(builder, field.identifier.name);
    }
  }

  @override
  Future<void> buildDeclarationsForEnum(
    EnumDeclaration enuum,
    EnumDeclarationBuilder builder,
  ) async {
    final values = await builder.valuesOf(enuum);

    for (final value in values) {
      addGetter(builder, value.identifier.name);
    }
  }

  void addGetter(MemberDeclarationBuilder builder, String name) {
    final getterName = 'is${name[0].toUpperCase()}${name.substring(1)}';
    builder.declareInType(
      DeclarationCode.fromString(
        'bool get $getterName => this == $name;',
      ),
    );
  }
}
