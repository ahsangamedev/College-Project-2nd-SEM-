namespace SnakeGameFinal
{
    /*
     * Food - Represents standard food items spawned on the board.
     *
     * Inheritance:
     * - Inherits from GameObject to reuse the grid Position property.
     *
     * Encapsulation:
     * - 'points' is private and exposed through the read-only Points property.
     *
     * Polymorphism:
     * - Overrides the abstract Draw method from GameObject to paint a red circle.
     */
    public class Food : GameObject
    {
        // Points awarded when the snake eats this food
        private int points;

        // Constructor that allows setting custom points (used by subclasses like BonusFood)
        public Food(Position position, int points) : base(position)
        {
            this.points = points;
        }

        // Default constructor: standard food grants 10 points
        public Food(Position position) : this(position, 10)
        {
        }

        // Read-only score value
        public int Points
        {
            get { return points; }
        }

        // Draws the food as a red circle slightly inset within the grid cell
        public override void Draw(Graphics graphics, int cellSize)
        {
            int x = Position.X * cellSize;
            int y = Position.Y * cellSize;
            graphics.FillEllipse(Brushes.Red, x + 2, y + 2, cellSize - 4, cellSize - 4);
        }
    }
}
