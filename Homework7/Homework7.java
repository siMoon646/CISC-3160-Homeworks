package Homework7;
import java.util.function.*;

public class Homework7 {
    
    public sealed interface List<E> permits EmptyList, NonemptyList {

        // basic methods

        E first();
        List<E> rest();
        boolean isEmpty();
        @Override String toString();

        // additional methods

        int length();
        E at(int index);
        boolean contains(E e);
        E last();
        List<E> take(int n);
        List<E> drop(int n);
        List<E> reversed();
        List<E> append(List<E> other);

        // higher-order methods
        boolean every(Predicate<E> predicate); 
        // Returns true iff the predicate is true for each element of this list.

        boolean some(Predicate<E> predicate); 
        // Returns true iff the predicate is true for at least one element of this list.

        <F> List<F> map(Function<E, F> mapper);
        // F is a type parameter just for this method. It is needed since the mapper function might convert 
        // the elements of the original list, which are of type E, to elements of another type, F. 
        // For example, if L is a List<String>, L.map(s -> s.length()) returns a List<Integer>.
        
        List<E> filter(Predicate<E> predicate); // Done in class.

        E reduce(E initial, BinaryOperator<E> accumulator); 
        // Returns the result of combining the elements of this list using the provided accumulator 
        // and the provided initial value. For example, if L is [3, 5, 7], then 
        // L.reduce((a, b) -> a + b, 4) should return 19 (= 4 + 3 + 5 + 7).
        // If this list is empty, the initial value should be returned.

        void forEach(Consumer<E> consumer); // Applies the consumer to each element of this list.

        // static methods

        static <E> List<E> empty() {
            return new EmptyList<>();
        }

        static <E> List<E> from(E first, List<E> rest) {
            return new NonemptyList<>(first, rest);
        }

        static <E> List<E> of(E... elements) {
            return of(elements, 0);
        }

        private static <E> List<E> of(E[] elements, int startIndex) {
            if (startIndex >= elements.length) {
                return empty();
            } else {
                return from(elements[startIndex], of(elements, startIndex + 1));
            }
        }
    }

    record EmptyList<E>() implements List<E> {
        @Override
        public E first() {
            throw new RuntimeException();
        }

        @Override
        public List<E> rest() {
            throw new RuntimeException();
        }

        @Override
        public boolean isEmpty() {
            return true;
        }

        @Override
        public String toString() {
            return "[]";
        }

        @Override
        public int length() {
            return 0;
        }

        @Override 
        public E at(int index){
            throw new RuntimeException();
        }

        @Override 
        public boolean contains(E e){
            return false;
        }

        @Override 
        public E last(){
            throw new RuntimeException();
        }

        @Override 
        public List<E> take(int n){
            return this;
        }

        @Override 
        public List<E> drop(int n){
            return this;
        }

        public List<E> reversed(){
            return this;
        }

        public List<E> append(List<E> other){
            return other;
        }

        public boolean every(Predicate<E> predicate){
            return true;
        }

        public boolean some(Predicate<E> predicate){
            return false;
        }

        public <F> List<F> map(Function<E, F> mapper){
            return List.empty(); // map usually return a new list, not modifying the original. So return a new EmptyList
        }

        public List<E> filter(Predicate<E> predicate){
            return this;
        }

        public E reduce(E initial, BinaryOperator<E> accumulator){
            return initial;
        }

        public void forEach(Consumer<E> consumer){
            return;
        }

        
    }

    record NonemptyList<E>(E first, List<E> rest) implements List<E> {
        // methods first() and rest() are provided by Java

        @Override
        public boolean isEmpty() {
            return false;
        }

        @Override
        public String toString() {
            return "[" + first + restToString(rest) + "]";
        }

        private static <E> String restToString(List<E> rest) {
            if (rest.isEmpty()) {
                return "";
            } else {
                return ", " + rest.first() + restToString(rest.rest());
            }
        }

        // TODO the rest of the List methods

        @Override
        public int length() {
            return 1 + rest.length();
        }

        @Override
        public E at(int index) {
            if (index == 0){
                return first;
            } else {
                return rest.at(index - 1);
            }
        }

        @Override
        public boolean contains(E e) {
            return first.equals(e) || rest.contains(e);
        }

        @Override
        public E last() {
            if(rest.isEmpty()){
                return first;
            } else {
                return rest.last();
            }
        }

        @Override
        public List<E> take(int n) {
            if (n == 0){
                return List.empty();
            } else {
                return List.from(first, rest.take(n - 1));
            }
        }

        @Override
        public List<E> drop(int n) {
            if (n == 0){
                return this;
            } else {
                return rest.drop(n - 1);
            }
        }

        @Override
        public List<E> reversed() {
            return rest.reversed().append(List.of(first));
        }

        @Override
        public List<E> append(List<E> other) {
            return List.from(first, rest.append(other));
        }

        @Override
        public boolean every(Predicate<E> predicate) {
            return (predicate.test(first)) && rest.every(predicate);
        }

        @Override
        public boolean some(Predicate<E> predicate) {
            return (predicate.test(first)) || rest.some(predicate);
        }

        @Override
        public <F> List<F> map(Function<E, F> mapper) {
            return List.from(mapper.apply(first), rest.map(mapper));
        }

        @Override
        public List<E> filter(Predicate<E> predicate) {
            List<E> filteredRest = rest.filter(predicate); // this is a list of all of the elements 
            return predicate.test(first) ? List.from(first, filteredRest) : filteredRest;
        }

        @Override
        public E reduce(E initial, BinaryOperator<E> accumulator) { // 
            return accumulator.apply(first, rest.reduce(initial, accumulator));
        }

        @Override
        public void forEach(Consumer<E> consumer) {
        }
    }
}




