import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui' as ui;
import 'reactive_model.dart';

/// A text field widget that synchronizes with a reactive model.
///
/// This widget provides a text field that automatically updates when the model changes
/// and updates the model when the text field changes.
///
/// Type parameter [T] represents the type of data in the reactive model.
class RxTextField<T> extends StatefulWidget {
  /// The reactive model that this text field is bound to.
  final ReactiveModel<T> model;

  /// A function that extracts a string value from the model data.
  ///
  /// This is used when the model contains a complex object and you want to bind
  /// the text field to a specific field of that object.
  final String Function(T)? field;

  /// A callback that is called when the text field value changes.
  ///
  /// This is used to update a specific field in a complex object.
  /// The first parameter is the current model data, and the second parameter is the new value.
  final void Function(T, String)? onChanged;

  // Standard Flutter TextField properties
  /// The group value for the text field.
  final Object groupId;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Controls the undo history of the text field.
  final UndoHistoryController? undoController;

  /// The decoration to show around the text field.
  final InputDecoration? decoration;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// The capitalization behavior for text input.
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// The strut style used for the vertical layout of the text.
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether to show cursor.
  final bool? showCursor;

  /// Focuses this text field when the widget is first created.
  final bool autofocus;

  /// Represents the interactive "state" of this widget.
  final WidgetStatesController? statesController;

  /// The character used to obscure text if obscureText is true.
  final String obscuringCharacter;

  /// Whether the text field should obscure the text (for passwords).
  final bool obscureText;

  /// Whether to enable autocorrection.
  final bool autocorrect;

  /// Configuration of smart dashes behavior.
  final SmartDashesType smartDashesType;

  /// Configuration of smart quotes behavior.
  final SmartQuotesType smartQuotesType;

  /// Whether to enable suggestions as the user types.
  final bool enableSuggestions;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// The minimum number of lines for the text to span.
  final int? minLines;

  /// Whether this field should expand to fill its parent.
  final bool expands;

  /// The maximum number of characters (Unicode scalar values) to allow in the text field.
  final int? maxLength;

  /// How to enforce the maximum length restriction.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Called when the user changes the text in the field.
  final ValueChanged<String>? onTextChanged;

  /// Called when the user finishes editing the text in the field.
  final VoidCallback? onEditingComplete;

  /// Called when the user submits editable content.
  final ValueChanged<String>? onSubmitted;

  /// Called when the app receives a system message while text input is active.
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// The list of input formatters which are called when the user changes the text.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the text field is enabled.
  final bool? enabled;

  /// Whether to ignore pointer events for the text field.
  final bool? ignorePointers;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// The shape of the cursor.
  final Radius? cursorRadius;

  /// Whether the cursor opacity should animate.
  final bool? cursorOpacityAnimates;

  /// The cursor color to use when the text field is focused.
  final Color? cursorColor;

  /// The cursor color to use when the text field has an error.
  final Color? cursorErrorColor;

  /// The height of the selection highlight.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// The width of the selection highlight.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// The appearance of the keyboard.
  final Brightness? keyboardAppearance;

  /// The padding around the scrollable content of the text field.
  final EdgeInsets scrollPadding;

  /// Determines the way that drag start behavior is handled.
  final DragStartBehavior dragStartBehavior;

  /// Whether to enable interactive selection.
  final bool enableInteractiveSelection;

  /// Controls the selection handles and context menu.
  final TextSelectionControls? selectionControls;

  /// Called when the user taps on the text field.
  final GestureTapCallback? onTap;

  /// Whether onTap is always called even if the text field is disabled.
  final bool onTapAlwaysCalled;

  /// Called when a tap is detected outside of the text field.
  final TapRegionCallback? onTapOutside;

  /// Called when a tap up is detected outside of the text field.
  final TapRegionUpCallback? onTapUpOutside;

  /// The cursor for mouse pointers when hovering over the text field.
  final MouseCursor? mouseCursor;

  /// Builds the counter widget displayed below the text field.
  final InputCounterWidgetBuilder? buildCounter;

  /// Controls the scrolling of the text field.
  final ScrollController? scrollController;

  /// How the text field should scroll.
  final ScrollPhysics? scrollPhysics;

  /// Hints for autofill functionality.
  final Iterable<String>? autofillHints;

  /// Configuration for content insertion.
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// How to clip the content of the text field.
  final Clip clipBehavior;

  /// Restoration ID to save and restore the state of the text field.
  final String? restorationId;

  /// Whether to enable stylus handwriting.
  final bool stylusHandwritingEnabled;

