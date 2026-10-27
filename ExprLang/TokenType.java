package ExprLang;

/* only eight possible values:
    NUMBER, PLUS, MINUS, STAR, SLASH, LEFT_PAREN, RIGHT_PAREN, EOF
*/

// Writing enums -- like a class, but all of its objects are pre-created.

enum TokenType {
    NUMBER,
    PLUS,
    MINUS,
    STAR,
    SLASH,
    LEFT_PAREN,
    RIGHT_PAREN,
    EOF
}

class TokenTypeDemo {
    static void main(){
        TokenType type = TokenType.PLUS;
        demo(TokenType.EOF);
    }

    // can be used in conditionals:
    static void demo(TokenType type) {
        if (type == TokenType.LEFT_PAREN || type == TokenType.RIGHT_PAREN){
            IO.println("paren");
        } else {
            IO.println("not paren");
        }

        switch (type) {
            case LEFT_PAREN, RIGHT_PAREN -> IO.println("paren");
            case PLUS, MINUS, STAR, SLASH -> IO.println("operator");
            default -> IO.println("Something else");    
        }
    }
    
}