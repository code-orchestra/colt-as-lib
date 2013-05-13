package codeOrchestra.actionScript.collections.util{
  
  import flash.utils.Dictionary;
  
  /**
   * This implementation permits
<tt>null</tt> values and the <tt>null</tt> key.
   */
  public class HashMap {
    private var _keys : * ;
    private var _size : uint ;
    private var _values : * ;
    public function HashMap( ...arguments ){
      clear();
      var k : Array  = (arguments[0] as Array);
      var v : Array  = (arguments[1] as Array);
      if ( k != null && v != null ) {
        if ( k.length > 0 && k.length == v.length ) {
          var count : int  = k.length;
          for ( var i : int  = 0 ; i < count ; i++ ) {
            put(k[i], v[i]);
          }
        }
      }
    }
    /**
     * Removes all of the mappings from this map.
     * The map will be empty after this call returns.
     */
    public function clear (  ) : void {
      _keys = new Dictionary(true);
      _values = new Dictionary(true);
      _size = 0;
    }
    /**
     * Returns a shallow copy of this <tt>HashMap</tt> instance: the keys and values themselves are not cloned.
     * @return a shallow copy of this map
     */
    public function clone (  ) : * {
      var newMap : HashMap  = new HashMap();
      newMap.putAll(this);
      return newMap;
    }
    /**
     * Returns <tt>true</tt> if this map contains a mapping for the specified key.
     * @param key The key whose presence in this map is to be tested
     * @return <tt>true</tt> if this map contains a mapping for the specified key
     */
    public function containsKey ( key : * ) : Boolean {
      return _keys[key] !== undefined;
    }
    /**
     * Returns <tt>true</tt> if this map maps one or more keys to the specified value.
     * @param value value whose presence in this map is to be tested
     * @return <tt>true</tt> if this map maps one or more keys to the specified value
     */
    public function containsValue ( value : * ) : Boolean {
      return _values[value] !== undefined;
    }
    /**
     * Returns the value to which the specified key is mapped.
     * <p>A return value of <tt>null</tt> does not <i>necessarily</i>
     * indicate that the map contains no mapping for the key; it's also
     * possible that the map explicitly maps the key to <tt>null</tt>.
     * The <tt>containsKey()</tt> operation may be used to
     * distinguish these two cases.
     */
    public function get ( key : * ) : * {
      return _keys[key];
    }
    /**
     * Set?
     * Returns an array representation of all keys in the map.
     * @return an array representation of all keys in the map
     */
    public function getKeys (  ) : Array {
      var ar : Array  = [];
      for ( var key : * in _keys ) {
        ar.push(key);
      }
      return ar;
    }
    /**
     * Collection?
     * Returns an array representation of all values in the map.
     * @return an array representation of all values in the map
     */
    public function getValues (  ) : Array {
      var ar : Array  = [];
      for each ( var value : * in _keys ) {
        ar.push(value);
      }
      return ar;
    }
    /**
     * Returns <tt>true</tt> if this map contains no key-value mappings.
     * @return <tt>true</tt> if this map contains no key-value mappings
     */
    public function isEmpty (  ) : Boolean {
      return _size == 0;
    }
    /**
     * Associates the specified value with the specified key in this map.
     * If the map previously contained a mapping for the key, the old
     * value is replaced.
     * @param key key with which the specified value is to be associated
     * @param value value to be associated with the specified key
     * @return the previous value associated with <tt>key</tt>, or
     *         <tt>null</tt> if there was no mapping for <tt>key</tt>.
     *         (A <tt>null</tt> return can also indicate that the map
     *         previously associated <tt>null</tt> with <tt>key</tt>.)
     */
    public function put ( key : *, value : * ) : * {
      var r : *  = null;
      if ( containsKey(key) ) {
        r = _keys[key];
        remove(key);
      }
      var count : uint  = _values[value];
      _values[value] = (count > 0) ? count + 1 : 1;
      _size++;
      _keys[key] = value;
      return r;
    }
    /**
     * Copies all of the mappings from the specified map to this map.
     * These mappings will replace any mappings that this map had for
     * any of the keys currently in the specified map.
     * @param m mappings to be stored in this map
     */
    public function putAll ( m : HashMap ) : void {
      var v : Array  = m.getValues();
      var k : Array  = m.getKeys();
      var l : int  = k.length;
      for ( var i : int ; i < l ; i = i - (-1) ) {
        put(k[i], v[i]);
      }
    }
    /**
     * Removes the mapping for the specified key from this map if present.
     * @param  key key whose mapping is to be removed from the map
     * @return the previous value associated with <tt>key</tt>, or
     *         <tt>null</tt> if there was no mapping for <tt>key</tt>.
     *         (A <tt>null</tt> return can also indicate that the map
     *         previously associated <tt>null</tt> with <tt>key</tt>.)
     */
    public function remove ( key : * ) : * {
      var value : *;
      if ( containsKey(key) ) {
        _size--;
        value = _keys[key];
        var count : uint  = _values[value];
        if ( count > 1 ) {
          _values[value] = count - 1;
        }else{
          delete _values[value];
        }
        delete _keys[key];
        return value;
      }else{
        return null;
      }
    }
    /**
     * Returns the number of key-value mappings in this map.
     * @return the number of key-value mappings in this map
     */
    public function size (  ) : uint {
      return _size;
    }
  }
}




