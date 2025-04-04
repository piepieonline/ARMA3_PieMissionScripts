#include "CustomControlClasses.hpp"
class ZeusMissionSetupOccupyDialog
{
	idd = -1;
	
	class ControlsBackground
	{
		class Bg
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.2375;
			y = safeZoneY + safeZoneH * 0.14907408;
			w = safeZoneW * 0.52447917;
			h = safeZoneH * 0.7;
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
		class LabelOccupyPatrols
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26953125;
			y = safeZoneY + safeZoneH * 0.17708334;
			w = safeZoneW * 0.11914063;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "Patrols:";
			colorBackground[] = {0.2157,0.9137,0.8549,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TextOccupyPatrols
		{
			type = 2;
			idc = 10;
			x = safeZoneX + safeZoneW * 0.41601563;
			y = safeZoneY + safeZoneH * 0.17708334;
			w = safeZoneW * 0.31445313;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "";
			autocomplete = "";
			colorBackground[] = {1,1,1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class LabelOccupyGarrisons
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26953125;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.14355469;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "Buildings Garrisoned:";
			colorBackground[] = {0.2157,0.9137,0.8549,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TextOccupyGarrisons
		{
			type = 2;
			idc = 30;
			x = safeZoneX + safeZoneW * 0.41601563;
			y = safeZoneY + safeZoneH * 0.25;
			w = safeZoneW * 0.31445313;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "";
			autocomplete = "";
			colorBackground[] = {1,1,1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class LabelOccupyVehicleCount
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26953125;
			y = safeZoneY + safeZoneH * 0.32291667;
			w = safeZoneW * 0.14355469;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "Parked Vehicles:";
			colorBackground[] = {0.2157,0.9137,0.8549,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TextOccupyVehicleCount
		{
			type = 2;
			idc = 40;
			x = safeZoneX + safeZoneW * 0.41601563;
			y = safeZoneY + safeZoneH * 0.32291667;
			w = safeZoneW * 0.31445313;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "";
			autocomplete = "";
			colorBackground[] = {1,1,1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class LabelOccupyVehiclePatrolCount
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26953125;
			y = safeZoneY + safeZoneH * 0.39583334;
			w = safeZoneW * 0.14355469;
			h = safeZoneH * 0.03819445;
			style = 0;
			text = "Patrolling vehicles based per town:";
			colorBackground[] = {0.2157,0.9137,0.8549,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TextOccupyVehiclePatrolCount
		{
			type = 2;
			idc = 50;
			x = safeZoneX + safeZoneW * 0.41614584;
			y = safeZoneY + safeZoneH * 0.3962963;
			w = safeZoneW * 0.31458334;
			h = safeZoneH * 0.03796297;
			style = 0;
			text = "";
			autocomplete = "";
			colorBackground[] = {1,1,1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class LabelOccupyHelicoptersCount
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26979167;
			y = safeZoneY + safeZoneH * 0.4712963;
			w = safeZoneW * 0.14375;
			h = safeZoneH * 0.03796297;
			style = 0;
			text = "Helicopters per town:";
			colorBackground[] = {0.2157,0.9137,0.8549,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TextOccupyHelicopterCount
		{
			type = 2;
			idc = 60;
			x = safeZoneX + safeZoneW * 0.41614584;
			y = safeZoneY + safeZoneH * 0.4712963;
			w = safeZoneW * 0.31458334;
			h = safeZoneH * 0.03796297;
			style = 0;
			text = "";
			autocomplete = "";
			colorBackground[] = {1,1,1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class LabelOccupyEmplacementCount
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.26979167;
			y = safeZoneY + safeZoneH * 0.5462963;
			w = safeZoneW * 0.14375;
			h = safeZoneH * 0.03796297;
			style = 0;
			text = "Emplacements per town:";
			colorBackground[] = {0.2157,0.9137,0.8549,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class TextOccupyEmplacementCount
		{
			type = 2;
			idc = 70;
			x = safeZoneX + safeZoneW * 0.41614584;
			y = safeZoneY + safeZoneH * 0.5462963;
			w = safeZoneW * 0.31458334;
			h = safeZoneH * 0.03796297;
			style = 0;
			text = "";
			autocomplete = "";
			colorBackground[] = {1,1,1,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {0,0,0,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class ButtonMissionAmbientCombat
		{
			type = 1;
			idc = 80;
			x = safeZoneX + safeZoneW * 0.26197917;
			y = safeZoneY + safeZoneH * 0.58796297;
			w = safeZoneW * 0.47552084;
			h = safeZoneH * 0.04351852;
			style = 0+2;
			text = "Set Ambient Combat Regions";
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
		class LabelAmbientCombat
		{
			type = 0;
			idc = -1;
			x = safeZoneX + safeZoneW * 0.34270834;
			y = safeZoneY + safeZoneH * 0.63981482;
			w = safeZoneW * 0.14375;
			h = safeZoneH * 0.03796297;
			style = 1;
			text = "Ambient Combat:";
			colorBackground[] = {0.2157,0.9137,0.8549,0};
			colorText[] = {1,1,1,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
		class LabelAmbientCombatState
		{
			type = 0;
			idc = 81;
			x = safeZoneX + safeZoneW * 0.51354167;
			y = safeZoneY + safeZoneH * 0.63981482;
			w = safeZoneW * 0.14375;
			h = safeZoneH * 0.03796297;
			style = 0;
			text = "None";
			colorBackground[] = {0.2157,0.9137,0.8549,0};
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
			x = safeZoneX + safeZoneW * 0.26197917;
			y = safeZoneY + safeZoneH * 0.78148149;
			w = safeZoneW * 0.47552084;
			h = safeZoneH * 0.04351852;
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
