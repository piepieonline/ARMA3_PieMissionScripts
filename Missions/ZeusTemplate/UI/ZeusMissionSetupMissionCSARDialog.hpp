#include "CustomControlClasses.hpp"
class ZeusMissionSetupMissionCSARDialog
{
	idd = -1;
	
	class ControlsBackground
	{
		class Bg
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.23730469;
			y = safeZoneY + safeZoneH * 0.14930556;
			w = safeZoneW * 0.52441407;
			h = safeZoneH * 0.69965278;
			style = 0;
			text = "";
			colorBackground[] = {0.1961,0.1961,0.1961,0.5059};
			colorText[] = {0.5373,0.1804,0.9373,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		
	};
	class Controls
	{
		class ButtonMissionToggleKnownLocation
		{
			type = 1;
			idc = 10;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.17361112;
			w = safeZoneW * 0.47558594;
			h = safeZoneH * 0.04340278;
			style = 0+2;
			text = "Toggle Known Location";
			borderSize = 0;
			colorBackground[] = {0.4,0.4,0.4,1};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "";
			
		};
		class LabelMissionKnownLocation
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.22222223;
			w = safeZoneW * 0.23144532;
			h = safeZoneH * 0.06770834;
			style = 1;
			text = "Known Crash Location: ";
			colorBackground[] = {0.8667,0.8157,0.2039,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class LabelMissionKnownLocationState
		{
			type = 0;
			idc = 11;
			x = safeZoneX + safeZoneW * 0.50683594;
			y = safeZoneY + safeZoneH * 0.22222223;
			w = safeZoneW * 0.23144532;
			h = safeZoneH * 0.06770834;
			style = 0;
			text = "Destroy in Place";
			colorBackground[] = {0.8667,0.8157,0.2039,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class ButtonMissionSave
		{
			type = 1;
			idc = 100;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.70833334;
			w = safeZoneW * 0.47558594;
			h = safeZoneH * 0.04340278;
			style = 0+2;
			text = "Set";
			borderSize = 0;
			colorBackground[] = {0.4,0.4,0.4,1};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "";
			
		};
		class ButtonMissionCancel
		{
			type = 1;
			idc = 101;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.78125;
			w = safeZoneW * 0.47558594;
			h = safeZoneH * 0.04340278;
			style = 0+2;
			text = "Discard";
			borderSize = 0;
			colorBackground[] = {0.4,0.4,0.4,1};
			colorBackgroundActive[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			offsetPressedX = 0.01;
			offsetPressedY = 0.01;
			offsetX = 0.01;
			offsetY = 0.01;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
			soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
			soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
			soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
			onButtonClick = "";
			
		};
		
	};
	
};
