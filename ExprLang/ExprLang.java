package ExprLang;

import java.util.List;

class ExprLang {
    static void main(){
        IO.println("Welcome to ExprLang");
        String line = IO.readln("> ");

        while(line != null){ // this is checking to see if the user has ended input (ctrl+d)
            run(line);
            line = IO.readln(">");
        }
    }

    private static void run(String source){
        Scanner scanner = new Scanner(source);
        List<Token> tokens = scanner.scanTokens();

        for (Token token : tokens) {
            IO.println(token);
        }

        // Parser parser = new Parser(tokens);
        // Expr ast = parser.parse(); // Abstract

        // Interpreter interpreter = new Interpreter();
        // double result = interpreter.eval(ast);

        // IO.println("Result: " + result);
    }
}