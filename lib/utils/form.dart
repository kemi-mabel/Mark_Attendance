/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String matricno;
  String attendance;

  FeedbackForm(this.matricno, this.attendance);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['name']}", "${json['attendance']}");
  }

  // Method to make GET parameters.
  Map toJson() => {'matricno': matricno, 'attendance': attendance};
}
