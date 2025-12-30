import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weqaa/constants/constants.dart';
import 'package:weqaa/constants/text_styles_constants.dart';
import 'package:weqaa/core/common/widgets/common/app_text_field.dart';

class AppMultiDropDownTextField<T> extends StatefulWidget {
  const AppMultiDropDownTextField({
    super.key,
    required this.items,
    required this.selectedItems,
    required this.onChanged,
    this.validator,
    this.hint,
    this.prefix,
    this.suffix,
    this.title,
    this.borderRadius = 12,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.errorTextStyle,
    this.fillColor,
    this.borderColor,
    this.isBigTitle = false,
    this.titleStyle,
  });

  final List<DropdownMenuItem<T>> items;
  final List<T> selectedItems;
  final void Function(List<T>) onChanged;
  final FormFieldValidator<String>? validator;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final String? title;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final TextStyle? errorTextStyle;
  final Color? fillColor;
  final Color? borderColor;
  final bool isBigTitle;
  final TextStyle? titleStyle;

  @override
  AppMultiDropDownTextFieldState<T> createState() =>
      AppMultiDropDownTextFieldState<T>();
}

class AppMultiDropDownTextFieldState<T>
    extends State<AppMultiDropDownTextField<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<DropdownMenuItem<T>> _filteredItems = [];
  bool _isOpen = false;
  final TextEditingController _selectedItemsController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _selectedItemsController.text = widget.selectedItems.join(', ');
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget.items;
      } else {
        _filteredItems = widget.items.where((item) {
          if (item.child is Text) {
            final Text textWidget = item.child as Text;
            return textWidget.data
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
                false;
          } else {
            return item.child
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase());
          }
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title!,
                style: kSmall12PxRegular,
              ),
            ),
          ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isOpen = !_isOpen;
              if (_isOpen) {
                _filteredItems = widget.items;
              }
            });
          },
          child: AppTextField(
            readOnly: true,
            onTap: () {
              setState(() {
                _isOpen = !_isOpen;
                if (_isOpen) {
                  _filteredItems = widget.items;
                }
              });
            },
            controller: _selectedItemsController,
            hint: widget.hint,
            validator: widget.validator,
            suffix: Icon(
              _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: kHintColor,
              size: 16,
            ),
          ),
        ),
        if (_isOpen)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: widget.borderColor ?? kStrokeColor),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: 'search'.tr(),
                    hintStyle: kBody16PxRegular.copyWith(color: kHintColor),
                    border: InputBorder.none,
                  ),
                  onChanged: _filterItems,
                ),
                const Divider(),
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: _filteredItems.map((item) {
                      final isSelected =
                          widget.selectedItems.contains(item.value);
                      return CheckboxListTile(
                        title: item.child,
                        value: isSelected,
                        activeColor: kPrimaryColor,
                        onChanged: (bool? value) {
                          setState(() {
                            List<T> updatedItems =
                                List.from(widget.selectedItems);
                            if (value == true) {
                              updatedItems.add(item.value as T);
                            } else {
                              updatedItems.remove(item.value);
                            }
                            widget.onChanged(updatedItems);
                            _selectedItemsController.text =
                                updatedItems.join(', ');
                          });
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  InputBorder _border({bool focused = false, Color? color}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        borderSide: BorderSide(
          color: color ?? widget.borderColor ?? kStrokeColor,
        ),
      );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
