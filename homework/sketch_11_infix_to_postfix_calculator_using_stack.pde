import java.util.Stack;

String inputExpr = "3+4*(2-1)";
String postfixExpr = "";
String resultStr = "";

void setup() {
  size(600, 400);
  textFont(createFont("Arial", 18));
  processExpression(inputExpr);
}

void draw() {
  background(245);
  
  fill(30);
  textSize(22);
  textAlign(LEFT, TOP);
  text("Infix to Postfix Calculator (Stack)", 30, 30);
  
  textSize(16);
  fill(50);
  text("1. Key in your expression and press ENTER:", 30, 80);
  
  fill(255);
  stroke(180);
  rect(30, 110, 540, 40, 8);
  
  fill(0);
  textAlign(LEFT, CENTER);
  text(inputExpr, 40, 130);
  
  fill(230, 240, 255);
  stroke(100, 150, 250);
  rect(30, 180, 540, 170, 8);
  
  fill(20, 40, 80);
  textAlign(LEFT, TOP);
  text("Postfix (후위 표기식):", 50, 200);
  textSize(20);
  fill(200, 30, 30);
  text(postfixExpr, 50, 225);
  
  textSize(16);
  fill(20, 40, 80);
  text("Calculation Result (계산 결과):", 50, 275);
  textSize(22);
  fill(0, 120, 50);
  text(resultStr, 50, 300);
  
  textSize(12);
  fill(120);
  text("* 지원 연산자: +, -, *, /, %, (, )  |  사칙연산 및 괄호 지원", 30, 365);
}

void keyPressed() {
  if (key == ENTER || key == RETURN) {
    processExpression(inputExpr);
  } else if (key == BACKSPACE) {
    if (inputExpr.length() > 0) {
      inputExpr = inputExpr.substring(0, inputExpr.length() - 1);
    }
  } else if (key != CODED && key >= ' ' && key <= '~') {
    inputExpr += key;
  }
}

void processExpression(String infix) {
  try {
    postfixExpr = infixToPostfix(infix);
    double evalResult = evaluatePostfix(postfixExpr);
    if (evalResult == (long) evalResult) {
      resultStr = String.format("%d", (long) evalResult);
    } else {
      resultStr = String.format("%.4f", evalResult);
    }
  } catch (Exception e) {
    postfixExpr = "Error (식 오류)";
    resultStr = "Error: " + e.getMessage();
  }
}

int precedence(char op) {
  switch (op) {
    case '+': case '-': return 1;
    case '*': case '/': case '%': return 2;
  }
  return -1;
}

String infixToPostfix(String infix) {
  StringBuilder result = new StringBuilder();
  Stack<Character> stack = new Stack<>();
  
  for (int i = 0; i < infix.length(); i++) {
    char c = infix.charAt(i);
    
    if (c == ' ') continue;
    
    if (Character.isDigit(c) || c == '.') {
      while (i < infix.length() && (Character.isDigit(infix.charAt(i)) || infix.charAt(i) == '.')) {
        result.append(infix.charAt(i));
        i++;
      }
      result.append(' ');
      i--;
    } 
    else if (c == '(') {
      stack.push(c);
    } 
    else if (c == ')') {
      while (!stack.isEmpty() && stack.peek() != '(') {
        result.append(stack.pop()).append(' ');
      }
      if (!stack.isEmpty() && stack.peek() == '(') {
        stack.pop();
      } else {
        throw new IllegalArgumentException("괄호 불일치");
      }
    } 
    else if (c == '+' || c == '-' || c == '*' || c == '/' || c == '%') {
      while (!stack.isEmpty() && precedence(c) <= precedence(stack.peek())) {
        result.append(stack.pop()).append(' ');
      }
      stack.push(c);
    } else {
      throw new IllegalArgumentException("잘못된 문자가 있습니다: " + c);
    }
  }
  
  while (!stack.isEmpty()) {
    if (stack.peek() == '(') {
      throw new IllegalArgumentException("괄호 불일치");
    }
    result.append(stack.pop()).append(' ');
  }
  
  return result.toString().trim();
}

double evaluatePostfix(String postfix) {
  if (postfix.isEmpty()) return 0;
  
  Stack<Double> stack = new Stack<>();
  String[] tokens = postfix.split("\\s+");
  
  for (String token : tokens) {
    if (token.isEmpty()) continue;
    
    if (isNumber(token)) {
      stack.push(Double.parseDouble(token));
    } 
    else {
      if (stack.size() < 2) {
        throw new IllegalArgumentException("수식 오류");
      }
      double val2 = stack.pop();
      double val1 = stack.pop();
      
      switch (token.charAt(0)) {
        case '+': stack.push(val1 + val2); break;
        case '-': stack.push(val1 - val2); break;
        case '*': stack.push(val1 * val2); break;
        case '/': 
          if (val2 == 0) throw new ArithmeticException("0으로 나눌 수 없음");
          stack.push(val1 / val2); 
          break;
        case '%': stack.push(val1 % val2); break;
        default:
          throw new IllegalArgumentException("알 수 없는 연산자");
      }
    }
  }
  
  if (stack.size() != 1) {
    throw new IllegalArgumentException("올바르지 않은 수식");
  }
  
  return stack.pop();
}

boolean isNumber(String str) {
  try {
    Double.parseDouble(str);
    return true;
  } catch (NumberFormatException e) {
    return false;
  }
}
