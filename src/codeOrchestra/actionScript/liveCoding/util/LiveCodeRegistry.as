package codeOrchestra.actionScript.liveCoding.util{
  
  import codeOrchestra.actionScript.collections.util.CollectionsLanguageUtil;
  import codeOrchestra.actionScript.logging.logUtil.LogUtil;
  import flash.utils.getDefinitionByName;
  import flash.events.DataEvent;
  import flash.utils.Dictionary;
  import flash.events.EventDispatcher;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.events.Event;
  import flash.display.Loader;
  import flash.system.LoaderContext;
  import flash.system.ApplicationDomain;
  import flash.events.IOErrorEvent;
  import flash.net.URLRequest;
  
  [AlwaysUsed]
  [Event(name="methodUpdate", type="codeOrchestra.actionScript.liveCoding.util.MethodUpdateEvent")]
  [Event(name="assetUpdate", type="codeOrchestra.actionScript.liveCoding.util.AssetUpdateEvent")]
  public class LiveCodeRegistry extends EventDispatcher {
    private static var instance : LiveCodeRegistry ;
    private var methods : Dictionary  = CollectionsLanguageUtil.createMap() ;
    public var sessionId : String ;
    private var lastPackage : int ;
    private var baseUrl : String ;
    public function LiveCodeRegistry( singlitonizer : Singlitonizer ){
      
    }
    public static function getInstance (  ) : LiveCodeRegistry {
      if ( !(instance) ) {
        instance = new LiveCodeRegistry(new Singlitonizer());
      }
      return instance;
    }
    public static function delegete ( obj : Object, func : Function ) : Function {
      var f : *  =       function (  ) : * {
        var target : *  = arguments.callee.target;
        var func : *  = arguments.callee.func;
        return func.apply(target, arguments);
      };
      f.target = obj;
      f.func = func;
      
      return f;
    }
    public function putMethod ( id : String, method : Class, methodInfo : MethodChange  = null ) : void {
      /*
          LogUtil.log("trace", "3443854535863065531", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["putMethod", "arguments=[" + ["id=", id, ", method=", method, ", methodInfo=", methodInfo].join("") + "]"].join(", "));
       */
      if ( methodInfo ) {
        if ( !(CollectionsLanguageUtil.containsKey(methods, id)) ) {
          addMethod(methodInfo.className, methodInfo.methodName, methodInfo.isStatic, methodInfo.type, methodInfo.changeClassName, id);
        }else{
          {
            LogUtil.enterLogScope("livecoding", "6940745366554867689");
            LogUtil.log("trace", "8951269775177402558", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["-> update method: \"" + methodInfo.className + "." + methodInfo.methodName + "\", delivery time: " + (new Date().getTime() - Number(methodInfo.timestamp)) + " ms"].join(", "));
            LogUtil.exitLogScope("livecoding", "6940745366554867689");
          }
        }
      }
      methods[id] = method;
    }
    public function getMethod ( id : String ) : Class {
      /*
          LogUtil.log("trace", "8951269775177402588", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["-> get method: " + id + " -> " + methods[id]].join(", "));
       */
      return methods[id];
    }
    public function addMethod ( className : String, methodName : String, isStaticMethod : Boolean, methodType : MethodType, methodClassName : String, methodId : String ) : void {
      {
        LogUtil.enterLogScope("livecoding", "5629317685584077");
        LogUtil.log("trace", "2233284459626233172", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["add method: " + "arguments=[" + ["className=", className, ", methodName=", methodName, ", isStaticMethod=", isStaticMethod, ", methodType=", methodType, ", methodClassName=", methodClassName, ", methodId=", methodId].join("") + "]"].join(", "));
        LogUtil.exitLogScope("livecoding", "5629317685584077");
      }
      try {
        putMethod(methodId, getDefinitionByName(methodClassName) as Class);
      } catch ( e : Error ) {
        LogUtil.log("error", "3005252694877199952", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["cant't find method-update class: " + methodClassName].join(", "), e);
      }
      
      if ( !(isStaticMethod) ) {
        getDefinitionByName(className).prototype[methodName] =         function ( ...rest ) : * {
          {
            LogUtil.enterLogScope("livecoding", "9091078376703266061");
            var method : Class  = getMethod(methodId);
            var instance : *  = new method(this);
            return instance.run.apply(instance, rest);
            LogUtil.exitLogScope("livecoding", "9091078376703266061");
          }
        };
      }else{
        getDefinitionByName(className)[methodName] =         function ( ...rest ) : * {
          {
            LogUtil.enterLogScope("livecoding", "7473368133778549627");
            var method : Class  = getMethod(methodId);
            return method.run.apply(null, rest);
            LogUtil.exitLogScope("livecoding", "7473368133778549627");
          }
        };
      }
    }
    public function initSession ( sessionId : String ) : void {
      this.sessionId = sessionId;
      LogUtil.addEventListener(DataEvent.DATA,       function ( e : DataEvent ) : void {
        incomingData(e.data, sessionId);
      });
      
      var clientId : String  = LogUtil.startLiveCodingSession(sessionId);
      {
        LogUtil.enterLogScope("livecoding", "9091078376703266005");
        LogUtil.log("trace", "4144789857666611501", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["Start Live Code Session: " + clientId].join(", "));
        LogUtil.exitLogScope("livecoding", "9091078376703266005");
      }
    }
    public function stopSession (  ) : void {
      LogUtil.disablePong();
    }
    public function incomingData ( strinData : String, sessionId : String  = null ) : void {
      {
        LogUtil.enterLogScope("livecoding", "3572192687419688036");
        LogUtil.log("trace", "3572192687419688040", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["incoming-data: " + strinData].join(", "));
        LogUtil.exitLogScope("livecoding", "3572192687419688036");
      }
      var result : *  = /^livecoding::(.+)::(.+)::(\d+)$/.exec(strinData);
      if ( result ) {
        var data : String  = result[1];
        var dataSessionId : String  = result[2];
        if ( !(sessionId) || dataSessionId == sessionId ) {
          var packageId : int  = int(result[3]);
          var tokens : Array  = data.split("|");
          var methods : Array  = [];
          var assets : Array  = [];
          for each ( var token : String in tokens ) {
            if ( /^base-url:/.test(token) ) {
              baseUrl = /^(base-url:)(.+)$/.exec(token)[2];
            }else{
              if ( /^method:/.test(token) ) {
                var methodChange : MethodChange  = new MethodChange(token);
                methodChange.event = new MethodUpdateEvent(methodChange.className, methodChange.methodName);
                (CollectionsLanguageUtil.add(methods, methodChange, MethodChange) as MethodChange);
              } else if ( /^asset:/.test(token) ) {
                var assetChange : AssetChange  = new AssetChange(token);
                assetChange.event = new AssetUpdateEvent(assetChange.source);
                (CollectionsLanguageUtil.add(assets, assetChange, AssetChange) as AssetChange);
              }
            }
          }
          if ( (methods.length > 0) || (assets.length > 0) ) {
            loadPackage(packageId, methods, assets);
          }
        }
      }
    }
    private function loadPackage ( packageId : int, methods : Array, assets : Array ) : void {
      var loader : URLLoader  = new URLLoader();
      loader.dataFormat = URLLoaderDataFormat.BINARY;
      var url : String  = "livecoding/package_" + packageId + ".swf";
      if ( baseUrl ) {
        url = baseUrl + "/" + url;
      }
      /*
      {
        LogUtil.enterLogScope("livecoding", "5542952190228936455");
        LogUtil.log("trace", "855151659769229414", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["try to load package from \"" + url + "\""].join(", "));
        LogUtil.exitLogScope("livecoding", "5542952190228936455");
      }
       */
      
      loader.addEventListener(Event.COMPLETE,       function ( e : Event ) : void {
        var classLoader : Loader  = new Loader();
        var loaderContext : LoaderContext  = new LoaderContext(false, ApplicationDomain.currentDomain);
        loaderContext.allowCodeImport = true;
        classLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,         function ( e : Event ) : void {
          lastPackage = packageId;
          CollectionsLanguageUtil.forEach(methods,           function ( it : MethodChange, stops : Object ) : void {
            try {
              var methodClass : Class  = getDefinitionByName(it.changeClassName) as Class;
              putMethod(it.methodId, methodClass, it);
              dispatchEvent(it.event);
            } catch ( e : Error ) {
              {
                LogUtil.enterLogScope("livecoding", "4671562459499402741");
                LogUtil.log("error", "4671562459499402745", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["cant't find method-update class: " + it.changeClassName].join(", "), e);
                LogUtil.exitLogScope("livecoding", "4671562459499402741");
              }
            }
          }, this, false);
          CollectionsLanguageUtil.forEach(assets,           function ( it : AssetChange, stops : Object ) : void {
            try {
              var messageClass : Class  = getDefinitionByName(it.className) as Class;
              var assetUpdate : IAssetUpdate  = new messageClass();
              it.event.assetClass = assetUpdate.getAsset();
              dispatchEvent(it.event);
            } catch ( e : Error ) {
              {
                LogUtil.enterLogScope("livecoding", "4671562459499402802");
                LogUtil.log("error", "4671562459499402806", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["cant't find asset-update class: " + it.className].join(", "), e);
                LogUtil.exitLogScope("livecoding", "4671562459499402802");
              }
            }
          }, this, false);
        });
        classLoader.loadBytes(loader.data, loaderContext);
      });
      loader.addEventListener(IOErrorEvent.IO_ERROR,       function ( e : IOErrorEvent ) : void {
        {
          LogUtil.enterLogScope("livecoding", "4671562459499402879");
          LogUtil.log("error", "4671562459499402883", "r:5865b376-a157-43b1-b990-70db6dbffde6(codeOrchestra.actionScript.liveCoding.util)", "codeOrchestra.actionScript.liveCoding.util.LiveCodeRegistry", "" + ["error loading file from: " + url].join(", "));
          LogUtil.exitLogScope("livecoding", "4671562459499402879");
        }
      });
      loader.load(new URLRequest(url));
    }
  }
}


