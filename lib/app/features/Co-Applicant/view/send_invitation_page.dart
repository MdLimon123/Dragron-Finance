import 'package:demo_project/app/core/theme/app_colors.dart';
import 'package:demo_project/app/core/widget/custom_appbar.dart';
import 'package:demo_project/app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendInvitationPage extends StatelessWidget {
  const SendInvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: CustomAppBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 123),
              Center(
                child: Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    color: Color(0xFF10B981).withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mail_outline_rounded,
                    color: Color(0xFF10B981),
                    size: 32,
                  ),
                ),
              ),

              SizedBox(height: 21),

              // Title
              Center(
                child: Text(
                  "Invitation Sent!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292F36),
                  ),
                ),
              ),

              SizedBox(height: 8),

              // Subtitle
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "We've sent an invitation to ",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                    children: [
                      TextSpan(
                        text: "jane@example.com",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF292F36),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 22),

              // Share link box
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE0DBD8), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Or share this link",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF292F36),
                      ),
                    ),
                    SizedBox(height: 28),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFE0DBD8),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFFE0DBD8),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              "https://loansphere.app/invite/abc123xy",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF292F36),
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: "https://loansphere.app/invite/abc123xy",
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xFFFAF5F1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFFE0DBD8),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.copy_rounded,
                              size: 18,
                              color: Color(0xFF292F36),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 21),

              // Quote box
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFFFAF5F1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Color(0xFFE0DBD8), width: 1),
                ),
                child: Text(
                  '"If the property is jointly owned, the homeowner loan application must be in both names."',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),

              SizedBox(height: 37),

              CustomButton(
                onTap: () {
                  // Handle Done action
                },
                text: "Continue",
              ),

              SizedBox(height: 10),

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
                          "Skip & Continue Solo",
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
    );
  }
}
