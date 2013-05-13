package codeOrchestra.actionScript.enums.util{
  
  
  [AlwaysUsed]
  public class EnumBase {
    public function EnumBase(  ){
      
    }
    public function get name (  ) : String {
      throw new Error("not implemented");
    }
    public function get index (  ) : int {
      throw new Error("not implemented");
    }
    public function toString (  ) : String {
      return name;
    }
  }
}




