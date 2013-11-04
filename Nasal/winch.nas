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



#Init model counter
var winchModel = nil;

var placeWinchByMouse = func {


	setprop("/controls/winch/open",1);
	setprop("/sim/hitches/winch/winch/rel-speed",0);
	var w = geo.click_position();
	var ac = geo.aircraft_position();

	if (winchModel != nil)
		winchModel.getParent().removeChild(winchModel.getName(), winchModel.getIndex());

	winchModel = geo.put_model("Models/Airport/supacat_winch.xml", w.lat(), w.lon(), (w.alt()+0.81), (w.course_to(ac) ));

	setprop("/sim/hitches/winch/winch/global-pos-x", w.x());
	setprop("/sim/hitches/winch/winch/global-pos-y", w.y());
	setprop("/sim/hitches/winch/winch/global-pos-z", w.z());
	
	settimer(placeWinchByMousePart2,0.1);

} #End Function

setlistener("/sim/signals/click",placeWinchByMouse);

var placeWinchByMousePart2 = func {

	setprop("/sim/hitches/winch/winch/max-tow-length-m", getprop("/sim/hitches/winch/tow/dist") + 1);
	setprop("/sim/hitches/winch/tow/length", getprop("/sim/hitches/winch/tow/dist") + 0.1);

	setprop("/sim/hitches/winch/open",0);

} #End Function

controls.applyBrakes = func(v) {

	setprop("sim/model/bocian/winch-hook-pos",v);
	setprop("sim/hitches/winch/open",1);

} # End Function
