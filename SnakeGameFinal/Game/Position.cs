namespace SnakeGameFinal
{
    /*
     * Position - Represents a 2D discrete cell coordinate (Column X, Row Y) on the grid.
     *
     * Encapsulation:
     * - 'x' and 'y' are private fields initialized only in the constructor.
     * - External classes can read them through public properties X and Y,
     *   preventing accidental modification of coordinates.
     */
    public class Position
    {
        // Grid column index (0 to columns - 1)
        private int x;

        // Grid row index (0 to rows - 1)
        private int y;

        // Constructor: sets the immutable grid coordinates for this position
        public Position(int x, int y)
        {
            this.x = x;
            this.y = y;
        }

        // Read-only column coordinate
        public int X
        {
            get { return x; }
        }

        // Read-only row coordinate
        public int Y
        {
            get { return y; }
        }

        // Value comparison helper: checks if another Position shares identical (X, Y) coordinates
        public bool IsSameAs(Position other)
        {
            if (other == null)
            {
                return false;
            }

            return x == other.X && y == other.Y;
        }
    }
}
