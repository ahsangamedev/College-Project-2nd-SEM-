namespace SnakeGameFinal
{
    /*
     * GameCanvas - Custom drawing surface derived from Windows Forms Panel.
     *
     * Why this is needed:
     * - Standard Windows Forms panels flicker noticeably when redrawn at high frame rates.
     * - By creating a custom subclass of Panel and enabling 'DoubleBuffered = true',
     *   Windows draws the entire frame into a back-buffer in memory first before flipping
     *   it onto the screen. This guarantees completely tear-free, smooth 60fps rendering!
     */
    public class GameCanvas : Panel
    {
        public GameCanvas()
        {
            // Enable double buffering to eliminate screen flicker during animation ticks
            this.DoubleBuffered = true;

            // Set clean default background color
            this.BackColor = Color.White;
        }
    }
}
