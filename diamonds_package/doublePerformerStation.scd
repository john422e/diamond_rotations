// boot server (EACH PLAYER MUST CHECK THAT SERVER IS RUNNING
(
s.waitForBoot {
// initialize
var imageBounds = Rect(0, 0, 800, 950);
var tempImage="score_images/ref_pitch0/combo0/1.png";

// startup sound
{Line.kr(1, 0, 5, doneAction: 2) * SinOsc.ar(1000) * EnvGen.ar(Env.perc(0.01, 0.25), Impulse.kr(2, [0, 0.5]), 0.1)}.play;

~parentDirectory = thisProcess.nowExecutingPath.dirname;
~windowL = Window.new("DIAMONDS LEFT", bounds:Rect(100, 1000, 800, 950), resizable: true);
~windowR = Window.new("DIAMONDS RIGHT", bounds:Rect(100, 1000, 800, 950), resizable: true);

~windowL.front;
~windowR.front;
~scoreViewL = View.new(~windowL, imageBounds);
~scoreViewR = View.new(~windowR, imageBounds);


// temp image until receiving OSC trigger
~imagePathL = ~parentDirectory +/+ tempImage;
~imagePathR = ~parentDirectory +/+ tempImage;

// synth def
SynthDef( \tone, { arg freq=220, gate=0, amp=1.0, out=0;
	var sig, env; // amount of attenuation to apply to amp (0 - 1)
	env = EnvGen.kr(Env.adsr(0.05, 0.1, 0.5, 3), gate);
	sig = SinOsc.ar(freq);
	//sig = Pan2.ar(sig);
	sig = BHiShelf.ar(sig, 150, 1.0, -6);
	sig = BHiShelf.ar(sig, 300, 1.0, -6);
	sig = BHiShelf.ar(sig, 450, 1.0, -6);
	sig = sig * env * amp;
	Out.ar(out, sig);
}).add;

s.boot;
5.wait;

// OSCdefs

// for synth
OSCdef.new(
	\sinSynthL,
	// function to be evaluated upon receiving qualifying OSC message
	{
		arg msg, time, addr, port; // these are the messages passed on
		var freq;
		//[msg, time, addr, port].postln; // action to be executed
		freq = msg[1].asFloat;
		["LEFT FREQ SET", freq].postln;
		~mySynthL.set(\freq, freq);

	},
	'/freq',
	recvPort: 10002,
);

OSCdef.new(
	\sinSynthR,
	// function to be evaluated upon receiving qualifying OSC message
	{
		arg msg, time, addr, port; // these are the messages passed on
		var freq;
		//[msg, time, addr, port].postln; // action to be executed
		freq = msg[1].asFloat;
		["RIGHT FREQ SET", freq].postln;
		~mySynthR.set(\freq, freq);

	},
	'/freq',
	recvPort: 10003,
);

// for score
OSCdef.new(
	\scoreViewerL,
	{
		arg msg, time, addr, port;
		var fill;
		//"SETTING SCORE IMAGE".postln;
		// set score image filepath
		~imagePathL = ~parentDirectory +/+ msg[1];
		//["FILEPATH:", ~imagePath].postln;
		// trigger routine
		{~scoreLoop.next}.defer;
		//~window.refresh;
		//~scoreImage.free;
		//~window.refresh;
	},
	'/filePath',
	recvPort: 10002,
);
OSCdef.new(
	\scoreViewerR,
	{
		arg msg, time, addr, port;
		var fill;
		//"SETTING SCORE IMAGE".postln;
		// set score image filepath
		~imagePathR = ~parentDirectory +/+ msg[1];
		//["FILEPATH:", ~imagePath].postln;
		// trigger routine
		{~scoreLoop.next}.defer;
		//~window.refresh;
		//~scoreImage.free;
		//~window.refresh;
	},
	'/filePath',
	recvPort: 10003,
);
//OSCdef.freeAll;

// start synth
~mySynthL = Synth.new(\tone, [\out, 0, \gate, 1]);
~mySynthR = Synth.new(\tone, [\out, 1, \gate, 1]);

// window refresh routine
~scoreLoop = Routine ( {inf.do({
	arg i;
	"WINDOWING".postln;
	["LEFT", ~imagePathL].postln;
	["RIGHT", ~imagePathR].postln;
	~scoreImageL = Image.new(~imagePathL);
	~scoreImageR = Image.new(~imagePathR);
	~scoreImageL.scalesWhenResized_(true);
	~scoreImageR.scalesWhenResized_(true);
	~scoreViewL.backgroundImage_(~scoreImageL).alwaysOnTop_(true);
	~scoreViewR.backgroundImage_(~scoreImageR).alwaysOnTop_(true);

	i.yield;
	~scoreImageL.free;
	~scoreImageR.free;
	~windowL.refresh;
	~windowR.refresh;
})});
};
)