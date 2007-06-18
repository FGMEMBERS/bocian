# Place winch model in correct location 

var placeWinch = func {

	setprop("/controls/winch/place",1);
	settimer(placeWinchModel,0.1);

} #End Function

var placeWinchModel = func {

	var posX = getprop("sim/hitches/winch/winch/global-pos-x");
	var posY = getprop("sim/hitches/winch/winch/global-pos-y");
	var posZ = getprop("sim/hitches/winch/winch/global-pos-z");

	var g = geo.Coord.new().set_xyz(posX, posY, posZ);
	geo.put_model("Models/Airport/supacat_winch.ac", g.lat(), g.lon());

	setprop("/controls/winch/place",0);

} #End Function

var winchModel = nil;

var placeWinchByMouse = func {

	setprop("/controls/winch/place",1);
	var w = geo.click_position();
	var ac = geo.aircraft_position();

	if (winchModel != nil)
		winchModel.getParent().removeChild(winchModel.getName(), winchModel.getIndex());

	winchModel = geo.put_model("Models/Airport/supacat_winch.ac", w.lat(), w.lon(), (w.alt()+0.81), (ac.course_to(w) + 180.0 ));

	setprop("/sim/hitches/winch/winch/global-pos-x", w.x());
	setprop("/sim/hitches/winch/winch/global-pos-y", w.y());
	setprop("/sim/hitches/winch/winch/global-pos-z", w.z());

	setprop("/sim/hitches/winch/open",0);
	setprop("/controls/winch/place",0);

} #End Function

setlistener("/sim/signals/click",placeWinchByMouse);

controls.applyBrakes = func(v) {

	setprop("sim/model/bocian/winch-hook-pos",v);
	setprop("sim/hitches/winch/open",1);

} # End Function
