import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AppDropDownWidget extends StatelessWidget {
  final List<DropdownMenuItem>? items;
  final List<String> options;

  final dynamic value;
  final String? title;
  final String? selectedTitle;

  // final String hintText;
  final void Function(dynamic)? onChanged;
  final bool? isLoading;
  const AppDropDownWidget({
    super.key,
    this.items,
    this.title,
    this.value,
    this.isLoading,
    // required this.hintText,
    this.onChanged,
    required this.options,
    this.selectedTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: title != null,
            child: Text(
              " $title",
              // style: AppStyles().mont14500DarkGrey,
            ),
          ),
          const SizedBox(height: 10),
          // ====================
          DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              hint: Text(
                (selectedTitle?.isNotEmpty ?? false)
                    ? selectedTitle ?? 'Please Select'
                    : 'Please Select',
                // style: appTextStyles.p16400ADB.copyWith(
                //     color: selectedTitle != null ? Colors.black : null),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              items: items ??
                  options
                      .map(
                        (e) => DropdownMenuItem(value: e, child: Text(e)),
                      )
                      .toList(),
              onChanged: onChanged,
              buttonStyleData: ButtonStyleData(
                padding: const EdgeInsets.only(left: 0, right: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  color: Colors.grey.shade200,
                ),
              ),
              iconStyleData: const IconStyleData(
                openMenuIcon: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.grey,
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey,
                ),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                ),
                offset: const Offset(0, -10),
                // padding: EdgeInsets.all(9),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 55,
                padding: EdgeInsets.only(left: 14, right: 14),
              ),
            ),
          ),
          // ========================
        ],
      ),
    );
  }
}
