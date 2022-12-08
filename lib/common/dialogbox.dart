// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_wot/bloc/settingbloc/setting_group_bloc.dart';
import 'package:web_wot/model/setting_group.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(

//     );
//   }
// }

class EditDialog extends StatefulWidget {
   final String settingGroupCode;
   final String settingGroupName;
  EditDialog({
    Key? key,
     required this.settingGroupCode,
     required this.settingGroupName
  }) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

TextEditingController _EditGroupCode = TextEditingController();
TextEditingController _EditGroupName = TextEditingController();
TextEditingController _EditDescription = TextEditingController();
// late SettingGroupBloc bloc;
AddRequestSettings addset = new AddRequestSettings();

class _EditDialogState extends State<EditDialog> {
  @override
  Widget build(BuildContext context) {
    print(widget.settingGroupCode);
    print(widget.settingGroupName);
    // addset.groupCd = widget.settingGroupCode;
    // bloc = BlocProvider.of<SettingGroupBloc>(context);
    return Container(
      height: 200,
      width: 200,
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Setting Group - Edit',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Spacer(),
            IconButton(
                onPressed: () => Navigator.pop(context, true),
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 25,
                ))
          ],
        ),
        content: Container(
          height: 400,
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Setting Group Code',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300),
                  // color: Colors.blue.shade100,
                  child: TextFormField(
                    //controller: _EditGroupCode,
                    initialValue: widget.settingGroupCode ,
                    readOnly: true,
                    // maxLength: 20,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Setting Group Name',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                //controller: _EditGroupName,
                maxLength: 20,
                 initialValue: widget.settingGroupName,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(width: 1.0, color: Colors.grey.shade400),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Description',
                style: TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _EditDescription,
                maxLines: 5, // <-- SEE HERE
                minLines: 1,
                maxLength: 150,
                // initialValue: widget.settingGroupName,
                // maxLength: 150,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        BorderSide(width: 1.0, color: Colors.grey.shade400),
                  ),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      side:
                          BorderSide(color: Colors.blue, width: 1), //<-- SEE HERE
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      addset.groupDesc = _EditGroupName.text;
                      addset.groupName = _EditDescription.text;
                      // bloc.add(Edit(addset));
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
