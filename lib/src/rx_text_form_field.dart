import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'reactive_model.dart';
import 'rx_text_field.dart';

/// A form-enabled text field widget that synchronizes with a reactive model.
///
/// This widget extends the functionality of [RxTextField] by adding form validation
/// capabilities. It automatically updates when the model changes and updates the
/// model when the text field changes.
///
/// Type parameter [T] represents the type of data in the reactive model.
class RxTextFormField<T> extends StatefulWidget {
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

  // Standard Flutter TextFormField properties
  /// The group value for the form field.
  final Object groupId;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Force display an error message regardless of validation.
  final String? forceErrorText;

  /// Focuses this text field when the widget is first created.
  final bool autofocus;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// Controls how the text is capitalized.
  final TextCapitalization textCapitalization;

  /// The type of action button to show on the keyboard.
  final TextInputAction? textInputAction;

  /// Whether the text field should obscure the text (for passwords).
  final bool obscureText;

  /// The character used to obscure text when [obscureText] is true.
  final String obscuringCharacter;

  /// The decoration to use for the text field.
  final InputDecoration? decoration;

  /// Called when the user submits editable content.
  final ValueChanged<String>? onSubmitted;

  /// Called when the user initiates a focus change.
  final ValueChanged<bool>? onFocusChange;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// Defines the strut style used for the vertical layout.
  final StrutStyle? strutStyle;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// The minimum number of lines for the text to span.
  final int? minLines;

  /// Whether this field should expand to fill its parent.
  final bool expands;

  /// The maximum number of characters (Unicode scalar values) to allow in the text field.
  final int? maxLength;

  /// If true, prevents the field from allowing more than [maxLength] characters.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// The builder for a context menu that appears when the user long-presses on the text field.
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  /// Whether to show cursor.
  final bool? showCursor;

  /// The appearance of the keyboard.
  final Brightness? keyboardAppearance;

  /// The cursor color to use when the text field is focused.
  final Color? cursorColor;

  /// The cursor color to use when the text field has an error.
  final Color? cursorErrorColor;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// The shape of the cursor.
  final Radius? cursorRadius;

  /// Whether to enable autocorrection.
  final bool autocorrect;

  /// Configuration of smart dashes behavior.
  final SmartDashesType? smartDashesType;

  /// Configuration of smart quotes behavior.
  final SmartQuotesType? smartQuotesType;

  /// Whether to enable smart dashes.
  final bool enableSuggestions;

  /// The list of input formatters which are called when the user changes the text.
  final List<TextInputFormatter>? inputFormatters;

  /// Called when the user taps on this text field.
  final GestureTapCallback? onTap;

  /// Whether onTap should be called even if the field is disabled.
  final bool onTapAlwaysCalled;

  /// Called when the user taps outside this text field.
  final TapRegionCallback? onTapOutside;

  /// Called when the user taps up outside this text field.
  final TapRegionUpCallback? onTapUpOutside;

  /// Called when the user finishes editing.
  final VoidCallback? onEditingComplete;

  // Form-specific properties
  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  final FormFieldValidator<String>? validator;

  /// Called when the form is saved.
  final FormFieldSetter<String>? onSaved;

  /// Whether the form is able to receive user input.
  final bool? enabled;

  /// Whether to ignore pointer events for this text field.
  final bool? ignorePointers;

  /// The padding to apply to ensure the field is visible when scrolled into view.
  final EdgeInsets scrollPadding;

  /// Whether to enable interactive selection of text.
  final bool? enableInteractiveSelection;

  /// Controls the text selection handles and context menu.
  final TextSelectionControls? selectionControls;

  /// Builds the counter widget in the bottom right corner.
  final InputCounterWidgetBuilder? buildCounter;

  /// The physics of scrolling in the text field.
  final ScrollPhysics? scrollPhysics;

  /// The list of autofill hints that are used to help the user complete the field.
  final Iterable<String>? autofillHints;

  /// The mode to use for automatic validation.
  final AutovalidateMode? autovalidateMode;

  /// Controller for the scrollable widget inside the text field.
  final ScrollController? scrollController;

  /// Restoration ID to save and restore the state of the text field.
  final String? restorationId;

  /// Whether to enable personalized learning for the keyboard.
  final bool enableIMEPersonalizedLearning;

  /// The cursor for mouse pointer when hovering over the text field.
  final MouseCursor? mouseCursor;

  /// Configuration for spell check behavior.
  final SpellCheckConfiguration? spellCheckConfiguration;

  /// Configuration for the magnifier that appears when the user long-presses on text.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Controller for undo history.
  final UndoHistoryController? undoController;

  /// Called when a private command is received from the input method.
  final AppPrivateCommandCallback? onAppPrivateCommand;

