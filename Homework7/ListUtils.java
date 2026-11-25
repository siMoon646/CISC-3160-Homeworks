package Homework7;

import Homework7.Homework7.List;

class ListUtils{
    static <E> boolean equals(List<E> list1, List<E> list2) {
        if(list1.isEmpty() && list2.isEmpty()){
            return true;
        } else if (list1.isEmpty() || list2.isEmpty()){
            return false;
        } else {
            return list1.first().equals(list2.first()) && equals(list1.rest(), list2.rest());
        }
    }

    static <E extends Number> double sum(List<E> list) {
        if (list.isEmpty()){
            return 0;
        } else {
            return (double) list.first() + sum(list.rest());
        }
    }
    
    // precondition: !list.isEmpty()
    static <E extends Comparable<E>> E max(List<E> list) {
        if (list.rest().isEmpty()){
            return list.first();
        } else {
            E maximum = max(list.rest()); // // maximum begins as the last elt of the list -- deepest call returns last-elt
            return list.first().compareTo(maximum) > 0 ? list.first() : maximum;
        }
    }

    static <E extends Comparable<E>> boolean isSorted(List<E> list) {
        if(list.rest().isEmpty()){
            return true;
        } else {
            
        }
    }
    
    // Given two sorted lists, return a sorted list containing all the elements of the two original lists.
    // Example: if L1 is [3, 5, 6, 10] and L2 is [5, 8, 12, 15], then merge(L1, L2) is [3, 5, 5, 6, 8, 10, 12, 15].
    // preconditions: isSorted(list1), isSorted(list2)
    static <E extends Comparable<E>> List<E> mergeSorted(List<E> list1, List<E> list2) {
        // TODO
        return List.empty();
    }
}
