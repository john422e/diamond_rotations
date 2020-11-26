/*
1. Get random starting pitch and set that directory (sub1)
2. Get random sequence and iterate throught it, setting the sub2 directory each time
3. Scramble station order so player movement isn't predictable
4. Pull 6 score images (.png) and freqs.csv file
5. Send two OSC messages: 1. filepath to score image 2. frequency
*/

(
// initialize
var startPitch, comboSequences, randSequence;
var parentDirectory, relPath, sub1, sub2, currentDirectory, freqFile;
var freqFileReader, freqs;
var stationOrder = [0, 1, 2, 3, 4, 5], scrambledOrder = Array.newClear(6);
var ports, hostNames, hosts;
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
ports = [10002, 10003, 10004, 10005, 10006, 10007]; // REMOVE LATER diff ports are for testing only
hostNames = Array.newClear(6);
// hostnames
hostNames[0] = "eagle2018.local";
hostNames[1] = "eagle2018.local";
hostNames[2] = "eagle2018.local";
hostNames[3] = "eagle2018.local";
hostNames[4] = "eagle2018.local";
hostNames[5] = "eagle2018.local";
// now make a NetAddr for each host
hosts = Array.new(6);
// set up each host with hostname and port
for( 0, hostNames.size-1, {
	arg i;
	var host;
	[hostNames[i], ports[i]].postln;
	host = NetAddr.new(hostNames[i], ports[i]); // CHANGE LATER diff ports are for testing only
	hosts.add(host);
});

// FORM STARTS HERE
// 1. get random starting pitch and set sub1 direcotry
startPitch = 6.rand;
sub1 = 'ref_pitch'++startPitch++'/';
relPath+sub1.postln;
// 2. get random comboSequence
randSequence = comboSequences.choose;

randSequence.postln;
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
		freqFile.postln;
		freqFileReader = CSVFileReader.read(freqFile).postcs;
		freqs = freqFileReader[0]; // just get the freqs (array not clean)
		for( 0, 5, {
			arg i;
			var filePath, freq;
			filePath = currentDirectory ++ (i+1) ++ '.png';
			freq = freqs[i];
			// get sendee from scrambledOrder
			scrambledOrder[i].postln;
			// send filePath
			// send freq
			[filePath, freq].postln;
		});
		i.yield;
	}
)};
);
)

~sequenceLoop.next;

(




// MATH STUFF ----------------------------------------
// a placeholder function which will generate harmonic chains and send to each host
~fundamental = 110;
~primes = [2, 3/2, 5/4, 7/4];
~hz_min = 100;
~hz_max = 1000;

// this is too complicated. you need to generate a collection of possibilities using python/abjad/lilypond and build image library as you did for vln piece

~decimalToFraction = {
	arg decimal, denomMax;
	var numer=decimal, denom=1, simplified=false, gcd, x, y;// put decimal over 1

	// convert to fraction (get rid of decimal)
	while( { numer.asInteger != numer}, {
		// loop until numerator is an integer
		numer = numer * 10;
		denom = denom * 10;
	});

	// reduce to simplest form
	// return if fraction = 1/1
	if( numer == denom, { simplified=true }; );
	if( simplified != true, {
		x = [numer, denom].maxItem;
		y = [numer, denom].minItem;
		while( {gcd == nil}, {
			x = x % y;
			if( x == 0, {gcd = x} );
		});
	});
}


	[1, 2].maxItem.postln;
~decimalToFraction.value( 1.25, 10);
~getUniqueSet = {
	arg anArray, setLength;
	var arrayCopy, choice, set;

	if( setLength >= anArray.size, {
		"ERROR. setLength cannot be longer than array size".postln;
	});

	// copy array
	arrayCopy = Array.newFrom(anArray);
	// build set
	set = Array.new(setLength);
	for( 1, setLength, {
		choice = arrayCopy.pop(arrayCopy.choose);
		set.add(choice);
	});
	set; // return
}

~buildDiamond = {
	// builds a 6 point diamond
	// since prime set order is not ordered, diamond is always the same orientation
	//    5
	// 6     4
	// 1     3
	//    2

	arg ref, primeSet;
	var freq1, freq2, freq3, freq4, freq5, freq6, diamond;

	freq1 = ref; // freq1
	freq2 =  (freq1 * primeSet[0]) / primeSet[1];
	freq3 = freq2 * primeSet[0] * primeSet[1];
	freq6 = freq1 * primeSet[1];
	freq5 = freq6 * primeSet[0] * primeSet[1];
	freq4 = freq3 * primeSet[1];
	diamond = [freq1, freq2, freq3, freq4, freq5, freq6];
	diamond; // return
}

// random start value
~ref = (5.rand + 55).midicps; // midi to Hz

p = ~getUniqueSet.value(~primes, 2);
d = ~buildDiamond.value(~ref, p);


~myFunc = {
	var freqs;
	freqs = Array.rand(6, 100, 400);
	freqs.postln;

	//r = Routine( { ~hosts.size.do(
		//{
			//arg i;
			//[i, freqs[i]].postln;
			//~hosts[i].sendMsg( '/freq', freqs[i] );
			//0.1.wait;
	//});
	//}).play;
//};

	for( 0, ~hosts.size-1, {
		arg i;
		[i, freqs[i]].postln;
		~hosts[i].sendMsg( '/freq', freqs[i] );
		//1.wait;
	});
};

// DISPLAY STUFF --------------------------------------
// create window to print on
~window = Window.new("diamonds server", bounds:Rect(10,100,150,150), resizable: true);
~window.front;

~diamondLoop = Routine( { inf.do(
	{ arg i;
		//a = ~randomSeed.value;
		//~client.sendMsg( '/freq', a);
		//i.postln;

		~myFunc.value;

		i.yield;

	}
)};
);


// HID STUFF -----------------------------------------
// response to key press
~window.view.keyDownAction = { arg view, char, modifiers, unicode, keycode;
	// [char, modifiers, unicode, keycode].postln;
	if( keycode == 49, // space bar
		{
			"HEY".postln;
			~diamondLoop.value;
		}
	)
}
)
