package codeOrchestra.actionScript.liveCoding.util{
  
  import flash.events.Event;
  
  [AlwaysUsed]
  public class AssetUpdateEvent extends Event {
    public static var ASSET_UPDATE : String  = "assetUpdate" ;
    private var _source : String ;
    public var assetClass : Class ;
    public function AssetUpdateEvent( source : String  = null, assetClass : Class  = null ){
      super(ASSET_UPDATE);
      this._source = source;
      this.assetClass = assetClass;
    }
    override public function clone (  ) : Event {
      return new AssetUpdateEvent(_source, assetClass);
    }
    public function get source (  ) : String {
      return _source;
    }
    override public function toString (  ) : String {
      return "AssetUpdateEvent { " + "source=" + this._source + ", " + "assetClass=" + this.assetClass + " }";
    }
  }
}




