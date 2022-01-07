package day10_java;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;

public class Part1 {
    private static HashMap<Character, Character> OPEN_TO_CLOSED = new HashMap<Character, Character>() {
        {
            put('(', ')');
            put('{', '}');
            put('[', ']');
            put('<', '>');
        }
    };

    private static HashMap<Character, Integer> POINTS = new HashMap<Character, Integer>() {
        {
            put(')', 3);
            put(']', 57);
            put('}', 1197);
            put('>', 25137);
        }
    };

    public static void main(String[] args) throws IOException {
        Path path = Paths.get("day10_java/input.txt");
        List<String> lines = Files.readAllLines(path, StandardCharsets.UTF_8);

        int points = 0;

        for (String line : lines) {
            Stack<Character> stack = new Stack<Character>();
            for (int i = 0; i < line.length(); i++) {
                char c = line.charAt(i);
                if (OPEN_TO_CLOSED.containsKey(c)) {
                    stack.push(c);
                } else {
                    char opened = stack.pop();
                    if (c != OPEN_TO_CLOSED.get(opened)) {
                        // corrupted
                        points += POINTS.get(c);
                        break;
                    }
                }
            }
        }
        System.out.println(points);
    }
}
