namespace SnakeGameFinal
{
    /*
     * GameBoard - Represents the game arena grid dimensions and boundary limits.
     *
     * Encapsulation:
     * - 'rows', 'columns', and 'cellSize' (in pixels) are private fields set once in the constructor.
     * - Read-only public properties expose these values safely to other classes.
     *
     * Boundary Collision Logic:
     * - IsInsideBoard checks whether any grid position falls within valid 0-indexed bounds.
     *   If X < 0, X >= columns, Y < 0, or Y >= rows, a boundary collision has occurred!
     */
    public class GameBoard
    {
        // Total horizontal grid cells (columns) and vertical grid cells (rows)
        private int rows;
        private int columns;

        // Size in screen pixels for each individual cell tile (e.g., 20px)
        private int cellSize;

        // Constructor: initializes grid dimensions and pixel scaling
        public GameBoard(int rows, int columns, int cellSize)
        {
            this.rows = rows;
            this.columns = columns;
            this.cellSize = cellSize;
        }

        // Read-only count of board rows
        public int Rows
        {
            get { return rows; }
        }

        // Read-only count of board columns
        public int Columns
        {
            get { return columns; }
        }

        // Read-only cell dimension in pixels
        public int CellSize
        {
            get { return cellSize; }
        }

        // Boundary check: returns true if the coordinate is strictly inside the playable board
        public bool IsInsideBoard(Position position)
        {
            return position.X >= 0 && position.X < columns &&
                   position.Y >= 0 && position.Y < rows;
        }

        // Clears the entire board canvas with a clean white background
        public void Draw(Graphics graphics)
        {
            graphics.Clear(Color.White);
        }
    }
}
