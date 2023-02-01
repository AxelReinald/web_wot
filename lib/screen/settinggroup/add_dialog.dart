// import 'package:flutter/material.dart';

// class AddDialog extends StatefulWidget {
//   const AddDialog({Key? key}) : super(key: key);

//   @override
//   State<AddDialog> createState() => _AddDialogState();
// }

// class _AddDialogState extends State<AddDialog> {
//   @override
//   Future<void> AddDialog(BuildContext context) async {
//     return await showDialog(
//       //fungsi add dialog
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Colors.white,
//         title: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Setting Group - Add',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.black),
//                 ),
//                 Spacer(),
//                 IconButton(
//                     onPressed: () => Navigator.pop(context, true),
//                     icon: Icon(
//                       Icons.close,
//                       color: Colors.black,
//                       size: 25,
//                     ))
//               ],
//             ),
//             Divider(
//               thickness: 2,
//               color: Colors.blue,
//             )
//           ],
//         ),
//         content: Container(
//           height: 400,
//           width: 400,
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Setting Group Code',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 TextFormField(
//                   controller: _SettingGroupCode,
//                   maxLength: 20,
//                   style: const TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide:
//                           BorderSide(width: 1.0, color: Colors.grey.shade400),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Harap diisi, Tidak boleh kosong';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   'Setting Group Name',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 TextFormField(
//                   controller: _SettingGroupName,
//                   maxLength: 20,
//                   style: const TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide:
//                           BorderSide(width: 1.0, color: Colors.grey.shade400),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Harap diisi, Tidak boleh kosong';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   'Description',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 TextFormField(
//                   controller: _Description,
//                   maxLines: 5, // <-- SEE HERE
//                   minLines: 1,
//                   maxLength: 150,
//                   // maxLength: 150,
//                   style: const TextStyle(color: Colors.black),
//                   decoration: InputDecoration(
//                     contentPadding:
//                         EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                     fillColor: Colors.white,
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide:
//                           BorderSide(width: 1.0, color: Colors.grey.shade400),
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     OutlinedButton(
//                       onPressed: () => Navigator.pop(context, true),
//                       child: Text(
//                         'Cancel',
//                         style: TextStyle(color: Colors.blue),
//                       ),
//                       style: OutlinedButton.styleFrom(
//                         primary: Colors.white,
//                         side: BorderSide(
//                             color: Colors.blue, width: 1), //<-- SEE HERE
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           setState(() {
//                             addset.groupCd = _SettingGroupCode.text;
//                             addset.groupDesc = _SettingGroupName.text;
//                             addset.groupName = _Description.text;
//                             bloc.add(Add(addset));
//                           });
//                           Navigator.pop(context);
//                         }
//                       },
//                       child: Text(
//                         'Save',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.blue),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // // Future AddDialog() => 
