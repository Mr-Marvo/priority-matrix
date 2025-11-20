enum MatrixType {
  doItNow,
  planIt,
  delegateIt,
  dropIt,
}

extension MatrixTypeExtension on MatrixType {
  String get displayName {
    switch (this) {
      case MatrixType.doItNow:
        return 'Do It Now';
      case MatrixType.planIt:
        return 'Plan It';
      case MatrixType.delegateIt:
        return 'Delegate It';
      case MatrixType.dropIt:
        return 'Drop It';
    }
  }

  String get description {
    switch (this) {
      case MatrixType.doItNow:
        return 'Urgent & Important';
      case MatrixType.planIt:
        return 'Important, Not Urgent';
      case MatrixType.delegateIt:
        return 'Urgent, Not Important';
      case MatrixType.dropIt:
        return 'Not Urgent, Not Important';
    }
  }

  int get index {
    switch (this) {
      case MatrixType.doItNow:
        return 0;
      case MatrixType.planIt:
        return 1;
      case MatrixType.delegateIt:
        return 2;
      case MatrixType.dropIt:
        return 3;
    }
  }

  static MatrixType fromIndex(int index) {
    switch (index) {
      case 0:
        return MatrixType.doItNow;
      case 1:
        return MatrixType.planIt;
      case 2:
        return MatrixType.delegateIt;
      case 3:
        return MatrixType.dropIt;
      default:
        return MatrixType.doItNow;
    }
  }
}
