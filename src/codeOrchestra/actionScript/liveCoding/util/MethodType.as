package codeOrchestra.actionScript.liveCoding.util{
  
  import codeOrchestra.actionScript.enums.util.EnumBase;
  
  public class MethodType extends EnumBase {
    public static const METHOD : MethodType  = new MethodType() ;
    public static const SETTER : MethodType  = new MethodType() ;
    public static const GETTER : MethodType  = new MethodType() ;
    public static const CONSTRUCTOR : MethodType  = new MethodType() ;
    public static function fromInt ( id : int ) : MethodType {
      switch ( id ) {
        case  ( 1 ) : {
          return MethodType.METHOD;
        }
        case  ( 2 ) : {
          return MethodType.SETTER;
        }
        case  ( 3 ) : {
          return MethodType.GETTER;
        }
        case  ( 4 ) : {
          return MethodType.CONSTRUCTOR;
        }
        default : {
          return null;
        }
      }
    }
    public static function get NAMES (  ) : Array {
      return ["METHOD", "SETTER", "GETTER", "CONSTRUCTOR"];
    }
    public static function get VALUES (  ) : Array {
      return [METHOD, SETTER, GETTER, CONSTRUCTOR];
    }
    override public function get name (  ) : String {
      return NAMES[index];
    }
    override public function get index (  ) : int {
      return VALUES.indexOf(this);
    }
  }
}




