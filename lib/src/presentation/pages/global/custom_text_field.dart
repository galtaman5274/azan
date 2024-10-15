// import 'package:azan/presentation/pages/global/text_with_mark.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class CustomTextFormField extends StatelessWidget {
//   const CustomTextFormField({
//     Key? key,
//     this.hintText = '',
//     this.borderRadius = 8,
//     this.textInputAction,
//     this.maxLines = 1,
//     this.suffixIcon,
//     this.controller,
//     this.onTap,
//     this.readOnly = false,
//     this.textInputType,
//     this.isRequired = true,
//     this.textFormFieldHeight = 50,
//     this.contentPadding = const EdgeInsets.all(5),
//     this.prefixIcon,
//     this.onChanged,
//     this.isFilled = false,
//     this.onEditingComplete,
//     this.padding = EdgeInsets.zero,
//     this.obscureText = false,
//     this.title,
//     this.isTextRequired = false,
//     this.filledColor = const Color(0x00000000),
//     this.titleTextStyle,
//     this.focusNode,
//     this.hintStyle,
//     this.onFieldSubmitted,
//     this.validator,
//     this.style = const TextStyle(fontFamily: 'Intro',color: Colors.black),
//     this.inputFormatter,
//   }) : super(key: key);
//
//   final String hintText;
//   final String? title;
//   final TextStyle? titleTextStyle;
//   final double borderRadius;
//   final TextInputAction? textInputAction;
//   final TextInputType? textInputType;
//   final int? maxLines;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final TextEditingController? controller;
//   final GestureTapCallback? onTap;
//   final Function(String?)? onChanged;
//   final Function()? onEditingComplete;
//   final Function(String?)? onFieldSubmitted;
//   final bool readOnly;
//   final bool isRequired;
//   final double textFormFieldHeight;
//   final EdgeInsets contentPadding;
//   final EdgeInsets padding;
//   final bool isFilled;
//   final Color filledColor;
//   final bool obscureText;
//   final bool isTextRequired;
//   final FocusNode? focusNode;
//   final TextStyle? hintStyle;
//   final TextStyle? style;
//   final String? Function(String?)? validator;
//   final List<TextInputFormatter>? inputFormatter;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         isTextRequired
//             ? TextWithMark(
//           title: title ?? '',
//           isRequired: false,
//           textStyle: titleTextStyle,
//         )
//             : const SizedBox(),
//         SizedBox(
//           height: isTextRequired ? 3 : 0,
//         ),
//         Padding(
//           padding: padding,
//           child: SizedBox(
//             height: textFormFieldHeight,
//             child: TextFormField(
//               onTapOutside: (event) {
//                 FocusScopeNode currentFocus = FocusScope.of(context);
//                 if (!currentFocus.hasPrimaryFocus) {
//                   currentFocus.unfocus();
//                 }
//               },
//               textInputAction: textInputAction,
//               maxLines: maxLines,
//               onFieldSubmitted: onFieldSubmitted,
//               readOnly: readOnly,
//               focusNode: focusNode,
//               onEditingComplete: onEditingComplete,
//               onChanged: onChanged,
//               onTap: onTap,
//               keyboardType: textInputType,
//               validator: validator,
//               inputFormatters: inputFormatter,
//               controller: controller,
//               obscureText: obscureText,
//               style: style,
//               decoration: InputDecoration(
//                 hintText: hintText,
//                 filled: isFilled,
//                 hintStyle: hintStyle ??
//                     TextStyle(
//                       fontFamily: 'Intro',
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w500,
//                       color: const Color(0xFF575353),
//                     ),
//                 fillColor: isFilled ? filledColor : Colors.black,
//                 suffixIcon: suffixIcon,
//                 prefixIcon: prefixIcon,
//                 contentPadding: contentPadding,
//                 border: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.transparent),
//                     borderRadius: BorderRadius.circular(borderRadius)),
//                 disabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.transparent),
//                     borderRadius: BorderRadius.circular(borderRadius)),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.transparent),
//                     borderRadius: BorderRadius.circular(borderRadius)),
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Colors.transparent),
//                     borderRadius: BorderRadius.circular(borderRadius)),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
