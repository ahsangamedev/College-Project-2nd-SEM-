namespace SnakeGameFinal
{
    /*
     * BonusFood - Special high-value food item.
     *
     * Inheritance:
     * - Inherits directly from Food, reusing the position and points infrastructure.
     * - Constructor calls base(position, 20), doubling the point reward to 20 points.
     *
     * Polymorphism:
     * - Overrides Food.Draw to paint an eye-catching orange circle on the board.
     */
    public class BonusFood : Food
    {
        // Constructor: passes position and 20 points up to the base Food constructor
        public BonusFood(Position position) : base(position, 20)
        {
        }

        // Draws the bonus food as an orange circle so the player can spot it easily
        public override void Draw(Graphics graphics, int cellSize)
        {
            int x = Position.X * cellSize;
            int y = Position.Y * cellSize;
            graphics.FillEllipse(Brushes.Orange, x + 2, y + 2, cellSize - 4, cellSize - 4);
        }
    }
}
