package codeOrchestra.actionScript.collections.util{
  
  
  [AlwaysUsed]
  public class CastUtil {
    public function CastUtil(  ){
      
    }
    public static function checkType ( value : Object, type : Class ) : Object {
      if ( type != null ) {
        if ( !(value is type) ) {
          throw new Error("" + value + " - wrong type. Expected " + type);
        }
      }
      return value;
    }
    public static function isType ( value : Object, type : Class ) : Boolean {
      return value is type;
    }
    public static function isArray ( value : Object ) : Boolean {
      return value is Array;
    }
    public static function toArray ( value : Object ) : Array {
      checkType(value, Array);
      return value as Array;
    }
  }
}




