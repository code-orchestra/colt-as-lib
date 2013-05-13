package codeOrchestra.actionScript.extensionMethods.methods{
  
  import flash.utils.Dictionary;
  
  public class StringMethods extends Dictionary {
    public static function equalsIgnoreCase ( thisParameter1 : String, str : String ) : Boolean {
      if ( thisParameter1 == null ) {
        return str == null;
      }
      return thisParameter1.toLowerCase() == str.toLowerCase();
    }
    public static function isEmpty ( thisParameter2 : String ) : Boolean {
      return ObjectMethods.isNull(thisParameter2) || thisParameter2.length == 0;
    }
    public static function isNotEmpty ( thisParameter3 : String ) : Boolean {
      return !(StringMethods.isEmpty(thisParameter3));
    }
  }
}




