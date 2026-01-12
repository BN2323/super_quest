enum CodeBlockType {
  keyword,      // if, else, for
  condition,    // x > 0
  action,       // return, print
  value,        // true, false, number
}

class CodeBlock {
  final String id;
  final CodeBlockType type;
  final String label;
  final String value;

  CodeBlock({
    required this.id,
    required this.type,
    required this.label,
    required this.value,
  });
}
