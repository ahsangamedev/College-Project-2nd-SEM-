namespace SnakeGameFinal
{
    /*
     * Snake - Represents the player's crawling snake.
     *
     * Encapsulation:
     * - The list of body segments and direction variables are private.
     * - External classes can only steer using SetDirection, which enforces rules
     *   (e.g., you cannot reverse directly backward into your own neck).
     *
     * How the snake moves:
     * - The body is stored as a list of grid coordinates: body[0] is the head.
     * - On every move:
     *   1. A brand new head position is created in front of the current head.
     *   2. It is inserted at index 0 of the body list.
     *   3. If the snake did NOT eat food on this step, the last tail piece is removed.
     *      -> Result: Snake slides forward at the same length.
     *   4. If the snake DID eat food, the tail piece is kept.
     *      -> Result: Snake grows longer by 1 segment!
     */
    public class Snake
    {
        // Ordered list of segments: index 0 is head, last index is tail tip
        private List<Position> body;

        // Current moving direction and buffered next direction
        private Direction currentDirection;
        private Direction nextDirection;

        // Constructor: spawns a 3-segment snake starting horizontally facing Right
        public Snake(Position startPosition)
        {
            body = new List<Position>();

            // Head at startPosition, with 2 body segments trailing to the left
            body.Add(new Position(startPosition.X, startPosition.Y));
            body.Add(new Position(startPosition.X - 1, startPosition.Y));
            body.Add(new Position(startPosition.X - 2, startPosition.Y));

            currentDirection = Direction.Right;
            nextDirection = Direction.Right;
        }

        // Returns the head segment of the snake (index 0)
        public Position Head
        {
            get { return body[0]; }
        }

        // Steers the snake in a new direction.
        // Reversals (e.g., Up -> Down or Left -> Right) are intentionally blocked
        // so the player cannot accidentally bite their own neck.
        public void SetDirection(Direction newDirection)
        {
            if (currentDirection == Direction.Up && newDirection == Direction.Down)
            {
                return;
            }
            if (currentDirection == Direction.Down && newDirection == Direction.Up)
            {
                return;
            }
            if (currentDirection == Direction.Left && newDirection == Direction.Right)
            {
                return;
            }
            if (currentDirection == Direction.Right && newDirection == Direction.Left)
            {
                return;
            }

            // Valid direction change: buffer it for the next movement step
            nextDirection = newDirection;
        }

        // Advances the snake by 1 cell in the current direction.
        // If 'grow' is true (food was eaten), the tail is preserved so length increases.
        public void Move(bool grow)
        {
            currentDirection = nextDirection;

            int newX = Head.X;
            int newY = Head.Y;

            // Calculate new head coordinates based on heading
            if (currentDirection == Direction.Up)
            {
                newY = newY - 1;
            }
            else if (currentDirection == Direction.Down)
            {
                newY = newY + 1;
            }
            else if (currentDirection == Direction.Left)
            {
                newX = newX - 1;
            }
            else if (currentDirection == Direction.Right)
            {
                newX = newX + 1;
            }

            // Insert new head at the very front
            body.Insert(0, new Position(newX, newY));

            // If we didn't eat, drop the oldest segment at the tail to maintain length
            if (grow == false)
            {
                body.RemoveAt(body.Count - 1);
            }
        }

        // Checks if the planned next head position collides with any part of its own body
        public bool WouldHitBody(Position nextHead)
        {
            for (int i = 0; i < body.Count; i++)
            {
                if (body[i].IsSameAs(nextHead))
                {
                    return true;
                }
            }
            return false;
        }

        // Helper to check if any segment of the snake currently occupies a given coordinate
        // (Useful when placing food or obstacles so they don't spawn inside the snake)
        public bool Occupies(Position position)
        {
            for (int i = 0; i < body.Count; i++)
            {
                if (body[i].IsSameAs(position))
                {
                    return true;
                }
            }
            return false;
        }

        // Projects where the head will be on the upcoming tick without actually moving yet
        public Position GetNextHeadPosition()
        {
            int newX = Head.X;
            int newY = Head.Y;

            if (nextDirection == Direction.Up)
            {
                newY = newY - 1;
            }
            else if (nextDirection == Direction.Down)
            {
                newY = newY + 1;
            }
            else if (nextDirection == Direction.Left)
            {
                newX = newX - 1;
            }
            else if (nextDirection == Direction.Right)
            {
                newX = newX + 1;
            }

            return new Position(newX, newY);
        }

        // Draws the entire snake onto the canvas.
        // The head (index 0) is drawn in DarkGreen to stand out, and body segments in Green.
        public void Draw(Graphics graphics, int cellSize)
        {
            for (int i = 0; i < body.Count; i++)
            {
                int x = body[i].X * cellSize;
                int y = body[i].Y * cellSize;

                // Subtract 2 pixels from width and height to give a clean tile border
                Rectangle area = new Rectangle(x + 1, y + 1, cellSize - 2, cellSize - 2);

                if (i == 0)
                {
                    graphics.FillRectangle(Brushes.DarkGreen, area); // Head
                }
                else
                {
                    graphics.FillRectangle(Brushes.Green, area);     // Body
                }
            }
        }
    }
}
