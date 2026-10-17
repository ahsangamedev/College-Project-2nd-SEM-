namespace SnakeGameFinal
{
    /*
     * Obstacle - Solid hazard blocks scattered randomly across the board.
     *
     * Inheritance:
     * - Inherits from GameObject to reuse spatial Position tracking.
     *
     * Polymorphism:
     * - Overrides GameObject.Draw to paint a solid gray square with clean borders.
     *
     * Game Rules:
     * - Hitting any obstacle block triggers an immediate Game Over.
     */
    public class Obstacle : GameObject
    {
        // Constructor: anchors this obstacle to a specific grid coordinate
        public Obstacle(Position position) : base(position)
        {
        }

        // Draws the obstacle as a solid gray tile block
        public override void Draw(Graphics graphics, int cellSize)
        {
            int x = Position.X * cellSize;
            int y = Position.Y * cellSize;
            graphics.FillRectangle(Brushes.Gray, x + 1, y + 1, cellSize - 2, cellSize - 2);
        }
    }
}
