package codeOrchestra.actionScript.extensionMethods.methods{
  
  import flash.utils.Dictionary;
  
  public class ObjectMethods extends Dictionary {
    public static function isNull ( thisParameter1 : Object ) : Boolean {
      return thisParameter1 == null;
    }
    public static function isNotNull ( thisParameter2 : Object ) : Boolean {
      return !(ObjectMethods.isNull(thisParameter2));
    }
  }
}




