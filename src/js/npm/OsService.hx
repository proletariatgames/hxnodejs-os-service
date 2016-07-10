package js.npm;
import js.node.stream.Writable;

@:jsRequire('os-service')
extern class OsService {
  /**
    The add() function adds a service.

    The service will be set to automatically start at boot time, but not started. The service can be started using the
    net start "my-service" command on Windows and service my-service start on Linux.
   **/
  @:overload(function(name:String, callback:js.Error->Void):Void {})
  @:overload(function(name:String):Void {})
  static function add(name:String, opt:OsServiceOptions, callback:js.Error->Void):Void;

  /**
    The remove() function removes a service.

    The name parameter specifies the name of the service to remove. This will be the same name parameter specified when
    adding the service.

    The service must be in a stopped state for it to be removed. The net stop "my-service" command can be used to stop
    the service on Windows and the service my-service stop on Linux before it is to be removed.
   **/
  @:overload(function(name:String):Void {})
  static function remove(name:String, callback:js.Error->Void):Void;

  /**
    The run() function will attempt to run the program as a service.

    The programs process.stdout stream will be replaced with the stdoutLogStream parameter, and the programs
    process.stderr stream replaced with the stdoutLogStream parameter (this allows the redirection of all console.log()
    type calls to a service specific log file). If the stderrLogStream parameter is not specified the programs
    process.stderr stream will be replaced with the stdoutLogStream parameter. The callback function will be called when
    the service receives a stop request, e.g. because the Windows Service Controller was used to send a stop request to
    the service, or a SIGTERM signal was received.

    The program should perform cleanup tasks and then call the service.stop() function.
   **/
  @:overload(function(stdoutLogStream:IWritable):Void {})
  @:overload(function(stdoutLogStream:IWritable, callback:Void->Void):Void {})
  static function run(stdoutLogStream:IWritable, stderrLogStream:IWritable, callback:Void->Void):Void;

  /**
    The stop() function will cause the service to stop, and the calling program to exit.

    Once the service has been stopped this function will terminate the program by calling the process.exit() function,
    passing to it the rcode parameter which defaults to 0. Before calling this function ensure the program has finished
    performing cleanup tasks.

    BE AWARE, THIS FUNCTION WILL NOT RETURN.
   **/
  @:overload(function():Void {})
  static function stop(rcode:Int):Void;
}

typedef OsServiceOptions = {
  /**
    The services display name, defaults to the name parameter
    this parameter will be used on Windows platforms only
   **/
  ?displayName:String,
  /**
    The fully qualified path to the node binary used to run the service (i.e. c:\Program Files\nodejs\node.exe, defaults
    to the value of process.execPath
   **/
  ?nodePath:String,
  /**
    An array of strings specifying parameters to pass to nodePath, defaults to []
   **/
  ?nodeArgs:Array<String>,
  /**
    The program to run using nodePath, defaults to the value of process.argv[1]
   **/
  ?programPath:String,
  /**
    An array of strings specifying parameters to pass to programPath, defaults to []
   **/
  ?programArgs:Array<String>,
  /**
    An array of numbers specifying Linux run-levels at which the service should be started for Linux platforms, defaults
    to [2, 3, 4, 5]
   **/
  ?runLevels:Array<Int>,
  /**
    For Windows platforms a username and password can be specified, the service will be run using these credentials when
    started, see the CreatedService() functions win32 API documentation for details on the format of the username, on
    all other platforms this parameter is ignored
   **/
  ?username:String,
  /**
    See the username parameter
   **/
  ?password:String,
}
