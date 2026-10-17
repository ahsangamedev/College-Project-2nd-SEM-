namespace SnakeGameFinal
{
    /*
     * GameObject - Abstract base class for any stationary entity on the board.
     *
     * Abstraction & Inheritance:
     * - Provides common spatial coordinates (Position) shared by Food, BonusFood, and Obstacle.
     * - Declares an abstract Draw() method, forcing every child class to define
     *   how it draws itself on the grid.
     *
     * Encapsulation:
     * - The position field is private and accessed through a read-only Position property.
     */
    public abstract class GameObject
    {
        // Grid cell coordinate of this object
        private Position position;

        // Constructor: stores the grid coordinate where this object resides
        public GameObject(Position position)
        {
            this.position = position;
        }

        // Public read-only property to inspect this object's grid position
        public Position Position
        {
            get { return position; }
        }

        // Abstract drawing contract: each subclass must provide its own shape and color
        public abstract void Draw(Graphics graphics, int cellSize);
    }
}
