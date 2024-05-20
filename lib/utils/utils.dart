class Utils {
  static String convertSemesterToRomanYear(int semesterNo) {
    int year = (semesterNo / 2).ceil();
    switch (year) {
      case 1:
        return 'I';
      case 2:
        return 'II';
      case 3:
        return 'III';
      case 4:
        return 'IV';
      default:
        return 'Unknown';
    }
  }
}
