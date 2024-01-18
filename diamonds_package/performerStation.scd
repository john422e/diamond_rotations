// boot server (EACH PLAYER MUST CHECK THAT SERVER IS RUNNING
(
s.waitForBoot {
	// initialize
	var imageBounds = Rect(0, 0, 800, 950);
	var tempImage="score_images/ref_pitch0/combo0/1.png";

	// startup sound
	{Line.kr(1, 0, 5, doneAction: 2) * SinOsc.ar(1000) * EnvGen.ar(Env.perc(0.01, 0.25), Impulse.kr(2, [0, 0.5]), 0.1)}.play;

	~parentDirectory = thisProcess.nowExecutingPath.dirname;
	Window.closeAll;
	~window = Window.new("DIAMONDS", bounds:Rect(100, 1000, 800, 950), resizable: true);
	~window.front;

	~window.onClose_(
		{
			~mySynth.set(\gate, 0);
			Task.new( { 3.wait; "OFF".postln; s.quit; } ).start;
			//s.quit;
		};
	);
	~scoreView = View.new(~window, imageBounds);

	// temp image until receiving OSC trigger
	~imagePath = ~parentDirectory +/+ tempImage;

	// synth def
	SynthDef( \tone, { arg freq=220, gate=0, amp=1.0, out=0;
		var sig, env; // amount of attenuation to apply to amp (0 - 1)
		env = EnvGen.kr(Env.adsr(0.05, 0.1, 0.5, 3), gate);
		sig = SinOsc.ar(freq);
		sig = Pan2.ar(sig!2);
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
		\sinSynth,
		// function to be evaluated upon receiving qualifying OSC message
		{
			arg msg, time, addr, port; // these are the messages passed on
			var freq;
			//[msg, time, addr, port].postln; // action to be executed
			freq = msg[1].asFloat;
			["LOCAL FREQ SET", freq].postln;
			~mySynth.set(\freq, freq);
		},
		'/freq',
		recvPort: 10002,
	);

	OSCdef.new(
		\muteSynth,
		{
			arg msg, time, addr, port;
			var synthState;
			synthState = msg[1].asInteger;
			["MUTING 0/1", synthState].postln;
			~mySynth.set(\gate, synthState);
		},
		'/synthState',
		recvPort: 10002,
	);

	// for score
	OSCdef.new(
		\scoreViewer,
		{
			arg msg, time, addr, port;
			var fill;
			//"SETTING SCORE IMAGE".postln;
			// set score image filepath
			~imagePath = ~parentDirectory +/+ msg[1];
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

	//OSCdef.freeAll;

	// start synth
	~mySynth = Synth.new(\tone, [\gate, 1]);

	// window refresh routine
	~scoreLoop = Routine ( {inf.do({
		arg i;
		"WINDOWING".postln;
		~imagePath.postln;
		~scoreImage = Image.new(~imagePath);
		~scoreImage.scalesWhenResized_(true);
		~scoreView.backgroundImage_(~scoreImage).alwaysOnTop_(true);

		i.yield;
		~scoreImage.free;
		~window.refresh;
	})});
};
)