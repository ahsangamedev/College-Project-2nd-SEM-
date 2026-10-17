# College-Project-2nd-SEM-

# Snake Game

A classic 2D Snake game built using C# and Windows Forms. Made by Muhammad Ahsan (FA25-BSE-028).

---

## Technical Specifications

- **Visual Studio Version:** Visual Studio 2026 (v18.10) / Visual Studio 2022 (v17.10 or higher)
- **.NET Version:** .NET 10.0 (`net10.0-windows`)
- **UI Framework:** Windows Forms (WinForms)

---

## Steps to Open and Run the Project

### Option 1: Using Visual Studio
1. Launch **Visual Studio**.
2. Click **Open a project or solution**.
3. Select `SnakeGameFinal.slnx` (or `SnakeGameFinal.csproj`) from the project folder.
4. Ensure the build configuration is set to **Debug** or **Release** and platform is **Any CPU**.
5. Press **F5** (or click the green **Start** button) to build and run the application.



## Keyboard Controls

| Key | Action |
| :--- | :--- |
| **Up Arrow** / **W** | Move snake Up |
| **Down Arrow** / **S** | Move snake Down |
| **Left Arrow** / **A** | Move snake Left |
| **Right Arrow** / **D** | Move snake Right |
| **P** | Pause / Resume game |

---

## Major Features

- **Grid-Based Movement & Collision Detection:**
  - 25 x 30 grid with smooth movement.
  - Game ends if the snake hits the outer wall boundary, an obstacle, or its own body.
  - Direction reversal prevention prevents accidental immediate self-collision.

- **Three Difficulty Levels:**
  - **Easy:** Relaxed speed (180ms tick rate) with no obstacles.
  - **Medium:** Standard speed (110ms tick rate) with 4 random obstacles.
  - **Hard:** Fast speed (70ms tick rate) with 8 random obstacles.

- **Dual Food System:**
  - **Regular Food (Red circle):** Spawns regularly, grants **10 points**, and increases snake length by 1 segment.
  - **Bonus Food (Orange circle):** Has a 20% spawn chance, grants **20 points**, and increases snake length.

- **Persistent High Score:**
  - Automatically loads and updates the highest score achieved.
  - Stored persistently in a local `highscore.txt` file.

- **Audio & Visuals:**
  - Background music (`game_music.mp3`) loops during gameplay and responds to pause, resume, and game over states.
  - Custom double-buffered canvas to eliminate screen flickering.
  - Clean on-screen scoreboard showing current score, high score, and game status.

---

## External Libraries Used

- **No third-party packages or external libraries are used.**
- The project relies solely on built-in .NET and Windows components:
