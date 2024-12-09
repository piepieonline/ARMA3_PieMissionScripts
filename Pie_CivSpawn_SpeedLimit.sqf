[this] spawn {
	_civ = _this select 0;
	_minDistSqr = 10000;
	while { true } do 
	{
		_civVic = vehicle _civ;
		if(_civVic != _civ) then
		{
			{
				_minDistSqr = _minDistSqr min (_civVic distanceSqr _x);
			} forEach allPlayers;
			
			switch (true) do
			{
				case (_minDistSqr < 200): {
					_civVic limitSpeed 10;
				};
				case (_minDistSqr < 1000): {
					_civVic limitSpeed 25;
				};
				default {
					_civVic limitSpeed -1;
				}
			};
		};

		sleep 0.25;
	}; 
};