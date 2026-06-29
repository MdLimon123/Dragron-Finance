import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:demo_project/app/core/widget/custom_text_field.dart';
import 'package:demo_project/app/features/Co-Applicant/view/send_invitation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CoApplicationPage extends StatelessWidget {
  const CoApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, color: Color(0xFF292F36))),

                InkWell(
                  onTap: () {
                        Get.back();
                  },
                  child: Icon(Icons.close, color: Color(0xFF292F36))),
              ],
            ),
            SizedBox(height: 14),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Co-Applicant',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF292F36),
                      ),
                    ),

                    SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAF5F1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Color(0xFFE0DBD8), width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              height: 56,
                              width: 56,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFA41F13),
                                    Color(0xFF292F36),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/icon/person_add.svg',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 33),
                          Center(
                            child: Text(
                              "Invite a Co-Applicant",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF292F36),
                              ),
                            ),
                          ),

                          SizedBox(height: 21),
                          Text(
                            "If your property jointly owned the homeowner loan application must be in both names. ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "Co-Applicant Name",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF292F36),
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomTextField(
                      filColor: Colors.white,
                      filled: true,
                      hintText: "Enter Co-Applicant Name",
                    ),

                    SizedBox(height: 17),
                    Text(
                      "Co-Applicant Name",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF292F36),
                      ),
                    ),
                    SizedBox(height: 8),

                    CustomTextField(
                      filColor: Colors.white,
                      filled: true,
                      hintText: "Enter Co-Applicant Email",
                    ),

                    SizedBox(height: 18),

                    CustomButton(
                      onTap: () {
                        Get.to(() => SendInvitationPage());
                      },
                      text: "Send Invitation",
                    ),

                    SizedBox(height: 21),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Color(0xFF6B7280),
                            thickness: 0.9,
                            endIndent: 10,
                          ),
                        ),
                        Text(
                          "or",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Color(0xFF6B7280),
                            thickness: 0.9,
                            indent: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 21),

                    Container(
                      width: double.infinity,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Color(0xFFFAF5F1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xFFE0DBD8), width: 1),
                      ),
                      child: Center(
                        child: Text(
                          "Skip for Now",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF292F36),
                          ),
                        ),
                      ),
                    ),
                 
                 
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
