namespace SnakeGameFinal
{
    /*
     * HighScoreStore - Manages persistent saving and loading of the highest score.
     *
     * Encapsulation:
     * - 'filePath' and 'highScore' are kept private.
     * - External classes read the top score through the public HighScore property.
     *
     * Reliability / Defensive Programming:
     * - Uses try-catch blocks during file I/O so that if the file is missing,
     *   corrupted, or permissions are restricted, the game continues running smoothly
     *   with a default high score of 0 instead of crashing.
     */
    public class HighScoreStore
    {
        // Absolute or relative path to the text file where high score is stored
        private string filePath;

        // In-memory cache of the current all-time high score
        private int highScore;

        // Constructor: stores target file path and attempts an immediate load
        public HighScoreStore(string filePath)
        {
            this.filePath = filePath;
            highScore = 0;
            Load();
        }

        // Public read-only property to retrieve the loaded high score
        public int HighScore
        {
            get { return highScore; }
        }

        // Reads the saved high score integer from disk if the file exists
        public void Load()
        {
            try
            {
                if (File.Exists(filePath))
                {
                    int value;
                    if (int.TryParse(File.ReadAllText(filePath).Trim(), out value))
                    {
                        highScore = value;
                    }
                }
            }
            catch
            {
                // Fallback gracefully to 0 on any read failure
                highScore = 0;
            }
        }

        // Checks if current score beats the high score; if so, updates memory and writes to file
        public void SaveIfBetter(int score)
        {
            if (score > highScore)
            {
                highScore = score;
                try
                {
                    File.WriteAllText(filePath, highScore.ToString());
                }
                catch
                {
                    // Ignore write failures so gameplay is never interrupted
                }
            }
        }
    }
}
