package codeOrchestra.actionScript.liveCoding.util{
  
  import flash.events.Event;
  
  [AlwaysUsed]
  public class MethodUpdateEvent extends Event {
    public static var METHOD_UPDATE : String  = "methodUpdate" ;
    private var _classFqn : String ;
    private var _methodName : String ;
    public function MethodUpdateEvent( classFqn : String, methodName : String  = null ){
      super(METHOD_UPDATE);
      this._classFqn = classFqn;
      this._methodName = methodName;
    }
    public function get classFqn (  ) : String {
      return this._classFqn;
    }
    public function get methodName (  ) : String {
      return this._methodName;
    }
    override public function clone (  ) : Event {
      return new MethodUpdateEvent(classFqn, methodName);
    }
  }
}




