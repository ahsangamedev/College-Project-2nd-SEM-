using System.Runtime.InteropServices;
using System.Text;

namespace SnakeGameFinal
{
    
     // GameMusic - Background audio player powered by the native Windows MCI API.
     
    public class GameMusic
    {
        // Import the native Windows Multimedia API function from winmm.dll
        [DllImport("winmm.dll", CharSet = CharSet.Auto)]
        private static extern int mciSendString(string command, StringBuilder returnValue, int returnLength, IntPtr winHandle);

        // Path to the MP3 audio file
        private string filePath;

        // Unique alias name used by Windows MCI to identify this audio stream
        private string playerName;

        // Tracks whether an audio device/alias is currently opened in MCI
        private bool isOpen;

        // Constructor: stores the file path and sets an alias identifier
        public GameMusic(string filePath)
        {
            this.filePath = filePath;
            this.playerName = "SnakeGameMusic";
            this.isOpen = false;
        }

        // Opens the MP3 file and starts playing it on an infinite repeat loop
        public void PlayLoop()
        {
            // Do nothing if audio file is missing
            if (File.Exists(filePath) == false)
            {
                return;
            }

            // Close any existing session before starting fresh
            Stop();

            // Open the file as an mpegvideo stream and assign it our player alias
            Send("open \"" + filePath + "\" type mpegvideo alias " + playerName);

            // Command MCI to play on repeat
            Send("play " + playerName + " repeat");
            isOpen = true;
        }

        // Temporarily freezes music playback when the game is paused
        public void Pause()
        {
            if (isOpen)
            {
                Send("pause " + playerName);
            }
        }

        // Resumes audio from the exact point it was paused
        public void Resume()
        {
            if (isOpen)
            {
                Send("resume " + playerName);
            }
        }

        // Stops playback and cleanly releases the MCI device handle
        public void Stop()
        {
            if (isOpen)
            {
                Send("stop " + playerName);
                Send("close " + playerName);
                isOpen = false;
            }
        }

        // Internal helper: dispatches an MCI command string safely inside a try-catch block
        private void Send(string command)
        {
            try
            {
                mciSendString(command, new StringBuilder(128), 128, IntPtr.Zero);
            }
            catch
            {
                // Silently handle any MCI dispatch errors so sound issues never crash the app
            }
        }
    }
}
