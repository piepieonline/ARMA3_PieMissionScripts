_map = toLower worldName;

private _civiMap = createHashMap;

// Western European (Altis, Stratis, Malden, Korsac)
_civiMap set ["altis", [
    "C_Man_casual_1_F",
    "C_Man_casual_2_F",
    "C_Man_casual_3_F",
    "C_Man_casual_4_v2_F",
    "C_Man_casual_5_v2_F",
    "C_Man_casual_6_v2_F",
    "C_Man_casual_7_F",
    "C_Man_casual_8_F",
    "C_Man_formal_1_F",
    "C_Man_formal_2_F",
    "C_Man_formal_3_F",
    "C_Man_formal_4_F",
    "C_Man_smart_casual_1_F",
    "C_Man_smart_casual_2_F"
]];
_civiMap set ["stratis", _civiMap get "altis"];
_civiMap set ["malden", _civiMap get "altis"];
_civiMap set ["wl_rosche", _civiMap get "altis"];
_civiMap set ["vtf_korsac", _civiMap get "altis"];
_civiMap set ["vtf_korsac_winter", _civiMap get "altis"];

// Eastern European (Chernarus, Sahrani)
_civiMap set ["cup_chernarus_a3", [
    "UK3CB_CHC_C_CIV"
]];
_civiMap set ["sara_dbe1", _civiMap get "cup_chernarus_a3"];

// African Desert (Mutambara)
_civiMap set ["swu_public_rhode_map", [
    "UK3CB_ADC_C_CIV_CHR"
]];

// Islander (Tanoa)
_civiMap set ["tanoa", [
    "C_Man_casual_1_F_tanoan",
    "C_Man_casual_2_F_tanoan",
    "C_Man_casual_3_F_tanoan",
    "C_Man_casual_4_v2_F_tanoan",
    "C_Man_casual_5_v2_F_tanoan",
    "C_Man_casual_6_v2_F_tanoan",
    "C_Man_casual_7_F_tanoan",
    "C_Man_casual_8_F_tanoan",
    "C_Man_formal_1_F_tanoan",
    "C_Man_formal_2_F_tanoan",
    "C_Man_formal_3_F_tanoan",
    "C_Man_formal_4_F_tanoan",
    "C_Man_smart_casual_1_F_tanoan",
    "C_Man_smart_casual_2_F_tanoan"
]];

// Asian (Isla Pera)
_civiMap set ["islapera", [
    "C_Man_casual_1_F_asia",
    "C_Man_casual_2_F_asia",
    "C_Man_casual_3_F_asia",
    "C_Man_casual_4_v2_F_asia",
    "C_Man_casual_5_v2_F_asia",
    "C_Man_casual_6_v2_F_asia",
    "C_Man_casual_7_F_asia",
    "C_Man_casual_8_F_asia",
    "C_Man_formal_1_F_asia",
    "C_Man_formal_2_F_asia",
    "C_Man_formal_3_F_asia",
    "C_Man_formal_4_F_asia",
    "C_Man_smart_casual_1_F_asia",
    "C_Man_smart_casual_2_F_asia"
]];

// Middle eastern traditional (Takistan, Fallujah)
_civiMap set ["takistan", [
    "UK3CB_TKC_C_CIV"
]];
_civiMap set ["fallujah", _civiMap get "takistan"];
_civiMap set ["kunduz_valley", _civiMap get "takistan"];

// Vietnam War
_civiMap set ["vn_khe_sanh", [
    "vn_c_men_01",
    "vn_c_men_02",
    "vn_c_men_03",
    "vn_c_men_04",
    "vn_c_men_05",
    "vn_c_men_06",
    "vn_c_men_07",
    "vn_c_men_08",
    "vn_c_men_09",
    "vn_c_men_10",
    "vn_c_men_11",
    "vn_c_men_12",
    "vn_c_men_13",
    "vn_c_men_14",
    "vn_c_men_15",
    "vn_c_men_16",
    "vn_c_men_17",
    "vn_c_men_18",
    "vn_c_men_19",
    "vn_c_men_20",
    "vn_c_men_21",
    "vn_c_men_22",
    "vn_c_men_23",
    "vn_c_men_24",
    "vn_c_men_25",
    "vn_c_men_26",
    "vn_c_men_27",
    "vn_c_men_28",
    "vn_c_men_29",
    "vn_c_men_30",
    "vn_c_men_31",
    "vn_c_men_32"
]];

// Fallback if the map isn't setup
if(!(_map in _civiMap)) then
{
    [format ["WARNING: Map %1 doesn't have civilians defined. Using altis as a base.", _map]] remoteExec ["systemChat"];
    _map = "altis";
};

_civiMap get _map