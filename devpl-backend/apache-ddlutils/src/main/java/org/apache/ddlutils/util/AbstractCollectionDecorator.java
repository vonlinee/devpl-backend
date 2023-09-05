package org.apache.ddlutils.util;

import java.util.Collection;
import java.util.Iterator;

/**
 * Decorates another <code>Collection</code> to provide additional behaviour.
 * <p>
 * Each method call made on this <code>Collection</code> is forwarded to the
 * decorated <code>Collection</code>. This class is used as a framework on which
 * to build to extensions such as synchronized and unmodifiable behaviour. The
 * main advantage of decoration is that one decorator can wrap any implementation
 * of <code>Collection</code>, whereas sub-classing requires a new class to be
 * written for each implementation.
 * <p>
 * This implementation does not perform any special processing with
 * {@link #iterator()}. Instead, it simply returns the value from the
 * wrapped collection. This may be undesirable, for example if you are trying
 * to write an unmodifiable implementation it might provide a loophole.
 * @author Stephen Colebourne
 * @author Paul Jack
 * @version $Revision: 1.4 $ $Date: 2004/06/02 21:53:03 $
 * @since Commons Collections 3.0
 */
public abstract class AbstractCollectionDecorator<E> implements Collection<E> {

    /**
     * The collection being decorated
     */
    protected Collection<E> collection;

    /**
     * Constructor only used in deserialization, do not use otherwise.
     * @since Commons Collections 3.1
     */
    protected AbstractCollectionDecorator() {
        super();
    }

    /**
     * Constructor that wraps (not copies).
     * @param coll the collection to decorate, must not be null
     * @throws IllegalArgumentException if the collection is null
     */
    protected AbstractCollectionDecorator(Collection<E> coll) {
        if (coll == null) {
            throw new IllegalArgumentException("Collection must not be null");
        }
        this.collection = coll;
    }

    /**
     * Gets the collection being decorated.
     * @return the decorated collection
     */
    protected Collection<E> getCollection() {
        return collection;
    }

    //-----------------------------------------------------------------------
    @Override
    public boolean add(E object) {
        return collection.add(object);
    }

    @Override
    public boolean addAll(Collection<? extends E> coll) {
        return collection.addAll(coll);
    }

    @Override
    public void clear() {
        collection.clear();
    }

    @Override
    public boolean contains(Object object) {
        return collection.contains(object);
    }

    @Override
    public boolean isEmpty() {
        return collection.isEmpty();
    }

    @Override
    public Iterator<E> iterator() {
        return collection.iterator();
    }

    @Override
    public boolean remove(Object object) {
        return collection.remove(object);
    }

    @Override
    public int size() {
        return collection.size();
    }

    @Override
    public Object[] toArray() {
        return collection.toArray();
    }

    @Override
    public Object[] toArray(Object[] object) {
        return collection.toArray(object);
    }

    @Override
    public boolean containsAll(Collection<?> coll) {
        return collection.containsAll(coll);
    }

    @Override
    public boolean removeAll(Collection<?> coll) {
        return collection.removeAll(coll);
    }

    @Override
    public boolean retainAll(Collection<?> coll) {
        return collection.retainAll(coll);
    }

    @Override
    public boolean equals(Object object) {
        if (object == this) {
            return true;
        }
        return collection.equals(object);
    }

    @Override
    public int hashCode() {
        return collection.hashCode();
    }

    @Override
    public String toString() {
        return collection.toString();
    }

}