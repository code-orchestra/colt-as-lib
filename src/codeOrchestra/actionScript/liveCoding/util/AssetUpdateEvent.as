package codeOrchestra.actionScript.liveCoding.util{
  
  import flash.events.Event;
  
  [AlwaysUsed]
  public class AssetUpdateEvent extends Event {
    public static var ASSET_UPDATE : String  = "assetUpdate" ;
    private var _source : String ;
    private var _mimeType : String ;
    private var _assetClass : Class ;
    public function AssetUpdateEvent( source : String  = null, mimeType : String  = null, assetClass : Class  = null ){
      super(ASSET_UPDATE);
      _source = source;
      _mimeType = mimeType;
      _assetClass = assetClass;
    }
    override public function clone (  ) : Event {
      return new AssetUpdateEvent(_source, _mimeType, _assetClass);
    }
    public function get source (  ) : String {
      return _source;
    }
    override public function toString (  ) : String {
      return "AssetUpdateEvent { " + "source=" + this._source + ", " + "mimeType=" + this._mimeType + ", " + "assetClass=" + this._assetClass + " }";
    }
    public function get mimeType (  ) : String {
      return _mimeType;
    }
    public function get assetClass (  ) : Class {
      return _assetClass;
    }
    public function set assetClass ( value : Class ) : void {
      _assetClass = value;
    }
  }
}




