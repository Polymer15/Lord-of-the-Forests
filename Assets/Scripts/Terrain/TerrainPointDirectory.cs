using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TerrainPointDirectory {
    private static TerrainPoint[,] _terrainPoints;

    public static int Width { get; private set; }

    /// <summary>
    /// Initialize the terrain
    /// </summary>
    /// <param name="width"></param>
    public static void Initialize(int width) {
        Width = width;

        _terrainPoints = new TerrainPoint[width, width];
    }

    /// <summary>
    /// Gets a point on the terrain
    /// </summary>
    /// <param name="x">x position</param>
    /// <param name="y">y position</param>
    /// <returns>The terrain point</returns>
    public static TerrainPoint GetPoint(int x, int y) {
        if (x >= 0 && y >= 0 && x < Width && y < Width)
            return _terrainPoints[x, y];
        else
            return null;
    }

    /// <summary>
    /// Sets a point on the terrain
    /// </summary>
    /// <param name="point">Point object to set</param>
    /// <returns>The terrain point</returns>
    public static TerrainPoint SetPoint(TerrainPoint point) {
        _terrainPoints[point.X, point.Y] = point;
        return point;
    }
}