  /// Whether the cursor should animate opacity.
  final bool? cursorOpacityAnimates;

  /// How tall the selection highlight should be.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// How wide the selection highlight should be.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// Determines when drag gestures should start.
  final DragStartBehavior dragStartBehavior;

  /// Configuration for content insertion.
  final ContentInsertionConfiguration? contentInsertionConfiguration;

  /// Controller for material states.
  final WidgetStatesController? statesController;

  /// How to clip the content of the text field.
  final Clip clipBehavior;

  /// Whether to enable stylus handwriting.
  final bool stylusHandwritingEnabled;

  /// Whether this text field can receive focus.
  final bool canRequestFocus;

  /// Creates a new [RxTextFormField].
  ///
  /// The [model] parameter is required.
  /// If [field] is provided, [onChanged] must also be provided.
  const RxTextFormField({
    super.key,
    required this.model,
    this.field,
    this.onChanged,
    this.groupId = EditableText,
    this.focusNode,
    this.forceErrorText,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofocus = false,
    this.readOnly = false,
    this.showCursor,
    this.obscuringCharacter = '•',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.maxLengthEnforcement,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onSubmitted,
    this.onTap,
    this.onTapAlwaysCalled = false,
    this.onTapOutside,
    this.onTapUpOutside,
    this.onEditingComplete,
    this.onFocusChange,
    this.validator,
    this.onSaved,
    this.inputFormatters,
    this.enabled,
    this.ignorePointers,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.cursorErrorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.scrollController,
    this.restorationId,
    this.enableIMEPersonalizedLearning = true,
    this.mouseCursor,
    this.contextMenuBuilder,
    this.spellCheckConfiguration,
    this.magnifierConfiguration,
    this.undoController,
    this.onAppPrivateCommand,
    this.cursorOpacityAnimates,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.dragStartBehavior = DragStartBehavior.start,
    this.contentInsertionConfiguration,
    this.statesController,
    this.clipBehavior = Clip.hardEdge,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.canRequestFocus = true,
  }) : assert(
         field == null || onChanged != null,
         'onChanged is required when field is provided',
       );

  @override
  State<RxTextFormField<T>> createState() => _RxTextFormFieldState<T>();
}

class _RxTextFormFieldState<T> extends State<RxTextFormField<T>> {
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
    return TextFormField(
      groupId: widget.groupId,
      controller: _controller,
      focusNode: widget.focusNode,
      forceErrorText: widget.forceErrorText,
      decoration: widget.decoration,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autofocus: widget.autofocus,
      readOnly: widget.readOnly,
      showCursor: widget.showCursor,
      obscuringCharacter: widget.obscuringCharacter,
      obscureText: widget.obscureText,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      maxLength: widget.maxLength,
      onTap:
          widget.onTap ??
          (widget.onFocusChange != null
              ? () {
                widget.onFocusChange!(true);
              }
              : null),
      onTapAlwaysCalled: widget.onTapAlwaysCalled,
      onTapOutside: widget.onTapOutside,
      onTapUpOutside: widget.onTapUpOutside,
      onEditingComplete:
          widget.onEditingComplete ??
          (widget.onFocusChange != null
              ? () {
                widget.onFocusChange!(false);
              }
              : null),
      onFieldSubmitted: widget.onSubmitted,
      onSaved: widget.onSaved,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      ignorePointers: widget.ignorePointers,
      cursorWidth: widget.cursorWidth,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      selectionControls: widget.selectionControls,
      buildCounter: widget.buildCounter,
      scrollPhysics: widget.scrollPhysics,
      autofillHints: widget.autofillHints,
      autovalidateMode: widget.autovalidateMode,
      scrollController: widget.scrollController,
      restorationId: widget.restorationId,
      enableIMEPersonalizedLearning: widget.enableIMEPersonalizedLearning,
      mouseCursor: widget.mouseCursor,
      contextMenuBuilder: widget.contextMenuBuilder,
      spellCheckConfiguration: widget.spellCheckConfiguration,
      magnifierConfiguration: widget.magnifierConfiguration,
      undoController: widget.undoController,
      onAppPrivateCommand: widget.onAppPrivateCommand,
      cursorOpacityAnimates: widget.cursorOpacityAnimates,
      selectionHeightStyle: widget.selectionHeightStyle,
      selectionWidthStyle: widget.selectionWidthStyle,
      dragStartBehavior: widget.dragStartBehavior,
      contentInsertionConfiguration: widget.contentInsertionConfiguration,
      statesController: widget.statesController,
      clipBehavior: widget.clipBehavior,
      stylusHandwritingEnabled: widget.stylusHandwritingEnabled,
      canRequestFocus: widget.canRequestFocus,
    );
  }
}
