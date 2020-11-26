(
s.boot;
(
OSCdef.new(
	\freq1,
	// function to be evaluated upon receiving qualifying OSC message
	{
		arg msg, time, addr, port; // these are the messages passed on
		//[msg, time, addr, port].postln; // action to be executed
		"ONE".postln;
		a.set(\freq, msg[1] + 440);
	},
	'/freq',
	recvPort: 10002,
);
);

(
OSCdef.new(
	\freq2,
	// function to be evaluated upon receiving qualifying OSC message
	{
		arg msg, time, addr, port; // these are the messages passed on
		//[msg, time, addr, port].postln; // action to be executed
		"TWO".postln;
		b.set(\freq, msg[1] + 440);
	},
	'/freq',
	recvPort: 10003,
);
);
