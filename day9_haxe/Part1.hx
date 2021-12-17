class Part1 {
    static public function main() {
        var content:String = sys.io.File.getContent("input.txt");
        var heightMap:Array<Array<Int>> = content.split("\r\n").map(function(line) return line.split("").map(function(x) return Std.parseInt(x)));
        var width = heightMap[0].length;
        var height = heightMap.length;
        var sum = 0;
        for (y in 0...height)
        {
            for (x in 0...width)
            {
                var neighbourCount = 0;
                for (n in [[-1, 0], [1, 0], [0, -1], [0, 1]])
                {
                    var nx = x + n[0];
                    var ny = y + n[1];

                    if (nx >= 0 && ny >= 0 && nx < width && ny < height) {
                        if (heightMap[ny][nx] > heightMap[y][x]) {
                            neighbourCount++;
                        }
                    } else {
                        neighbourCount++;
                    }
                }
                if (neighbourCount == 4) {
                    sum += heightMap[y][x] + 1;
                }
            }
        }
        trace(sum);
    }
}