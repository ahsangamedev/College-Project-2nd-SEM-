namespace SnakeGameFinal
{
    /*
     * GameManager - The brain of the game.
     *
     * Encapsulation:
     * - Keeps snake, food, obstacles, and internal flags private.
     * - The UI reads game state through public properties (Score, HighScore, IsPaused, etc.).
     *
     * Polymorphism:
     * - The 'food' reference is of type Food, but at runtime it can hold either a
     *   regular Food (10 pts, red) or a BonusFood (20 pts, orange).
     *   When food.Draw(...) is called, C# automatically executes the right Draw method!
     *
     * Turn-by-turn game loop (Update method):
     * 1. Look ahead to where the snake's head wants to go next.
     * 2. Did it hit the outer wall, an obstacle, or its own body? -> If so, Game Over!
     * 3. Did it land on food? -> If so, grow the snake, add score, save high score,
     *    and spawn a new food item somewhere empty on the board.
     * 4. Otherwise, just slide the snake forward.
     */
    public class GameManager
    {
        // Dimensions and pixel size of the grid
        private GameBoard board;

        // The player's snake entity
        private Snake snake;

        // Currently spawned food (can be Food or BonusFood)
        private Food food;

        // List of obstacle blocks scattered across the board
        private List<Obstacle> obstacles;

        // Persistent file handler for high scores
        private HighScoreStore highScoreStore;

        // Random number generator for food and obstacle positions
        private Random random;

        // Current session score and status flags
        private int score;
        private bool isRunning;
        private bool isPaused;
        private bool isGameOver;

        // Constructor: initializes the board, loads high score from disk, and sets up state
        public GameManager(int rows, int columns, int cellSize, string highScoreFilePath)
        {
            board = new GameBoard(rows, columns, cellSize);
            highScoreStore = new HighScoreStore(highScoreFilePath);
            random = new Random();
            obstacles = new List<Obstacle>();
            score = 0;
            isRunning = false;
            isPaused = false;
            isGameOver = false;
        }

        // Public read-only property to read the player's current score
        public int Score
        {
            get { return score; }
        }

        // Public read-only property to read the persistent all-time high score
        public int HighScore
        {
            get { return highScoreStore.HighScore; }
        }

        // True if the current match is temporarily paused
        public bool IsPaused
        {
            get { return isPaused; }
        }

        // True if the snake has collided and the match has ended
        public bool IsGameOver
        {
            get { return isGameOver; }
        }

        // Formats a clean status text for the on-screen UI label
        public string GetStatusText()
        {
            if (isGameOver)
            {
                return "Game Over";
            }
            if (isPaused)
            {
                return "Paused";
            }
            if (isRunning)
            {
                return "Playing";
            }
            return "Ready";
        }

        // Resets state and starts a brand new game session
        public void StartNewGame(int obstacleCount)
        {
            score = 0;
            isRunning = true;
            isPaused = false;
            isGameOver = false;

            // Spawn the snake right in the middle of the board
            int startX = board.Columns / 2;
            int startY = board.Rows / 2;
            snake = new Snake(new Position(startX, startY));

            // Generate obstacles and place the first food
            CreateObstacles(obstacleCount);
            food = CreateRandomFood();
        }

        // Toggles between paused and unpaused; returns false if game is not active
        public bool TogglePause()
        {
            if (isRunning == false || isGameOver)
            {
                return false;
            }

            isPaused = !isPaused;
            return true;
        }

        // Passes steering commands to the snake (ignored if paused or dead)
        public void ChangeDirection(Direction direction)
        {
            if (isRunning == false || isPaused || isGameOver || snake == null)
            {
                return;
            }

            snake.SetDirection(direction);
        }

        // Executes one step of the game logic on every timer tick
        public void Update()
        {
            // Do nothing if game is paused, not running, or already over
            if (isRunning == false || isPaused || isGameOver)
            {
                return;
            }

            // Check where the snake is about to move
            Position nextHead = snake.GetNextHeadPosition();

            // Collision Check 1: Did we cross the board edge (walls)?
            if (board.IsInsideBoard(nextHead) == false)
            {
                EndGame();
                return;
            }

            // Collision Check 2: Did we hit our own body?
            if (snake.WouldHitBody(nextHead))
            {
                EndGame();
                return;
            }

            // Collision Check 3: Did we crash into a gray obstacle block?
            if (HitsObstacle(nextHead))
            {
                EndGame();
                return;
            }

            // Did the snake's head reach the food?
            bool ateFood = food.Position.IsSameAs(nextHead);

            // Move snake forward. If it ate food, pass true so it grows by 1 segment
            snake.Move(ateFood);

            // If food was eaten: award points, update high score, and spawn fresh food
            if (ateFood)
            {
                score = score + food.Points;
                highScoreStore.SaveIfBetter(score);
                food = CreateRandomFood();
            }
        }

        // Renders all game visual elements onto the Graphics surface
        public void Draw(Graphics graphics)
        {
            // 1. Clear background
            board.Draw(graphics);

            // 2. Draw all obstacle blocks
            for (int i = 0; i < obstacles.Count; i++)
            {
                obstacles[i].Draw(graphics, board.CellSize);
            }

            // 3. Draw food (polymorphically calls Food.Draw or BonusFood.Draw)
            if (food != null)
            {
                food.Draw(graphics, board.CellSize);
            }

            // 4. Draw the snake segments
            if (snake != null)
            {
                snake.Draw(graphics, board.CellSize);
            }
        }

        // Helper called when any collision happens to mark the session as over
        private void EndGame()
        {
            isGameOver = true;
            isRunning = false;
            isPaused = false;
            highScoreStore.SaveIfBetter(score);
        }

        // Spawns a given number of obstacles in random empty spots
        private void CreateObstacles(int count)
        {
            obstacles.Clear();
            int created = 0;
            int attempts = 0;

            // Try to find open spots for obstacles (capped to 200 tries to avoid infinite loops)
            while (created < count && attempts < 200)
            {
                attempts = attempts + 1;
                Position spot = RandomEmptyCell();
                if (spot == null)
                {
                    break;
                }
                obstacles.Add(new Obstacle(spot));
                created = created + 1;
            }
        }

        // Spawns a food item in a random empty spot
        // Has a 1 in 5 (20%) chance to spawn a BonusFood (orange, 20 pts)
        private Food CreateRandomFood()
        {
            Position spot = RandomEmptyCell();
            if (spot == null)
            {
                spot = new Position(0, 0);
            }

            // 20% probability for bonus food
            if (random.Next(0, 5) == 0)
            {
                return new BonusFood(spot);
            }

            // Standard food (red, 10 pts)
            return new Food(spot);
        }

        // Finds an unoccupied grid cell that isn't on the snake, on food, or on an obstacle
        private Position RandomEmptyCell()
        {
            int attempts = 0;
            while (attempts < 400)
            {
                attempts = attempts + 1;
                Position candidate = new Position(random.Next(0, board.Columns), random.Next(0, board.Rows));

                // Make sure snake body is not on this cell
                if (snake != null && snake.Occupies(candidate))
                {
                    continue;
                }
                // Make sure existing food is not already on this cell
                if (food != null && food.Position.IsSameAs(candidate))
                {
                    continue;
                }
                // Make sure an obstacle is not already on this cell
                if (HitsObstacle(candidate))
                {
                    continue;
                }

                // Found a valid free cell!
                return candidate;
            }

            return null;
        }

        // Helper to check if a specific position collides with any obstacle
        private bool HitsObstacle(Position position)
        {
            for (int i = 0; i < obstacles.Count; i++)
            {
                if (obstacles[i].Position.IsSameAs(position))
                {
                    return true;
                }
            }
            return false;
        }
    }
}
