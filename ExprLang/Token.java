package ExprLang;

/*
Example source:  (10+20)*30
It consists of the following tokens:
    Lexeme      type:
    (           LEFT_PAREN
    10          NUMBER 
    +           PLUS
    20          NUMBER
    )           RIGHT_PAREN   
    *           STAR
    30          NUMBER
                EOF
Last token doesn't have a lexeme--it's just end of file
*/

/* class Token {
//     private final String lexeme; // Piece of text in the source code
//     private final TokenType type; // The category 

//     Token(String lexeme, TokenType type){
//         this.lexeme = lexeme;
//         this.type = type;
//     }

//     String lexeme() {
//         return lexeme;
//     }

//     TokenType type() {
//         return type;
//     }
}
*/

// Record: concise way to write a class whose fields are unmodifiable (offers getters, but no mutators).

/**
 * @param lexeme    piece of text in the source code
 * @param type      the category
 */

record Token (String lexeme, TokenType type){
    @Override
    public String toString() {
        return type + " " + lexeme;
    }
}


