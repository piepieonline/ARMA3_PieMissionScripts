#include "CustomControlClasses.hpp"
class ZeusMissionSetupDialog
{
	idd = 1994;
	
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
		class MissionTypeDropdown
		{
			type = 4;
			idc = 10;
			x = safeZoneX + safeZoneW * 0.3671875;
			y = safeZoneY + safeZoneH * 0.17708334;
			w = safeZoneW * 0.38769532;
			h = safeZoneH * 0.03125;
			style = 16;
			arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_ca.paa";
			arrowFull = "\A3\ui_f\data\GUI\RscCommon\RscCombo\arrow_combo_active_ca.paa";
			colorBackground[] = {0.4,0.4,0.4,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {1,0,0,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			maxHistoryDelay = 0;
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1.0};
			soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1.0};
			soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1.0};
			wholeHeight = 0.3;
			class ComboScrollBar
			{
				color[] = {1,1,1,1};
				thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
				arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
				arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
				border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
				
			};
			
		};
		class MissionTypeLabel
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.14930556;
			w = safeZoneW * 0.08496094;
			h = safeZoneH * 0.06770834;
			style = 0;
			text = "Mission Type:";
			colorBackground[] = {0.8667,0.8157,0.2039,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class MissionLocationButton
		{
			type = 1;
			idc = 20;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.27083334;
			w = safeZoneW * 0.47558594;
			h = safeZoneH * 0.04340278;
			style = 0+2;
			text = "Select Location on Map";
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
		class MissionLocationLabel
		{
			type = 0;
			idc = 21;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.31944445;
			w = safeZoneW * 0.47558594;
			h = safeZoneH * 0.06770834;
			style = 0+2;
			text = "Selected Locations: None";
			colorBackground[] = {0.8667,0.8157,0.2039,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class ButtonMissionAssignEnemy
		{
			type = 1;
			idc = 30;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.39236112;
			w = safeZoneW * 0.47558594;
			h = safeZoneH * 0.04340278;
			style = 0+2;
			text = "Assign spawned units as Opfor";
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
		class LabelMissionEnemyDetails
		{
			type = 0;
			idc = 31;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.44097223;
			w = safeZoneW * 0.47558594;
			h = safeZoneH * 0.06770834;
			style = 0+2;
			text = "Selected Enemies: None";
			colorBackground[] = {0.8667,0.8157,0.2039,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class ButtonMissionStart
		{
			type = 1;
			idc = 40;
			x = safeZoneX + safeZoneW * 0.26171875;
			y = safeZoneY + safeZoneH * 0.78125;
			w = safeZoneW * 0.47558594;
			h = safeZoneH * 0.04340278;
			style = 0+2;
			text = "Start";
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
