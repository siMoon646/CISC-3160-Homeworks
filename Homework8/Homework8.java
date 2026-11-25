import java.util.function.Function;
import Homework7.Homework7.List;
void main() {
    BiFunction<Integer, Integer, Integer> pow = (a, b) -> (int) Math.pow(a, b);
    IO.println(pow.apply(2, 3)); // 8 (2 raised to the power of 3)
    IO.println(flip(pow).apply(2, 3)); // 9 (3 raised to the power of 2)
}

static <T, U, R> Function<T, R> compose(Function<U,R> f, Function<T, U> g){
    return t -> f.apply(g.apply(t));
}

static <T, U, R> BiFunction<U, T, R> flip(BiFunction<T, U, R> f){
    return (u, t) -> f.apply(t, u);
}

static <T, U, R> Function<U, R> partial(BiFunction<T, U, R> f, T x){
    return u -> f.apply(x, u);
}

// takes a function f of two parameters and returns a function g of one parameter that itself returns a function of one parameter such that g(x)(y) = f(x, y). (Note: g(x)(y) means that g(x) returns a function which is then applied to y.)
static <T, U, R> Function<T, Function<U, R>> curry(BiFunction<T, U, R> f){
    return t -> u -> f.apply(t, u);
}

static <T, U, R> BiFunction<T, U, R> uncurry(Function<T, Function<U, R>> f){
    return (t, u) -> f.apply(t).apply(u);
}

static <E> E foldLeft(List<E> lst, E init, BinaryOperator<E> op){
    return lst.isEmpty() ? init : foldLeft(lst.rest(), op.apply(init, lst.first()), op); 
}

static <E> E foldRight(List<E> lst, E init, BinaryOperator<E> op){
    return lst.isEmpty() ? init : op.apply(lst.first(), foldRight(lst.rest(), init, op)); 
}