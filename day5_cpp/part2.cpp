#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <utility>
#include <vector>
#include <map>
#include <algorithm>

using namespace std;

struct Point
{
    int x;
    int y;
};

Point parse_coord(const string &coord_str)
{
    size_t del = coord_str.find(",");
    int x = stoi(coord_str.substr(0, del));
    int y = stoi(coord_str.substr(del + 1, coord_str.length()));
    return Point{x, y};
}

pair<Point, Point> parse(const string &line)
{
    size_t pos = line.find(" -> ");
    string first = line.substr(0, pos);
    string second = line.substr(pos + 4, line.length());
    return make_pair(parse_coord(first), parse_coord(second));
}

int main()
{
    std::vector<pair<Point, Point>> lines;
    ifstream infile;
    infile.open("input.txt");
    string line;
    while (getline(infile, line))
    {
        auto p = parse(line);
        lines.emplace_back(p);
    }
    infile.close();

    const int MAX_COORD = 1000;
    const int GRID_SIZE = MAX_COORD * MAX_COORD;
    int count[GRID_SIZE];
    for (int i = 0; i < GRID_SIZE; i++)
    {
        count[i] = 0;
    }

    for (auto &l : lines)
    {
        Point &f = l.first;
        Point &s = l.second;

        if (f.x == s.x)
        {
            int minY = min(f.y, s.y);
            int maxY = max(f.y, s.y);

            for (int y = minY; y <= maxY; y++)
            {
                count[MAX_COORD * y + f.x]++;
            }
        }
        else if (f.y == s.y)
        {
            int minX = min(f.x, s.x);
            int maxX = max(f.x, s.x);

            for (int x = minX; x <= maxX; x++)
            {
                count[MAX_COORD * f.y + x]++;
            }
        }
        else if (abs(f.x - s.x) == abs(f.y - s.y))
        {
            int minX = min(f.x, s.x);
            int maxX = max(f.x, s.x);

            int y1 = minX == f.x ? f.y : s.y;
            int y2 = y1 == f.y ? s.y : f.y;
            int inc = 1;
            if (y1 > y2)
                inc = -1;

            for (int x = minX, y = y1; x <= maxX; x++, y += inc)
            {
                count[MAX_COORD * y + x]++;
            }
        }
    }

    int result = count_if(count, count + GRID_SIZE, [](int i)
                          { return i >= 2; });
    std::cout << result << "\n";
}