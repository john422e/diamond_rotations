(
/*
1. Get random starting pitch and set that directory (sub1)
2. Get random sequence and iterate throught it, setting the sub2 directory each time
3. Scramble station order so player movement isn't predictable
4. Pull 6 score images (.png) and freqs.csv file
5. Send two OSC messages: 1. filepath to score image 2. frequency
*/
s.waitForBoot{
// initialize
var startPitch, comboSequences, randSequence;
var parentDirectory, relPath, sub1, sub2, currentDirectory, freqFile;
var freqFileReader, freqs;
var stationOrder = [0, 1, 2, 3, 4, 5], scrambledOrder = Array.newClear(6);
var ports, hostNames, hosts;
var diamondLoop, sequenceLoop;
// set master directory
relPath = "/score_images/";
parentDirectory = thisProcess.nowExecutingPath.dirname; // for freqFile
// assign possible combo_sequences
comboSequences = Array.new(5);
comboSequences.add([0, 1, 2, 3, 4]);
comboSequences.add([1, 2, 4, 5]);
comboSequences.add([2, 4, 5]);
comboSequences.add([3, 4, 5]);
comboSequences.add([4, 5]);
// OSC STUFF -----------------------------------------
ports = [10002, 10002, 10002, 10002, 10002, 10002]; // for six computers, all on same port
//ports = [10002, 10003, 10004, 10005, 10006, 10007]; // for same computer, all on diff ports (for testing)
hostNames = Array.newClear(6);
// hostnames MUST BE UPDATED FOR EACH SET OF COMPUTERS
hostNames[0] = "eagle2018.local"; // computer 1
hostNames[1] = "eagle2018.local"; // computer 2
hostNames[2] = "eagle2018.local"; // computer 3
hostNames[3] = "eagle2018.local"; // computer 4
hostNames[4] = "eagle2018.local"; // computer 5
hostNames[5] = "eagle2018.local"; // computer 6
// now make a NetAddr for each host
hosts = Array.new(6);
// set up each host with hostname and port
for( 0, hostNames.size-1, {
	arg i;
	var host;
	[hostNames[i], ports[i]].postln;
	host = NetAddr.new(hostNames[i], ports[i]);
	hosts.add(host);
});
// DISPLAY STUFF --------------------------------------
// create window to print on
~window = Window.new("diamonds controller", bounds:Rect(10,100,500,500), resizable: true);
~window.front;


// FORM STARTS HERE
~diamondLoop = Routine( { inf.do(
	{
		arg cycle;

		// 1. get random starting pitch and set sub1 direcotry
		startPitch = 6.rand;
		sub1 = 'ref_pitch'++startPitch++'/';
		//relPath+sub1.postln;
		// 2. get random comboSequence
		randSequence = comboSequences.choose;
		["SEQUENCE:", randSequence].postln;
		// next loop will run # of times based on sequence size
		~sequenceLoop = Routine( { randSequence.size.do(
			{
				arg i;
				// 3. scramble station order
				scrambledOrder = stationOrder.scramble;
				//scrambledOrder.postln;
				// 4. pull each file
				sub2 = 'combo'++randSequence[i];
				currentDirectory = relPath ++ sub1 ++ sub2 ++ '/';
				freqFile = parentDirectory ++ currentDirectory ++ 'freqs.csv';
				//freqFile.postln;
				freqFileReader = CSVFileReader.read(freqFile);
				freqs = freqFileReader[0]; // just get the freqs (array not clean)
				freqs.postln;
				for( 0, 5, {
					arg i;
					var filePath, freq, host;
					filePath = currentDirectory ++ (i+1) ++ '.png';
					freq = freqs[i];
					// get sendee from scrambledOrder
					host = hosts[scrambledOrder[i]];
					// 5. send!
					// send filePath
					host.sendMsg('/filePath', filePath);
					// send freq
					host.sendMsg('/freq', freq);
					[filePath, freq].postln;
					//"HEYYYYYYY".postln;
				});
				i.yield;
			}
		)});
		cycle.yield;
	}
)});

// HID STUFF -----------------------------------------
// response to key press
~window.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;
	[char, modifiers, unicode, keycode].postln;
	if( keycode == 49, // space bar
		{
			"SPACE".postln;
			if( ~sequenceLoop.value == nil, { // the boolean expression will trigger the routine
				//~sequenceLoop.reset;
				"RESET, NEXT CYCLE".postln;
				~diamondLoop.next;
			});
	});
};
};
)
