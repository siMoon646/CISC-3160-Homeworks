import java.util.List;

class Main {
    public static void main(String[] args) {
        // System.out.println(concat(List.of(10, 2, 15))); 
        // System.out.println(contains(List.of(10, 2, 15, 13), 15));
        // System.out.println(containsDuplicate(List.of()));
        // System.out.println(containsConsecutiveDuplicate(List.of()));
        // System.out.println(isSorted(List.of()));
        System.out.println(equals(List.of(21,23,22), List.of(21,23,22)));
    }

/**
 * Returns the string concatenation of all the elements of lst. Examples:
 *   concat(List.of(10, 2, 15)) -> "10215"
 *   concat(List.of())          -> ""
 */
static String concat(List<Integer> lst) {
    if(lst.size() == 0){
        return "";
    }
    return lst.getFirst().toString().concat(concat(lst.subList(1,lst.size())));
}

/**
 * Returns true if lst contains e, otherwise returns false. Examples:
 *   contains(List.of(10, 2, 15, 13), 15) -> true
 *   contains(List.of(10, 2, 15, 13), 14) -> false
 *   contains(List.of(), 15)              -> false
 */
static boolean contains(List<Integer> lst, int e) {
    if(lst.size() == 0){
        return false;
    }
    return e == lst.getFirst() || contains(lst.subList(1,lst.size()), e);
}

/**
 * Determines whether lst contains any two elements that are equal to each other. Examples:
 *   containsDuplicate(List.of(5, 8, 3, 5, 10, 3, 9)) -> true
 *   containsDuplicate(List.of(5, 8, 3))              -> false
 *   containsDuplicate(List.of(5, 5))                 -> true
 *   containsDuplicate(List.of(5))                    -> false
 *   containsDuplicate(List.of())                     -> false
 */
static boolean containsDuplicate(List<Integer> lst) {
    if(lst.size() <= 1){
        return false;
    }
    return contains(lst.subList(1, lst.size()), lst.getFirst()) || containsDuplicate(lst.subList(1,lst.size()));
}

/**
 * Determines whether any two consecutive elements of lst are equal to each other. Examples:
 *   containsConsecutiveDuplicate(List.of(5, 8, 3, 5, 10, 3, 9)) -> false
 *   containsConsecutiveDuplicate(List.of(5, 7, 3, 3, 2))        -> true
 *   containsConsecutiveDuplicate(List.of(5))                    -> false
 *   containsConsecutiveDuplicate(List.of())                     -> false
 */
static boolean containsConsecutiveDuplicate(List<Integer> lst) {
    if(lst.size() <= 1){
        return false;
    }
    return (int) lst.getFirst() == (lst.subList(1,lst.size()).getFirst()) || containsConsecutiveDuplicate(lst.subList(1,lst.size()));
}

/**
 * Determines whether the elements of lst are sorted from smallest to greatest. Examples:
 *   isSorted(List.of(5, 15, 15, 18)) -> true
 *   isSorted(List.of(10, 9, 8))      -> false
 *   isSorted(List.of(5, 10, 7, 12))  -> false
 *   isSorted(List.of(6))             -> true
 *   isSorted(List.of())              -> true
 */
static boolean isSorted(List<Integer> lst) {
    if(lst.size() <= 1){
        return true;
    }
    return lst.getFirst() <= lst.subList(1,lst.size()).getFirst() && isSorted(lst.subList(1,lst.size()));
}

/**
 * Determines whether the two provided lists contain equal elements in the same order.
 */
static boolean equals(List<Integer> lst1, List<Integer> lst2) {
    if (lst1.size() == 0 && lst2.size() == 0){
        return true;
    } else if (lst1.size() != lst2.size()) {
        return false;
    }
    return (int) lst1.getFirst() == (lst2.getFirst()) && equals(lst1.subList(1,lst1.size()), lst2.subList(1,lst2.size()));
}

}