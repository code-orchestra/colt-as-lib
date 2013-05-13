package codeOrchestra.actionScript.collections.util{
  
  import flash.utils.Dictionary;
  
  [AlwaysUsed]
  public class CollectionsLanguageUtil {
    public static function add ( list : Array, value : Object, type : Class  = null ) : Object {
      CastUtil.checkType(value, type);
      list.push(value);
      return value;
    }
    public static function addAll ( list : Array, value : Object ) : void {
      for each ( var e : * in value ) {
        list.push(e);
      }
    }
    public static function addFirst ( list : Array, value : Object, type : Class  = null ) : Object {
      CastUtil.checkType(value, type);
      list.unshift(value);
      return value;
    }
    public static function clear ( list : Array ) : Object {
      var len : uint  = list.length;
      for ( var i : int  = 0 ; i < len ; i++ ) {
        list.pop();
      }
      return list;
    }
    public static function all ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Boolean {
      var c : int  = 0;
      for each ( var e : * in list ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, c++);
        }
        var result : *  = filter.apply(thisObject, [e, stops]);
        if ( stops.stop ) {
          return false;
        }
        if ( stops.skip ) {
          continue ;
        }
        if ( !(result) ) {
          return false;
        }
      }
      return true;
    }
    public static function fill ( list : Array, filter : Function, thisObject : Object ) : Array {
      var stops : Object  = {};
      filter.apply(thisObject, [stops]);
      if ( stops.yeld ) {
        for each ( var e : * in stops.yeld ) {
          list.push(e);
        }
      }
      return list;
    }
    public static function yeld ( stops : Object, value : Object ) : void {
      if ( !(stops.yeld) ) {
        stops.yeld = [];
      }
      (stops.yeld as Array).push(value);
    }
    public static function any ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Boolean {
      var c : int  = 0;
      for each ( var e : * in list ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, c++);
        }
        var result : *  = filter.apply(thisObject, [e, stops]);
        if ( stops.stop ) {
          return false;
        }
        if ( stops.skip ) {
          continue ;
        }
        if ( result ) {
          return true;
        }
      }
      return false;
    }
    public static function containsAll ( list : Array, checked : Object ) : Boolean {
      for each ( var e : * in checked ) {
        if ( list.indexOf(e) == -1 ) {
          return false;
        }
      }
      return true;
    }
    public static function cut ( list : Array, length : int ) : Array {
      var result : Array  = new Array();
      var len : uint  = list.length;
      for ( var i : int  = 0 ; i < len - length ; i++ ) {
        result.push(list[i]);
      }
      return result;
    }
    public static function distinct ( list : Array ) : Array {
      var checked : Array  = new Array();
      var len : uint  = list.length;
      for ( var i : int  = 0 ; i < len ; i++ ) {
        var element : *  = list[i];
        if ( checked.indexOf(element) == -1 ) {
          checked.push(element);
        }
      }
      return checked;
    }
    public static function except ( list : Array, excepted : Array ) : Array {
      var checked : Array  = new Array();
      var len : uint  = list.length;
      for ( var i : int  = 0 ; i < len ; i++ ) {
        var element : *  = list[i];
        if ( excepted.indexOf(element) == -1 ) {
          checked.push(element);
        }
      }
      return checked;
      
    }
    public static function findFirst ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Object {
      var c : int  = 0;
      for each ( var e : * in list ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, c++);
        }
        var result : *  = filter.apply(thisObject, [e, stops]);
        if ( stops.stop ) {
          return null;
        }
        if ( stops.skip ) {
          continue ;
        }
        if ( result ) {
          return e;
        }
      }
      return null;
    }
    public static function findLast ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Object {
      return findFirst(list.concat().reverse(), filter, thisObject, useIterator);
    }
    public static function foldRight ( list : Array, filter : Function, seed : Object, thisObject : Object, useIterator : Boolean ) : Object {
      var result : *  = seed;
      var c : int  = 0;
      for each ( var e : * in list ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, c++);
        }
        var resultTmp : *  = result;
        result = filter.apply(thisObject, [e, result, stops]);
        if ( stops.stop ) {
          return resultTmp;
        }
        if ( stops.skip ) {
          result = resultTmp;
          continue ;
        }
      }
      return result;
    }
    public static function foldLeft ( list : Array, filter : Function, seed : Object, thisObject : Object, useIterator : Boolean ) : Object {
      return foldRight(list.concat().reverse(), filter, seed, thisObject, useIterator);
    }
    public static function forEach ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : void {
      var c : int  = 0;
      for each ( var e : * in list ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, c++);
        }
        filter.apply(thisObject, [e, stops]);
        if ( stops.stop ) {
          return ;
        }
        if ( stops.skip ) {
          continue ;
        }
      }
    }
    private static function checkLength ( list : Array, index : int ) : Boolean {
      var c : int  = 0;
      for each ( var e : * in list ) {
        if ( index >= (e as Array).length ) {
          c++;
        }
      }
      return !(c >= list.length);
    }
    public static function forEachMulti ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : void {
      var c : int  = 0;
      while ( checkLength(list, c) ) {
        var tuple : Array  = new Array();
        for each ( var n : * in list ) {
          tuple.push(n[c]);
        }
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, c);
        }
        filter.apply(thisObject, [tuple, stops]);
        if ( stops.stop ) {
          return ;
        }
        if ( stops.skip ) {
          continue ;
        }
        c++;
      }
    }
    public static function headList ( list : Array, length : int ) : Array {
      var result : Array  = new Array();
      for ( var i : int  = 0 ; i < length ; i++ ) {
        result.push(list[i]);
      }
      return result;
    }
    public static function insert ( list : Array, index : int, value : Object ) : Object {
      var tail : Array  = removeTail(list, list.length - index);
      list.push(value);
      addAll(list, tail);
      return value;
    }
    public static function interselect ( listFirst : Array, listSecond : Array ) : Array {
      var result : Array  = new Array();
      for each ( var e : * in listFirst.concat(listSecond) ) {
        if ( result.indexOf(e) == -1 ) {
          if ( listFirst.indexOf(e) != -1 && listSecond.indexOf(e) != -1 ) {
            result.push(e);
          }
        }
      }
      return result;
    }
    public static function disjunction ( listFirst : Array, listSecond : Array ) : Array {
      var result : Array  = new Array();
      for each ( var e : * in listFirst.concat(listSecond) ) {
        if ( result.indexOf(e) == -1 ) {
          if ( listFirst.indexOf(e) != -1 && listSecond.indexOf(e) == -1 ) {
            result.push(e);
          } else if ( listFirst.indexOf(e) == -1 && listSecond.indexOf(e) != -1 ) {
            result.push(e);
          }
        }
      }
      return result;
    }
    public static function page ( list : Array, from : int, to : int ) : Array {
      var result : Array  = new Array();
      for ( var i : int  = from ; i <= to ; i++ ) {
        result.push(list[i]);
      }
      return result;
    }
    public static function reduceRight ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Object {
      var result : *  = list[0];
      var len : uint  = list.length;
      for ( var i : int  = 0 ; i < len - 1 ; i++ ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, i);
          addIterator(stops, 1, list, i + 1);
        }
        var resultTmp : *  = result;
        result = filter.apply(thisObject, [result, list[i + 1], stops]);
        if ( stops.stop ) {
          return resultTmp;
        }
        if ( stops.skip ) {
          result = resultTmp;
          continue ;
        }
      }
      return result;
    }
    public static function reduceLeft ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Object {
      return reduceRight(list.concat().reverse(), filter, thisObject, useIterator);
    }
    public static function remove ( list : Array, element : Object ) : Object {
      var old : Array  = list.concat();
      clear(list);
      for each ( var e : * in old ) {
        if ( e != element ) {
          list.push(e);
        }
      }
      return element;
    }
    public static function removeAt ( list : Array, index : int ) : Object {
      var tail : Array  = removeTail(list, list.length - index);
      var result : *  = tail.shift();
      addAll(list, tail);
      return result;
    }
    public static function removeAll ( list : Array, value : Array ) : Array {
      for each ( var e : * in value ) {
        remove(list, e);
      }
      return value;
    }
    public static function removeHead ( list : Array, count : int ) : Array {
      var result : Array  = new Array();
      while ( count-- > 0 ) {
        result.push(list.shift());
      }
      return result;
    }
    public static function removeTail ( list : Array, count : int ) : Array {
      var result : Array  = new Array();
      while ( count-- > 0 ) {
        result.push(list.pop());
      }
      return result.reverse();
    }
    public static function removeWhere ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Array {
      var old : Array  = list.concat();
      var tmpList : Array  = list.concat();
      clear(list);
      var c : int  = 0;
      for each ( var e : * in old ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, c++);
        }
        var result : *  = filter.apply(thisObject, [e, stops]);
        if ( stops.stop ) {
          clear(list);
          addAll(list, tmpList);
          return list;
        }
        if ( stops.skip || !(result) ) {
          list.push(e);
        }
      }
      return list;
    }
    public static function select ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Array {
      var result : Array  = new Array();
      var len : uint  = list.length;
      for ( var i : int  = 0 ; i < len ; i++ ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, i);
        }
        var newElement : *  = filter.apply(thisObject, [list[i], stops]);
        if ( stops.stop ) {
          return result;
        }
        if ( !(stops.skip) ) {
          result.push(newElement);
        }
      }
      return result;
    }
    public static function selectMany ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Array {
      var result : Array  = new Array();
      var len : uint  = list.length;
      for ( var i : int  = 0 ; i < len ; i++ ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, i);
        }
        var newElement : *  = filter.apply(thisObject, [list[i], stops]);
        if ( stops.stop ) {
          return result;
        }
        if ( !(stops.skip) ) {
          addAll(result, newElement);
        }
      }
      return result;
    }
    public static function skip ( list : Array, skipElements : int ) : Array {
      var tmp : Array  = new Array();
      addAll(tmp, list);
      clear(list);
      var toSkip : Array  = new Array();
      for ( var i : int  = 0 ; i < tmp.length ; i++ ) {
        if ( i >= skipElements ) {
          list.push(tmp[i]);
        }else{
          toSkip.push(tmp[i]);
        }
      }
      return toSkip;
    }
    public static function subList ( list : Array, start : int, end : int ) : Array {
      var result : Array  = new Array();
      for ( var i : int  = start ; i <= end ; i++ ) {
        result.push(list[i]);
      }
      return result;
    }
    public static function tail ( list : Array, elements : int ) : Array {
      var result : Array  = new Array();
      var len : uint  = list.length;
      for ( var i : int  = len - elements ; i < len ; i++ ) {
        result.push(list[i]);
      }
      return result;
    }
    public static function take ( list : Array, elements : int ) : Array {
      var result : Array  = new Array();
      var len : uint  = list.length;
      for ( var i : int  = len - elements ; i < len ; i++ ) {
        result.push(list[i]);
      }
      return result;
    }
    public static function toVector ( list : Array ) : Vector.<Object> {
      var result : Vector.<Object>  = new Vector.<Object>();
      for each ( var e : * in list ) {
        result.push(e);
      }
      return result;
    }
    public static function toArray ( v : * ) : Array {
      var result : Array  = new Array();
      for each ( var e : * in v ) {
        result.push(e);
      }
      return result;
    }
    public static function copy ( list : Array ) : Array {
      var result : Array  = new Array();
      addAll(result, list);
      return result;
    }
    public static function union ( list : Array, value : Array ) : Array {
      var result : Array  = new Array();
      addAll(result, list);
      addAll(result, value);
      return result;
    }
    public static function where ( list : Array, filter : Function, thisObject : Object, useIterator : Boolean ) : Array {
      var result : Array  = new Array();
      var len : uint  = list.length;
      for ( var i : int  = 0 ; i < len ; i++ ) {
        var stops : Object  = {};
        if ( useIterator ) {
          addIterator(stops, 0, list, i);
        }
        var condition : *  = filter.apply(thisObject, [list[i], stops]);
        if ( stops.stop ) {
          return result;
        }
        if ( !(stops.skip) && condition ) {
          result.push(list[i]);
        }
      }
      return result;
    }
    public static function times ( times : int, filter : Function, thisObject : Object ) : void {
      for ( var i : int  = 0 ; i < times ; i++ ) {
        var stops : Object  = {};
        filter.apply(thisObject, [(i + 1), stops]);
        if ( stops.stop ) {
          return ;
        }
        if ( !(stops.skip) ) {
          continue ;
        }
      }
    }
    public static function addIterator ( stops : Object, param : int, list : Array, index : int ) : void {
      stops.iterator = {};
      stops.iterator[param] = {index:index, previous:list[index - 1], next:list[index + 1], hasNext:(index < list.length - 1), hasPrevious:(index > 0)}
    }
    public static function createMap ( initializer : Array  = null ) : Dictionary {
      var dic : Dictionary  = new Dictionary();
      if ( initializer != null ) {
        for each ( var e : * in initializer ) {
          dic[e[0]] = e[1];
        }
      }
      return dic;
    }
    public static function mapKeys ( dic : Dictionary ) : Array {
      var result : Array  = new Array();
      for ( var v : * in dic ) {
        result.push(v);
      }
      return result;
    }
    public static function mapValues ( dic : Dictionary ) : Array {
      var result : Array  = new Array();
      for each ( var v : * in dic ) {
        result.push(v);
      }
      return result;
    }
    public static function containsValue ( dic : Dictionary, value : Object ) : Boolean {
      return mapValues(dic).indexOf(value) != -1;
    }
    public static function containsKey ( dic : Dictionary, key : Object ) : Boolean {
      return key in dic;
    }
    public static function putMap ( dic : Dictionary, value : Dictionary ) : Dictionary {
      for ( var key : * in value ) {
        dic[key] = value[key];
      }
      return value;
    }
    public static function removeKey ( dic : Dictionary, key : Object ) : Object {
      delete dic[key];
      return key;
    }
    public static function checkListType ( list : Array, typeExpression : Class ) : Array {
      for each ( var e : * in list ) {
        if ( !(list is typeExpression) ) {
          throw new Error("" + e + " is not subtype of " + typeExpression);
        }
      }
      return list;
    }
    public static function checkMapType ( dic : Dictionary, typeExpression : Class ) : Dictionary {
      checkListType(mapKeys(dic), typeExpression);
      checkListType(mapValues(dic), typeExpression);
      return dic;
    }
    public static function newMapInstance ( o : Object ) : Dictionary {
      var dictionary : Dictionary  = new Dictionary();
      for ( var v : * in o ) {
        dictionary[v] = o[v];
      }
      return dictionary;
    }
    public static function clearMap ( dic : Dictionary ) : void {
      for ( var v : * in dic ) {
        delete dic[v];
      }
    }
  }
}




