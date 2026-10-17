namespace SnakeGameFinal
{
    // Program entry point: initializes application settings and starts the main window.
    internal static class Program
    {
        // STAThread is required for Windows Forms to properly interact with COM and UI components.
        [STAThread]
        static void Main(string[] args)
        {
            // Sets standard Windows Forms defaults like modern fonts, visual styles, and DPI scaling.
            ApplicationConfiguration.Initialize();

            // Check if launched with '--screenshot' argument to automatically capture
            // screenshots for documentation without needing manual gameplay.
            if (args != null && args.Length > 0 && args[0] == "--screenshot")
            {
                TakeScreenshots();
                return;
            }

            // Normal application launch: open and run Form1.
            Application.Run(new Form1());
        }

        // Helper method that opens the form in memory and captures screenshots
        // of different game states (Ready, Active Gameplay, Paused) to PNG files.
        private static void TakeScreenshots()
        {
            using (var form = new Form1())
            {
                form.Show();
                Application.DoEvents();

                // 1. Capture the initial launch state (Ready state)
                using (var bmp1 = new Bitmap(form.Width, form.Height))
                {
                    form.DrawToBitmap(bmp1, new Rectangle(0, 0, form.Width, form.Height));
                    bmp1.Save("screenshot_ready.png", System.Drawing.Imaging.ImageFormat.Png);
                }

                // 2. Simulate clicking Start Game and let the timer tick for a few frames
                var btnStart = form.Controls.Find("btnStart", true).FirstOrDefault() as Button;
                btnStart?.PerformClick();

                for (int i = 0; i < 8; i++)
                {
                    Application.DoEvents();
                    System.Threading.Thread.Sleep(120);
                }

                // Capture the active gameplay state with the snake in motion
                using (var bmp2 = new Bitmap(form.Width, form.Height))
                {
                    form.DrawToBitmap(bmp2, new Rectangle(0, 0, form.Width, form.Height));
                    bmp2.Save("screenshot_gameplay.png", System.Drawing.Imaging.ImageFormat.Png);
                }

                // 3. Simulate clicking Pause and capture the paused state
                var btnPause = form.Controls.Find("btnPause", true).FirstOrDefault() as Button;
                btnPause?.PerformClick();
                Application.DoEvents();

                using (var bmp3 = new Bitmap(form.Width, form.Height))
                {
                    form.DrawToBitmap(bmp3, new Rectangle(0, 0, form.Width, form.Height));
                    bmp3.Save("screenshot_paused.png", System.Drawing.Imaging.ImageFormat.Png);
                }

                form.Close();
            }
        }
    }
}

