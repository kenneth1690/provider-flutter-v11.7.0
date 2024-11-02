import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';
import '../components/base_scaffold_widget.dart';
import '../main.dart';
import '../models/user_type_response.dart';
import '../networks/rest_apis.dart';
import '../utils/configs.dart';
import '../utils/constant.dart';

class AddHandymanCommissionTypeListScreen extends StatefulWidget {
  final UserTypeData? typeData;
  final Function? onUpdate;

  AddHandymanCommissionTypeListScreen({this.typeData, this.onUpdate});

  @override
  AddHandymanCommissionTypeListScreenState createState() => AddHandymanCommissionTypeListScreenState();
}

class AddHandymanCommissionTypeListScreenState extends State<AddHandymanCommissionTypeListScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameCont = TextEditingController();
  TextEditingController commissionCont = TextEditingController();
  TextEditingController typeCont = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode commissionFocus = FocusNode();
  FocusNode typeFocus = FocusNode();
  FocusNode statusFocus = FocusNode();

  String selectedType = SERVICE_TYPE_FIXED;
  String selectedStatusType = ACTIVE;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (widget.typeData != null) {
      nameCont.text = widget.typeData!.name.validate();
      commissionCont.text = widget.typeData!.commission.validate().toString();

      if (widget.typeData!.type.validate() == COMMISSION_TYPE_PERCENTAGE || widget.typeData!.type.validate() == COMMISSION_TYPE_PERCENT) {
        selectedType = COMMISSION_TYPE_PERCENTAGE;
      } else {
        selectedType = widget.typeData!.type.validate();
      }
      selectedStatusType = widget.typeData!.status.validate() == 1 ? ACTIVE : INACTIVE;
      setState(() {});
    }
  }

  /// Add Provider & Handyman Type List
  Future<void> addProviderHandymanTypeList() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);
      Map request = {
        "id": widget.typeData != null ? widget.typeData!.id : null,
        "name": nameCont.text.validate(),
        "commission": commissionCont.text.validate(),
        "type": selectedType,
        "status": selectedStatusType == ACTIVE ? 1 : 0,
      };
      appStore.setLoading(true);
      await saveProviderHandymanTypeList(request: request).then((value) {
        appStore.setLoading(false);
        toast(value.message);

        finish(context, true);
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
    }
  }
  

  String title() {
      return widget.typeData == null ? languages.addHandymanCommission : languages.editHandymanCommission;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: title(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                textFieldType: TextFieldType.NAME,
                controller: nameCont,
                focus: nameFocus,
                nextFocus: commissionFocus,
                errorThisFieldRequired: languages.hintRequired,
                decoration: inputDecoration(context, hint: languages.typeName),
              ),
              16.height,
              AppTextField(
                textFieldType: TextFieldType.OTHER,
                controller: commissionCont,
                focus: commissionFocus,
                nextFocus: typeFocus,
                decoration: inputDecoration(context, hint: languages.commission),
                keyboardType: TextInputType.number,
                validator: (s) {
                  if (s!.isEmptyOrNull) {
                    return languages.hintRequired;
                  } else {
                    RegExp reg = RegExp(r'^\d.?\d(,\d*)?$');

                    if (!reg.hasMatch(s)) {
                      return languages.enterValidCommissionValue;
                    }
                  }

                  return null;
                },
              ),
              16.height,
              DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem(
                    child: Text(languages.lblFixed, style: primaryTextStyle()),
                    value: SERVICE_TYPE_FIXED,
                  ),
                  DropdownMenuItem(
                    child: Text(languages.percentage, style: primaryTextStyle()),
                    value: COMMISSION_TYPE_PERCENTAGE,
                  ),
                ],
                focusNode: typeFocus,
                dropdownColor: context.cardColor,
                decoration: inputDecoration(context, hint: languages.lblType),
                value: selectedType,
                validator: (value) {
                  if (value == null) return errorThisFieldRequired;
                  return null;
                },
                onChanged: (c) {
                  hideKeyboard(context);
                  selectedType = c.validate();
                },
              ),
              16.height,
              DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem(
                    child: Text(languages.active, style: primaryTextStyle()),
                    value: ACTIVE,
                  ),
                  DropdownMenuItem(
                    child: Text(languages.inactive, style: primaryTextStyle()),
                    value: INACTIVE,
                  ),
                ],
                focusNode: statusFocus,
                dropdownColor: context.cardColor,
                decoration: inputDecoration(context, hint: languages.selectStatus),
                value: selectedStatusType,
                validator: (value) {
                  if (value == null) return errorThisFieldRequired;
                  return null;
                },
                onChanged: (c) {
                  hideKeyboard(context);
                  selectedStatusType = c.validate();
                },
              ),
              24.height,
              AppButton(
                text: languages.btnSave,
                color: primaryColor,
                width: context.width(),
                onTap: () {
                  if (widget.typeData == null || widget.typeData!.deletedAt == null) {
                    ifNotTester(context, () {
                      addProviderHandymanTypeList();
                    });
                  } else {
                    toast(languages.youCanTUpdateDeleted);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
