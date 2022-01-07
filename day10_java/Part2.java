package day10_java;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Collectors;

public class Part2 {
    private static HashMap<Character, Character> OPEN_TO_CLOSED = new HashMap<Character, Character>() {
        {
            put('(', ')');
            put('{', '}');
            put('[', ']');
            put('<', '>');
        }
    };

    private static HashMap<Character, String> MAPPING = new HashMap<Character, String>() {
        {
            put('(', "1");
            put('[', "2");
            put('{', "3");
            put('<', "4");
        }
    };

    public static void main(String[] args) throws IOException {
        Path path = Paths.get("day10_java/input.txt");
        List<String> lines = Files.readAllLines(path, StandardCharsets.UTF_8);

        List<Long> scores = new ArrayList<Long>();

        for (String line : lines) {
            Stack<Character> stack = new Stack<Character>();
            boolean corrupted = false;
            for (int i = 0; i < line.length(); i++) {
                char c = line.charAt(i);
                if (OPEN_TO_CLOSED.containsKey(c)) {
                    stack.push(c);
                } else {
                    char opened = stack.pop();
                    if (c != OPEN_TO_CLOSED.get(opened)) {
                        // corrupted
                        corrupted = true;
                        break;
                    }
                }
            }
            if (corrupted) {
                continue;
            }
            if (!stack.isEmpty()) {
                String fiveSystem = new StringBuilder(
                        stack.stream().map(x -> MAPPING.get(x)).collect(Collectors.joining())).reverse().toString();
                long score = Long.parseUnsignedLong(fiveSystem, 5);
                scores.add(score);
            }
        }
        scores.sort((a, b) -> a < b ? -1 : 1);
        long mid = scores.get(scores.size() / 2);
        System.out.println(mid);
    }
}
