import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/di/dependency_injection.dart';
import 'package:rafiq/core/thieming/app_colors.dart';
import 'package:rafiq/core/thieming/app_styles.dart';
import 'package:rafiq/core/widgets/apptextformfield.dart';
import 'package:rafiq/core/widgets/custom_appbar.dart';
import 'package:rafiq/core/widgets/custom_buttom.dart';
import 'package:rafiq/core/widgets/label_field.dart';
import 'package:rafiq/features/profile/domain/entities/profile_entity.dart';
import 'package:rafiq/features/profile/persentation/logic/profile_cubit.dart';
import 'package:rafiq/features/profile/persentation/logic/profile_state.dart';

class EditProfileView extends StatefulWidget {
  final ProfileEntity user; 

  const EditProfileView({super.key, required this.user});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController ageController;
  String? selectedStatus;
  String? selectedChildren;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
    phoneController = TextEditingController(text: widget.user.phone);
    ageController = TextEditingController(text: widget.user.age.toString());
    selectedStatus = widget.user.status;
    selectedChildren = widget.user.childrenCount.toString();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
appBar:  CustomAppBar(title: "Edit Profile"),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is UpdateProfileSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Profile Updated!")));
              Navigator.pop(context); // ارجعي بعد النجاح
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.verticalSpace,
                    _buildAvatar(),
                    30.verticalSpace,
                    
                    const LabelField(text: "First Name"),
                    AppTextFormField(
                      hintText: "Enter your first name",
                      controller: firstNameController,
                      validator: (val) => val!.isEmpty ? "Required" : null,
                      suffixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                    ),

                    20.verticalSpace,
                    const LabelField(text: "Last Name"),
                    AppTextFormField(
                      hintText: "Enter your last name",
                      controller: lastNameController,
                      validator: (val) => val!.isEmpty ? "Required" : null,
                      suffixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                    ),

                    20.verticalSpace,
                    const LabelField(text: "Phone Number"),
                    AppTextFormField(
                      hintText: "Phone Number",
                      controller: phoneController,
                      validator: (val) => val!.isEmpty ? "Required" : null,
                      suffixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
                    ),

                    20.verticalSpace,
                    const LabelField(text: "Age"),
                    AppTextFormField(
                      hintText: "Age",
                      controller: ageController,
                      validator: (val) => val!.isEmpty ? "Required" : null,
                      keyboardType: TextInputType.number,
                    ),

                    20.verticalSpace,
                    const LabelField(text: "Status"),
                    _buildDropdown(["Married", "Single"], selectedStatus, (val) => selectedStatus = val),

                    20.verticalSpace,
                    const LabelField(text: "Number of Children"),
                    _buildDropdown(["1", "2", "3", "4+"], selectedChildren, (val) => selectedChildren = val),

                    40.verticalSpace,
                    
                    CustomButton(
                      text: state is UpdateProfileLoading ? "Saving..." : "Save changes", 
                      onPressed: state is UpdateProfileLoading ? null : () => _save(context),
                    ),
                    
                    12.verticalSpace,
                    CustomButton(
                      text: "Cancel", 
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: Colors.white,
                      textColor: AppColors.primaryNormal,
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final updatedUser = ProfileEntity(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text,
        age: int.parse(ageController.text),
        status: selectedStatus ?? "Single",
        childrenCount: int.parse(selectedChildren!.replaceAll("+", "")),
        bio: widget.user.bio,
      );
      context.read<ProfileCubit>().updateProfile(updatedUser);
    }
  }


  Widget _buildAvatar() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60.r,
            backgroundImage: const AssetImage('assets/images/user_avatar.png'),
          ),
          CircleAvatar(
            radius: 15.r,
            backgroundColor: AppColors.primaryNormal,
            child: Icon(Icons.camera_alt, color: Colors.white, size: 15.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String? value, Function(String?) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: const InputDecoration(border: InputBorder.none),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}