# Place winch model in correct location 

placeWinch = func{

	setprop("/controls/winch/place", "true");
	settimer(placeWinchModel,0.1);

} #End Function

placeWinchModel = func {

	posX = getprop("sim/hitches/winch/winch/global-pos-x");
	posY = getprop("sim/hitches/winch/winch/global-pos-y");
	posZ = getprop("sim/hitches/winch/winch/global-pos-z");

	var g = geo.Coord.new().set_xyz(posX, posY, posZ);
	geo.put_model("Models/Airport/supacat_winch.ac", g.lon(), g.lat());

	setprop("/controls/winch/place", "false");

} #End Function
