// features/assessment/presentation/widgets/assessment_charts_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssessmentChartsSection extends StatelessWidget {
  final int confidence;
  final Map<String, double> dimensions;

  const AssessmentChartsSection({
    super.key, 
    required this.confidence, 
    required this.dimensions
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Confidence Level Card
        Expanded(
          child: _buildInfoCard(
            title: 'CONFIDENCE LEVEL',
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 80.h,
                  width: 80.h,
                  child: CircularProgressIndicator(
                    value: confidence / 100,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey[200],
                    color: const Color(0xffB6C93B),
                  ),
                ),
                Text('$confidence%', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildInfoCard(
            title: 'TRAIT BREAKDOWN',
            child: Column(
              children: [
                // ملاحظة: الرسم السداسي محتاج CustomPainter، حالياً هنحط مكان تشبيهي
                Icon(Icons.hexagon_outlined, size: 60.h, color: Colors.blue[100]),
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 10.w,
                  children: dimensions.entries.map((e) => _buildSmallScore(e.key, e.value.toInt())).toList(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          SizedBox(height: 15.h),
          child,
        ],
      ),
    );
  }

  Widget _buildSmallScore(String label, int score) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 3, backgroundColor: score > 60 ? Colors.green : Colors.orange),
        SizedBox(width: 4.w),
        Text('$label: $score', style: TextStyle(fontSize: 10.sp)),
      ],
    );
  }
}