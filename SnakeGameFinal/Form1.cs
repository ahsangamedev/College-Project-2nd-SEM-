namespace SnakeGameFinal
{
    /*
     * Encapsulation: gameManager is private. The form talks to the game
     * through GameManager methods instead of changing snake data directly.
     * Constructor: creates the 25x30 board and loads the high score.
     *
     * Logic: Start sets speed and obstacles from Easy/Medium/Hard.
     * Each timer tick moves the snake, updates labels, and redraws.
     * Arrow keys / WASD change direction. P pauses.
     */
    public partial class Form1 : Form
    {
        private GameManager gameManager;
        private GameMusic gameMusic;

        public Form1()
        {
            InitializeComponent();

            string highScorePath = Path.Combine(Application.StartupPath, "highscore.txt");
            gameManager = new GameManager(25, 30, 20, highScorePath);

            string musicPath = Path.Combine(Application.StartupPath, "Game", "game_music.mp3");
            if (File.Exists(musicPath) == false)
            {
                musicPath = Path.Combine(Application.StartupPath, "game_music.mp3");
            }
            gameMusic = new GameMusic(musicPath);

            cmbDifficulty.SelectedIndex = 1;
            UpdateLabels();
            this.KeyDown += Form1_KeyDown;
            this.FormClosing += Form1_FormClosing;
        }

        private void BtnStart_Click(object sender, EventArgs e)
        {
            StartGame();
        }

        private void BtnRestart_Click(object sender, EventArgs e)
        {
            StartGame();
        }

        private void BtnPause_Click(object sender, EventArgs e)
        {
            PauseOrResume();
        }

        private void BtnExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void StartGame()
        {
            string difficulty = "Medium";
            if (cmbDifficulty.SelectedItem != null)
            {
                difficulty = cmbDifficulty.SelectedItem.ToString();
            }

            gameTimer.Interval = GetTimerSpeed(difficulty);
            gameManager.StartNewGame(GetObstacleCount(difficulty));
            gameTimer.Start();
            gameMusic.PlayLoop();

            cmbDifficulty.Enabled = false;
            btnStart.Enabled = false;
            btnRestart.Enabled = true;
            btnPause.Enabled = true;
            btnPause.Text = "Pause";

            UpdateLabels();
            pnlGameArea.Invalidate();
            this.Focus();
        }

        private int GetTimerSpeed(string difficulty)
        {
            if (difficulty == "Easy")
            {
                return 180;
            }
            if (difficulty == "Hard")
            {
                return 70;
            }
            return 110;
        }

        private int GetObstacleCount(string difficulty)
        {
            if (difficulty == "Easy")
            {
                return 0;
            }
            if (difficulty == "Hard")
            {
                return 8;
            }
            return 4;
        }

        private void PauseOrResume()
        {
            if (gameManager.TogglePause() == false)
            {
                return;
            }

            if (gameManager.IsPaused)
            {
                gameTimer.Stop();
                gameMusic.Pause();
                btnPause.Text = "Resume";
            }
            else
            {
                gameTimer.Start();
                gameMusic.Resume();
                btnPause.Text = "Pause";
            }

            UpdateLabels();
        }

        private void GameTimer_Tick(object sender, EventArgs e)
        {
            gameManager.Update();
            UpdateLabels();
            pnlGameArea.Invalidate();

            if (gameManager.IsGameOver)
            {
                gameTimer.Stop();
                gameMusic.Stop();
                cmbDifficulty.Enabled = true;
                btnStart.Enabled = true;
                btnPause.Enabled = false;
                btnPause.Text = "Pause / Resume";

                DialogResult result = MessageBox.Show(
                    this,
                    "Game over!\nFinal score: " + gameManager.Score +
                    "\nHigh score: " + gameManager.HighScore +
                    "\n\nRestart?",
                    "Snake Game",
                    MessageBoxButtons.YesNo);

                if (result == DialogResult.Yes)
                {
                    StartGame();
                }
            }
        }

        private void PnlGameArea_Paint(object sender, PaintEventArgs e)
        {
            gameManager.Draw(e.Graphics);
        }

        private void UpdateLabels()
        {
            lblScore.Text = "Score: " + gameManager.Score;
            lblHighScore.Text = "High Score: " + gameManager.HighScore;
            lblStatus.Text = "Status: " + gameManager.GetStatusText();
        }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Up || e.KeyCode == Keys.W)
            {
                gameManager.ChangeDirection(Direction.Up);
            }
            else if (e.KeyCode == Keys.Down || e.KeyCode == Keys.S)
            {
                gameManager.ChangeDirection(Direction.Down);
            }
            else if (e.KeyCode == Keys.Left || e.KeyCode == Keys.A)
            {
                gameManager.ChangeDirection(Direction.Left);
            }
            else if (e.KeyCode == Keys.Right || e.KeyCode == Keys.D)
            {
                gameManager.ChangeDirection(Direction.Right);
            }
            else if (e.KeyCode == Keys.P)
            {
                PauseOrResume();
            }
        }

        // Arrow keys were moving button focus, so this handles them first.
        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == Keys.Up)
            {
                gameManager.ChangeDirection(Direction.Up);
                return true;
            }
            if (keyData == Keys.Down)
            {
                gameManager.ChangeDirection(Direction.Down);
                return true;
            }
            if (keyData == Keys.Left)
            {
                gameManager.ChangeDirection(Direction.Left);
                return true;
            }
            if (keyData == Keys.Right)
            {
                gameManager.ChangeDirection(Direction.Right);
                return true;
            }

            return base.ProcessCmdKey(ref msg, keyData);
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            gameMusic.Stop();
        }
    }
}
