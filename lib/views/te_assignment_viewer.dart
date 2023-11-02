part of studious.views;

class Teacher_Assignment_Viewer extends StatelessWidget {
  final Assignment assignment;
  final String className;

  const Teacher_Assignment_Viewer({
    required this.assignment,
    required this.className,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewTitle: assignment.assignmentName,
      child: ShelfGallery(
        height: screenHeight(context) - 160,
        width: screenWidth(context) + 60,
        shelves: [
          Shelf(
            title: 'Unread',
            color: Colors.grey,
            cards: List<Widget>.generate(
              14,
              (index) => StatusCard(
                color: Colors.grey,
                assignmentData: assignment,
                person: User(
                  name: 'Joanne Lim',
                  formClass: '5.13',
                ),
              ),
            ),
            width: 220,
            height: 900,
          ),
          Shelf(
            title: 'In Progress',
            color: Colors.lightBlue,
            cards: List<Widget>.generate(
              14,
              (index) => StatusCard(
                color: Colors.lightBlue,
                assignmentData: assignment,
                person: User(
                  name: 'Joanne Lim',
                  formClass: '5.13',
                ),
              ),
            ),
            width: 220,
            height: 900,
          ),
          Shelf(
            title: 'Attempted',
            color: Colors.purple,
            cards: List<Widget>.generate(
              14,
              (index) => StatusCard(
                color: Colors.purple,
                assignmentData: assignment,
                person: User(
                  name: 'Joanne Lim',
                  formClass: '5.13',
                ),
              ),
            ),
            width: 220,
            height: 900,
          ),
          Shelf(
            title: 'Submitted',
            color: Colors.green,
            cards: List<Widget>.generate(
              14,
              (index) => StatusCard(
                color: Colors.green,
                assignmentData: assignment,
                person: User(
                  name: 'Joanne Lim',
                  formClass: '5.13',
                ),
              ),
            ),
            width: 220,
            height: 900,
          ),
          Shelf(
            title: 'Overdue',
            color: Colors.red,
            cards: List<Widget>.generate(
              14,
              (index) => StatusCard(
                color: Colors.red,
                assignmentData: assignment,
                person: User(
                  name: 'Joanne Lim',
                  formClass: '5.13',
                ),
              ),
            ),
            width: 220,
            height: 900,
          ),
        ],
      ),
    );
  }
}
