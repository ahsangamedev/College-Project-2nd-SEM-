namespace SnakeGameFinal
{
    partial class Form1
    {
        private System.ComponentModel.IContainer components = null;

        private GameCanvas pnlGameArea;
        private Label lblScore;
        private Label lblHighScore;
        private Label lblStatus;
        private Label lblDifficulty;
        private ComboBox cmbDifficulty;
        private Button btnStart;
        private Button btnRestart;
        private Button btnPause;
        private Button btnExit;
        private Label lblInstructions;
        private System.Windows.Forms.Timer gameTimer;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            components = new System.ComponentModel.Container();
            pnlGameArea = new GameCanvas();
            lblScore = new Label();
            lblHighScore = new Label();
            lblStatus = new Label();
            lblDifficulty = new Label();
            cmbDifficulty = new ComboBox();
            btnStart = new Button();
            btnRestart = new Button();
            btnPause = new Button();
            btnExit = new Button();
            lblInstructions = new Label();
            gameTimer = new System.Windows.Forms.Timer(components);
            SuspendLayout();
            // 
            // pnlGameArea
            // 
            pnlGameArea.BackColor = Color.White;
            pnlGameArea.BorderStyle = BorderStyle.FixedSingle;
            pnlGameArea.Location = new Point(12, 12);
            pnlGameArea.Name = "pnlGameArea";
            pnlGameArea.Size = new Size(602, 502);
            pnlGameArea.TabIndex = 0;
            pnlGameArea.Paint += PnlGameArea_Paint;
            // 
            // lblScore
            // 
            lblScore.AutoSize = true;
            lblScore.Location = new Point(630, 12);
            lblScore.Name = "lblScore";
            lblScore.Size = new Size(48, 15);
            lblScore.TabIndex = 1;
            lblScore.Text = "Score: 0";
            // 
            // lblHighScore
            // 
            lblHighScore.AutoSize = true;
            lblHighScore.Location = new Point(630, 36);
            lblHighScore.Name = "lblHighScore";
            lblHighScore.Size = new Size(77, 15);
            lblHighScore.TabIndex = 2;
            lblHighScore.Text = "High Score: 0";
            // 
            // lblStatus
            // 
            lblStatus.AutoSize = true;
            lblStatus.Location = new Point(630, 60);
            lblStatus.Name = "lblStatus";
            lblStatus.Size = new Size(77, 15);
            lblStatus.TabIndex = 3;
            lblStatus.Text = "Status: Ready";
            // 
            // lblDifficulty
            // 
            lblDifficulty.AutoSize = true;
            lblDifficulty.Location = new Point(630, 96);
            lblDifficulty.Name = "lblDifficulty";
            lblDifficulty.Size = new Size(55, 15);
            lblDifficulty.TabIndex = 4;
            lblDifficulty.Text = "Difficulty";
            // 
            // cmbDifficulty
            // 
            cmbDifficulty.DropDownStyle = ComboBoxStyle.DropDownList;
            cmbDifficulty.Items.AddRange(new object[] { "Easy", "Medium", "Hard" });
            cmbDifficulty.Location = new Point(630, 114);
            cmbDifficulty.Name = "cmbDifficulty";
            cmbDifficulty.Size = new Size(220, 23);
            cmbDifficulty.TabIndex = 0;
            // 
            // btnStart
            // 
            btnStart.Location = new Point(630, 150);
            btnStart.Name = "btnStart";
            btnStart.Size = new Size(220, 30);
            btnStart.TabIndex = 1;
            btnStart.Text = "Start Game";
            btnStart.UseVisualStyleBackColor = true;
            btnStart.Click += BtnStart_Click;
            // 
            // btnRestart
            // 
            btnRestart.Enabled = false;
            btnRestart.Location = new Point(630, 186);
            btnRestart.Name = "btnRestart";
            btnRestart.Size = new Size(220, 30);
            btnRestart.TabIndex = 2;
            btnRestart.Text = "Restart Game";
            btnRestart.UseVisualStyleBackColor = true;
            btnRestart.Click += BtnRestart_Click;
            // 
            // btnPause
            // 
            btnPause.Enabled = false;
            btnPause.Location = new Point(630, 222);
            btnPause.Name = "btnPause";
            btnPause.Size = new Size(220, 30);
            btnPause.TabIndex = 3;
            btnPause.Text = "Pause / Resume";
            btnPause.UseVisualStyleBackColor = true;
            btnPause.Click += BtnPause_Click;
            // 
            // btnExit
            // 
            btnExit.Location = new Point(630, 258);
            btnExit.Name = "btnExit";
            btnExit.Size = new Size(220, 30);
            btnExit.TabIndex = 4;
            btnExit.Text = "Exit";
            btnExit.UseVisualStyleBackColor = true;
            btnExit.Click += BtnExit_Click;
            // 
            // lblInstructions
            // 
            lblInstructions.Location = new Point(630, 310);
            lblInstructions.Name = "lblInstructions";
            lblInstructions.Size = new Size(230, 160);
            lblInstructions.TabIndex = 5;
            lblInstructions.Text = "Controls:\r\nArrow keys or W A S D\r\nP = pause / resume\r\n\r\nRed food = 10 points\r\nOrange food = 20 points\r\nGray blocks are obstacles.\r\nDont hit the wall, yourself or obstacles.";
            // 
            // gameTimer
            // 
            gameTimer.Interval = 110;
            gameTimer.Tick += GameTimer_Tick;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            BackColor = SystemColors.ActiveCaption;
            ClientSize = new Size(880, 540);
            Controls.Add(pnlGameArea);
            Controls.Add(lblScore);
            Controls.Add(lblHighScore);
            Controls.Add(lblStatus);
            Controls.Add(lblDifficulty);
            Controls.Add(cmbDifficulty);
            Controls.Add(btnStart);
            Controls.Add(btnRestart);
            Controls.Add(btnPause);
            Controls.Add(btnExit);
            Controls.Add(lblInstructions);
            FormBorderStyle = FormBorderStyle.FixedSingle;
            KeyPreview = true;
            MaximizeBox = false;
            Name = "Form1";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Snake Game";
            ResumeLayout(false);
            PerformLayout();
        }
    }
}
