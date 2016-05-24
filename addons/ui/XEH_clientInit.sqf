#include "script_component.hpp"

// Exit on Headless
if (!hasInterface) exitWith {};

["ace_settingsInitialized", {
    // Initial settings
    [true] call FUNC(setElements);

    // On load and entering/exiting a vehicle
    ["ace_infoDisplayChanged", {
        // Selective UI Advanced
        // Defaults must be set in this EH to make sure controls are activated and advanced settings can be modified
        private _force = [true, false] select (GVAR(allowSelectiveUI));
        {
            [_x select 0, _x select 1, _x select 2, _force] call FUNC(setAdvancedElement);
        } forEach ELEMENTS_ADVANCED;
    }] call CBA_fnc_addEventHandler;

    // On changing settings
    ["ace_settingChanged", {
        params ["_name"];

        // Selective UI Basic
        if (_name in ELEMENTS_BASIC) then {
            [false] call FUNC(setElements);
        };

        // Selective UI Advanced
        {
            _x params ["_idd", "_elements", "_elementName"];

            if (_name == _elementName) then {
                [_idd, _elements, _elementName] call FUNC(setAdvancedElement);
                TRACE_2("Setting Changed",_name,_elementName);
            };
        } forEach ELEMENTS_ADVANCED;
    }] call CBA_fnc_addEventHandler;

}] call CBA_fnc_addEventHandler;
