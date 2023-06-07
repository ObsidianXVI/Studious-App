part of studious.ds;

class ClassCard extends StatelessWidget {
  final StudentClass studentClassData;

  const ClassCard({
    required this.studentClassData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 900,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: StudiousTheme.purple,
            width: 1,
          ),
          color: StudiousTheme.white,
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(studentClassData.className),
                    Text(studentClassData.teacherName),
                    Text(studentClassData.memberCount.toString()),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 5,
                width: double.infinity,
                color: studentClassData.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