import codeOrchestra.actionScript.liveCoding.util.MethodType;
import codeOrchestra.actionScript.liveCoding.util.MethodUpdateEvent;
import codeOrchestra.actionScript.liveCoding.util.AssetUpdateEvent;


class Singlitonizer {
  public function Singlitonizer(  ){
    
  }
}
class MethodChange {
  public var className : String ;
  public var methodName : String ;
  public var changeClassName : String ;
  public var methodId : String ;
  public var isStatic : Boolean ;
  public var type : MethodType ;
  public var timestamp : String ;
  public var event : MethodUpdateEvent ;
  public function MethodChange( data : String ){
    var c1 : Number;
    (c1 = -1);
    var tokens : Array  = data.split(":");
    changeClassName = tokens[c1 = 1];
    className = tokens[++c1];
    methodName = tokens[++c1];
    methodId = tokens[++c1];
    isStatic = tokens[++c1] == "1";
    type = MethodType.fromInt(tokens[++c1]);
    timestamp = tokens[++c1];
  }
  public function toString (  ) : String {
    return "MethodChange { " + "className=" + this.className + ", " + "methodName=" + this.methodName + ", " + "changeClassName=" + this.changeClassName + ", " + "methodId=" + this.methodId + ", " + "isStatic=" + this.isStatic + ", " + "type=" + this.type + " }";
  }
}
class AssetChange {
  public var className : String ;
  public var source : String ;
  public var timestamp : String ;
  public var event : AssetUpdateEvent ;
  public function AssetChange( data : String ){
    var c2 : Number;
    (c2 = -1);
    var tokens : Array  = data.split(":");
    className = tokens[c2 = 1];
    source = tokens[++c2];
    timestamp = tokens[++c2];
  }
  public function toString (  ) : String {
    return "AssetChange { " + "className=" + this.className + ", " + "source=" + this.source + ", " + "timestamp=" + this.timestamp + ", " + "event=" + this.event + " }";
  }
}
