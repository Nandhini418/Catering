class VerificationDocuments {
  bool isFrontAdded;
  bool isFrontUnclear;
  String? frontPath;

  bool isBackAdded;
  bool isBackUnclear;
  String? backPath;

  bool isSelfieAdded;
  bool isSelfieUnclear;
  String? selfiePath;

  String idNumber;

  VerificationDocuments({
    this.isFrontAdded = false,
    this.isFrontUnclear = false,
    this.frontPath,
    this.isBackAdded = false,
    this.isBackUnclear = false,
    this.backPath,
    this.isSelfieAdded = false,
    this.isSelfieUnclear = false,
    this.selfiePath,
    this.idNumber = 'XXXX XXXX 4821',
  });

  bool get hasAnyUnclear =>
      (isFrontAdded && isFrontUnclear) ||
      (isBackAdded && isBackUnclear) ||
      (isSelfieAdded && isSelfieUnclear);

  bool get isAllClear => !hasAnyUnclear;

  String get unclearTitle {
    if (isBackUnclear && !isFrontUnclear && !isSelfieUnclear) {
      return 'ID back photo is unclear';
    } else if (isFrontUnclear && !isBackUnclear && !isSelfieUnclear) {
      return 'ID front photo is unclear';
    } else if (isSelfieUnclear && !isFrontUnclear && !isBackUnclear) {
      return 'Selfie with ID is unclear';
    } else if (hasAnyUnclear) {
      return 'Submitted photos are unclear';
    }
    return 'All documents clear & verified';
  }

  String get unclearDescription {
    if (isBackUnclear && !isFrontUnclear && !isSelfieUnclear) {
      return 'The details were blurred. Upload a sharper photo with all corners visible.';
    } else if (isFrontUnclear && !isBackUnclear && !isSelfieUnclear) {
      return 'The details were blurred. Upload a sharper photo with all corners visible.';
    } else if (isSelfieUnclear && !isFrontUnclear && !isBackUnclear) {
      return 'Your face or ID details were blurred. Upload a sharper, well-lit photo.';
    } else if (hasAnyUnclear) {
      return 'Some uploaded photos were blurry. Upload sharper photos with all corners visible.';
    }
    return 'All 3 documents meet requirements and are ready for approval.';
  }
}
