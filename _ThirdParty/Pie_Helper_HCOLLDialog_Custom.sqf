// Example usages:

// ["Hello", "Crossroads", "Ldf0"] call Pie_fnc_CustomDialogHColl;
// The message would be from Crossroads, the content would be 'Hello' and the icon would by the LDF Officer

// ["Hello", "Crossroads", "LdfO", nil, nil, nil, "PaperBG"] call Pie_fnc_CustomDialogHColl;
// Same as the above, but on a paper background

Pie_fnc_CustomDialogHColl = {
    params [
        ["_text_to_say", ""],
        ["_name_of_speaker", ""],
        ["_speaker_image", ""], // LdfO, ???
        ["_unit_to_lip_sync", null],
        ["_speaker_text_colour", "#ffffff"],
        ["_text_colour", "#ffffff"],
        ["_background", "RadioBG"] // RadioBG, PaperBG, ScifiBG
    ];

    // Adapted from HCOLL_NpcDialog, uses it's UI
    private _structured_text = format["<t shadow='2' align='%5' size='1.1'><t color='%4'>%2: </t><t color='%3'>%1</t></t>", _text_to_say, _name_of_speaker, _text_colour, _speaker_text_colour, "center"];
    "HCOLL_Dialog_Layer" cutRsc ["HCOLL_Dialog_Popup","PLAIN",1];
    _disp = (uiNamespace getVariable ["HCOLL_Dialog_Popup", displayNull]);
    if(isNull _disp)then{hint "disp is null"};

    (_disp displayCtrl 1199) ctrlSetStructuredText parseText _structured_text;
    (_disp displayCtrl 1297) ctrlSetText format ["\HCOLL_NpcDialog\HcollNpcTalk\%1.paa", _background]; // Background

    if (_speaker_image != "") then
    {
        (_disp displayCtrl 1298) ctrlSetText format ["HCOLL_NpcDialog\HcollNpcTalk\Mugshots\%1.paa", _speaker_image]; // Speaker image left
    }
    else
    {
        (_disp displayCtrl 1298) ctrlSetText ""; // Speaker image left
    };

    (_disp displayCtrl 1299) ctrlSetText ""; // Speaker image right

    if (!isNull _unit_to_lip_sync) then
    {
        // Turn on the random lip sync
        _unit_to_lip_sync setRandomLip true; 
    };

    // Calculation taken from the mod
    _Duration = ((((count _text_to_say) + (count _name_of_speaker)) / 20) + 2 );

    sleep _Duration;


    if (!isNull _unit_to_lip_sync) then
    {
        // Turn off the random lip sync
        _unit_to_lip_sync setRandomLip false;
    };


    // Hide the popup
    "HCOLL_Dialog_Layer" cutFadeOut 1;
};