map = toLower worldName;

private _civiMap = createHashMap;

// Altis civis
_civiMap set ["altis", ["C_Man_formal_3_F", "C_Man_casual_8_F"]];
_civiMap set ["stratis", _civiMap get "altis"];

_civiMap get map