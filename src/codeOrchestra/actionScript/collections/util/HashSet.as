package codeOrchestra.actionScript.collections.util{
  
  
  /**
   * A collection that contains no duplicate elements. 
   * @see http://www.docjar.com/html/api/java/util/HashSet.java.html
   * @see http://www.docjar.com/docs/api/java/util/Set.html
   */
  public class HashSet {
    /**
     * Dummy value to associate with an Object in the backing Map
     */
    private static var PRESENT : Object  = new Object() ;
    private var map : HashMap  = new HashMap() ;
    /**
     * Returns the number of elements in this set (its cardinality).
     * @return the number of elements in this set (its cardinality)
     */
    public function size (  ) : uint {
      return map.size();
    }
    /**
     * Returns <tt>true</tt> if this set contains no elements.
     * @return <tt>true</tt> if this set contains no elements
     */
    public function isEmpty (  ) : Boolean {
      return map.isEmpty();
    }
    /**
     * Returns <tt>true</tt> if this set contains the specified element.
     * @param o element whose presence in this set is to be tested
     * @return <tt>true</tt> if this set contains the specified element
     */
    public function contains ( o : * ) : Boolean {
      return map.containsKey(o);
    }
    /**
     * Adds the specified element to this set if it is not already present.
     * @param e element to be added to this set
     * @return <tt>true</tt> if this set did not already contain the specified element
     */
    public function add ( e : * ) : Boolean {
      return (map.put(e, PRESENT) == null);
    }
    /**
     * Removes the specified element from this set if it is present.
     * @param o object to be removed from this set, if present
     * @return <tt>true</tt> if the set contained the specified element
     */
    public function remove ( o : * ) : Boolean {
      return (map.remove(o) == PRESENT);
    }
    /**
     * Removes all of the elements from this set.
     * The set will be empty after this call returns.
     */
    public function clear (  ) : void {
      map.clear();
    }
    /**
     * Returns a shallow copy of this <tt>HashSet</tt> instance: the elements themselves are not cloned.
     * @return a shallow copy of this set
     */
    public function clone (  ) : * {
      var newSet : HashSet  = new HashSet();
      newSet.map = map.clone();
      return newSet;
    }
    /**
     * Removes from this set all of its elements that are contained in the specified array.
     */
    public function removeAll ( c : Array ) : Boolean {
      var modified : Boolean;
      for ( var i : int  = 0, n : int  = c.length ; i < n ; i++ ) {
        if ( contains(c[i]) ) {
          remove(c[i]);
          modified = true;
        }
      }
      return modified;
    }
    /**
     * Iterates over the specified array, and adds each object to this set, in turn.
     */
    public function addAll ( c : Array ) : Boolean {
      var modified : Boolean;
      for ( var i : int  = 0, n : int  = c.length ; i < n ; i++ ) {
        if ( !(contains(c[i])) ) {
          add(c[i]);
          modified = true;
        }
      }
      return modified;
    }
    /**
     * Iterates over the specified array,
     * checking each element in turn to see
     * if it's contained in this set.  If all elements are so
     * contained <tt>true</tt> is returned, otherwise <tt>false</tt>.
     */
    public function containsAll ( c : Array ) : Boolean {
      for ( var i : int  = 0, n : int  = c.length ; i < n ; i++ ) {
        if ( !(contains(c[i])) ) {
          return false;
        }
      }
      return true;
    }
    /**
     * Iterates over this set, checking each
     * element in turn to see if it's contained
     * in the specified array.  If it's not so contained, it's removed
     * from this set with <tt>remove</tt> method.
     */
    public function retainAll ( c : Array ) : Boolean {
      var modified : Boolean;
      var v : Array  = map.getValues();
      for ( var i : int  = 0, n : int  = v.length ; i < n ; i++ ) {
        if ( c.indexOf(v[i]) < 0 ) {
          remove(v[i]);
          modified = true;
        }
      }
      return modified;
    }
  }
}




