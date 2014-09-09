# PZL Total Energy compensated variometers

io.include("Aircraft/Generic/soaring-instrumentation-sdk.nas");

var vario_ui = gui.Dialog.new(
	"/sim/gui/dialogs/bocian/variometer/dialog",
	"Aircraft/bocian/Dialogs/variometer.xml");

var probe = TotalEnergyProbe.new();

var needle1 = Dampener.new(
	input: probe,
	dampening: 2.5,
	on_update: update_prop("/instrumentation/variometer/te-reading1-mps"));

var needle2 = Dampener.new(
	input: probe,
	dampening: 2.8,
	on_update: update_prop("/instrumentation/variometer/te-reading2-mps"));

var instrument = Instrument.new(
	components: [probe, needle1, needle2],
	enable: 1);
