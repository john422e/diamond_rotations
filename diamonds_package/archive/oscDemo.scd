(
o = ServerOptions.new;
o.protocol_(\tcp);
t = Server.remote(\remote, NetAddr("128.84.126.109", NetAddr.langPort), o);
t.addr.connect;
t.startAliveThread( 0 );
t.doWhenBooted( { "CONNECTED".postln; t.notify; t.initTree });
)

~ip_string = "128.84.126.109";//"10.49.90.109";
b = NetAddr.new(~ip_string, NetAddr.langPort);//"127.0.0.1", NetAddr.langPort); // create net address
b.sendMsg('/freq', 880);
