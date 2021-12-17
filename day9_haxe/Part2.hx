class Part2 {
    static public function main() {
        var content:String = sys.io.File.getContent("input.txt");
        var heightMap:Array<Array<Int>> = content.split("\r\n").map(function(line) return line.split("").map(function(x) return Std.parseInt(x)));
        var width = heightMap[0].length;
        var height = heightMap.length;
        var visited:Array<Array<Bool>> = [for (y in 0...height) [for (x in 0...width) false]];
        var sizes:Array<Int> = [];
        for (y in 0...height)
        {
            for (x in 0...width)
            {
                sizes.push(basinSize(heightMap, visited, x, y));
            }
        }
        sizes.sort(function(a, b) return b - a);
        var product = sizes[0] * sizes[1] * sizes[2];
        trace(sizes);
        trace(product);
    }

    static public function basinSize(heightMap: Array<Array<Int>>, visited: Array<Array<Bool>>, x: Int, y: Int) {
        if (y < 0 || x < 0 || y >= heightMap.length || x >= heightMap[0].length || heightMap[y][x] == 9 || visited[y][x]) {
            return 0;
        }
        visited[y][x] = true;
        var size = 1;
        for (n in  [[-1, 0], [1, 0], [0, -1], [0, 1]])
        {
            size += basinSize(heightMap, visited, x + n[0], y + n[1]);
        }
        return size;
    }
}