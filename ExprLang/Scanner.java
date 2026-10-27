package ExprLang;

import java.util.List;
import java.util.ArrayList;

/**
 * Takes source code, makes sure it contains only valid lexemes and breaks it up
 * into a list of tokens.
 * 
 * Lexical Grammar:
 * lexeme -> "(" | ")" | "+" | "-" | "*" | "/" | number
 * number -> digit+ ("." digit+)?
 * digit -> "0" | "1" | ... | "9"
 * Notes:
 * | means "or"
 * + means at least 1 (that is, 1 or more)
 * ? means optional (that is, 0 or 1)
 * 
 * Note: whitespace is ignored, not considereda lexeme.
 * whitepsace -> " " | "\t"
 * 
 * indexes: 012345678901234567
 * Sample source: " ( 123+567)--5"
 * The lexemes are: ( 123 + 567 ) - - 5
 * 1)
 * 
 */
class Scanner {
    private final String source;
    private final List<Token> tokens = new ArrayList<>();
    private int start = 0; // The beginning of the current lexeme.
    private int current = 0; // The current index in source.

    Scanner(String source) {
        this.source = source;
    }

    List<Token> scanTokens() {
        while (!isAtEnd()) {
            scanToken();
        }

        tokens.add(new Token("", TokenType.EOF));
        return tokens;
    }

    /**
     * Reads one lexeme and adds a corresponding token to the tokens list. Also,
     * skips whitespace.
     */
    private void scanToken() {
        start = current; // remember where the lexeme begins
        char ch = advance(); // the first chracter of the lexeme (or whitespace)
                             // now `current` has been incremented by 1.

        switch (ch) { // processing characters of lexemes
            case '(' -> addToken(TokenType.LEFT_PAREN);
            case ')' -> addToken(TokenType.RIGHT_PAREN);
            case '+' -> addToken(TokenType.PLUS);
            case '-' -> addToken(TokenType.MINUS);
            case '*' -> addToken(TokenType.STAR);
            case '/' -> addToken(TokenType.SLASH);
            case ' ', '\t' -> {
                // ignore whitespace
            }
            default -> {
                if (isDigit(ch)) {
                    scanNumber();
                } else { // Invalid lexeme
                    error("Unexpected character: " + ch);
                }
            }
        }
    }

    /**
     * Assumes that the first digit of a number has just been read.
     * Reads the rest of the number and adds a corresponding token to the tokens list.
     */
    private void scanNumber() { 
        // read more digits, if there are:
        while(isDigit(peek())) { // might not have more digits, so we may not be able to advance.
            advance();
        }

        // optional decimal part
        if(peek() == '.' && isDigit(peekNext())) {
            advance(); // reads the decimal point

            // read the digits after the decimal
            while(isDigit(peek())) { 
                advance();
            }
        }

        addToken(TokenType.NUMBER);
    }

    /**
     * @return the current character without incrementing the `current` variable.
     * If there are no more characters, returns the null character '\0' (the NULL character).
     */
    private char peek() {
        if (current >= source.length()){
            return '\0';
        } else {
            return source.charAt(current);
        }
    }

    /**
     * Returns the next character (after source) in source. If there is no next character, return '\0'
     */
    private char peekNext() {
        if (current + 1 >= source.length()){
            return '\0';
        } else {
            return source.charAt(current + 1);
        }
    }

    /**
     * Adds a token with the specified type to the tokens list.
     * Assumes that `start` points to the first character of the lexeme.
     * Assumes that `current` points to subsequent character after the last
     * character of the lexeme.
     * 
     * @param type
     */
    private void addToken(TokenType type) {
        String lexeme = source.substring(start, current);
        tokens.add(new Token(lexeme, type));
    }

    /**
     * @return current character in source and advances the `current` index to the
     *         next character in the source.
     */
    private char advance() {
        return source.charAt(current++); // post-fix form; increments current after this line runs.
    }

    /**
     * Determines whether we've reached the end of source
     */
    private boolean isAtEnd() {
        // return current == source.length() - 1;
        return current >= source.length();
    }

    /**
     * Determines whether the provided character is a digit.
     */
    private static boolean isDigit(char ch) {
        return '0' <= ch && ch <= '9'; // uses unicode to determine this... probably.
    }

    /**
     * Prints an error message
     */
    private static void error(String message) {
        IO.println(message);
    }
}
