import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

Component t(String text) => Component.text(text);

/// Standard section wrapper with an eyebrow, heading and optional lead text.
Component pageSection({
  required String id,
  required String eyebrow,
  required String title,
  String? lead,
  bool alt = false,
  required List<Component> children,
}) {
  return section(
    id: id,
    classes: alt ? 'section section-alt' : 'section',
    attributes: {'aria-labelledby': '$id-title'},
    [
      div(classes: 'container reveal', [
        div(classes: 'section-head', [
          span(classes: 'eyebrow', [t(eyebrow)]),
          h2(id: '$id-title', classes: 'section-title', [t(title)]),
          if (lead != null) p(classes: 'section-lead', [t(lead)]),
        ]),
        ...children,
      ]),
    ],
  );
}