  /// Whether to enable IME personalized learning.
  final bool enableIMEPersonalizedLearning;

  /// The builder for a context menu that appears when the user long-presses on the text field.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Whether the text field can request focus.
  final bool canRequestFocus;

  /// Configuration for spell check.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// The configuration for the magnifier of this text field.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Called when the user initiates a focus change.
  final ValueChanged<bool>? onFocusChange;

  /// Creates a new [RxTextField].
  ///
  /// The [model] parameter is required.
  /// If [field] is provided, [onChanged] must also be provided.
  const RxTextField({
    super.key,
    required this.model,
    this.field,
    this.onChanged,
    this.groupId = EditableText,
    this.focusNode,
    this.undoController,
    this.decoration = const InputDecoration(),
    TextInputType? keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.textDirection,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.statesController,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.maxLengthEnforcement,
    this.onTextChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.inputFormatters,
    this.enabled,
    this.ignorePointers,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorOpacityAnimates,
    this.cursorColor,
    this.cursorErrorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    this.selectionControls,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.onTapUpOutside,
    this.mouseCursor,
    this.buildCounter,
    this.scrollController,
    this.scrollPhysics,
    this.autofillHints = const <String>[],
    this.contentInsertionConfiguration,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.enableIMEPersonalizedLearning = true,
    this.contextMenuBuilder,
    this.canRequestFocus = true,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.onFocusChange,
  }) : assert(
         field == null || onChanged != null,
         'onChanged is required when field is provided',
       ),
       smartDashesType =
           smartDashesType ??
           (obscureText ? SmartDashesType.disabled : SmartDashesType.enabled),
       smartQuotesType =
           smartQuotesType ??
           (obscureText ? SmartQuotesType.disabled : SmartQuotesType.enabled),
       keyboardType =
           keyboardType ??
           (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
       enableInteractiveSelection =
           enableInteractiveSelection ?? (!readOnly || !obscureText);

  @override
  State<RxTextField<T>> createState() => _RxTextFieldState<T>();
}

class _RxTextFieldState<T> extends State<RxTextField<T>> {
  late TextEditingController _controller;
  bool _isInternalChange = false;

  @override
  void initState() {
    super.initState();

    final initialText =
        widget.field != null
            ? widget.field!(widget.model.data)
            : widget.model.data.toString();
    _controller = TextEditingController(text: initialText);
    _controller.addListener(_handleTextChange);
    widget.model.addListener(_syncController);
  }

  void _handleTextChange() {
    if (_isInternalChange) return;

    if (widget.field != null && widget.onChanged != null) {
      widget.model.updateWithCallback((data) {
        widget.onChanged!(data, _controller.text);
      });
    } else if (widget.field == null) {
      widget.model.updateField(_controller.text);
    }

    widget.onTextChanged?.call(_controller.text);
  }

  void _syncController() {
    final currentValue =
        widget.field != null
            ? widget.field!(widget.model.data)
            : widget.model.data.toString();
    if (_controller.text != currentValue) {
      _isInternalChange = true;
      _controller.text = currentValue;
      _isInternalChange = false;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();

    widget.model.removeListener(_syncController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      groupId: widget.groupId,
      controller: _controller,
      focusNode: widget.focusNode,
      undoController: widget.undoController,
      decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      textDirection: widget.textDirection,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      autofocus: widget.autofocus,
      statesController: widget.statesController,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      onChanged: widget.onTextChanged,
      onEditingComplete: () {
        if (widget.onFocusChange != null) {
          widget.onFocusChange!(false);
        }
        widget.onEditingComplete?.call();
      },
      onSubmitted: widget.onSubmitted,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      ignorePointers: widget.ignorePointers,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorOpacityAnimates: widget.cursorOpacityAnimates,
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      dragStartBehavior: widget.dragStartBehavior,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      onTap: () {
        if (widget.onFocusChange != null) {
          widget.onFocusChange!(true);
        }
        widget.onTap?.call();
      },
      onTapAlwaysCalled: widget.onTapAlwaysCalled,
      onTapOutside: widget.onTapOutside,
      onTapUpOutside: widget.onTapUpOutside,
      mouseCursor: widget.mouseCursor,
      buildCounter: widget.buildCounter,
      scrollController: widget.scrollController,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      clipBehavior: widget.clipBehavior,
      restorationId: widget.restorationId,
      stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      contextMenuBuilder: widget.contextMenuBuilder,
      canRequestFocus: widget.canRequestFocus,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      magnifierConfiguration: widget.magnifierConfiguration,
    );
  }
}
