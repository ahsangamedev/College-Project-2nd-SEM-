$ErrorActionPreference = "Stop"

# Read screenshots as Base64
$readyB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("screenshot_ready.png"))
$gameplayB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("screenshot_gameplay.png"))
$pausedB64 = [Convert]::ToBase64String([System.IO.File]::ReadAllBytes("screenshot_paused.png"))

$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Snake Game - Academic Project Report</title>
<style>
  @page {
    size: A4 portrait;
    margin: 14mm 14mm 14mm 14mm;
  }

  *, *:before, *:after {
    box-sizing: border-box;
  }

  body {
    font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Arial, sans-serif;
    color: #0f172a;
    background-color: #ffffff;
    line-height: 1.45;
    font-size: 9.8pt;
    margin: 0;
    padding: 0;
    -webkit-print-color-adjust: exact;
    print-color-adjust: exact;
  }

  .page {
    page-break-after: always;
    page-break-inside: avoid;
    height: 268mm;
    max-height: 268mm;
    position: relative;
    overflow: hidden;
    padding: 0;
  }

  .page:last-child {
    page-break-after: avoid;
  }

  /* PAGE NUMBER / RUNNING FOOTER */
  .page-footer {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    display: flex;
    justify-content: space-between;
    font-size: 8pt;
    color: #64748b;
    border-top: 1px solid #e2e8f0;
    padding-top: 4px;
  }

  /* COVER PAGE */
  .cover-container {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    height: 100%;
    padding: 24px;
    border: 2.5px double #1e3a8a;
    background: linear-gradient(180deg, #f8fafc 0%, #eff6ff 100%);
    border-radius: 8px;
  }

  .cover-header {
    text-align: center;
    border-bottom: 2px solid #2563eb;
    padding-bottom: 18px;
  }

  .cover-univ {
    font-size: 16pt;
    font-weight: 800;
    color: #1e3a8a;
    letter-spacing: 0.8px;
    text-transform: uppercase;
    margin: 0 0 5px 0;
  }

  .cover-dept {
    font-size: 11pt;
    font-weight: 600;
    color: #475569;
    margin: 0;
    text-transform: uppercase;
  }

  .cover-badge {
    display: inline-block;
    margin-top: 10px;
    padding: 4px 16px;
    background-color: #2563eb;
    color: #ffffff;
    font-size: 9pt;
    font-weight: 600;
    border-radius: 20px;
  }

  .cover-main {
    text-align: center;
    margin: 20px 0;
  }

  .report-label {
    font-size: 10pt;
    font-weight: 700;
    color: #64748b;
    letter-spacing: 2px;
    text-transform: uppercase;
    margin-bottom: 8px;
  }

  .assignment-title {
    font-size: 23pt;
    font-weight: 800;
    color: #0f172a;
    line-height: 1.25;
    margin: 0 0 10px 0;
  }

  .assignment-subtitle {
    font-size: 11.5pt;
    color: #334155;
    font-weight: 500;
  }

  .cover-meta-box {
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-left: 5px solid #2563eb;
    border-radius: 6px;
    padding: 16px 22px;
    margin: 0 auto;
    width: 90%;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.04);
  }

  .meta-grid {
    display: grid;
    grid-template-columns: 140px 1fr;
    row-gap: 8px;
    font-size: 10.5pt;
  }

  .meta-label {
    font-weight: 700;
    color: #475569;
  }

  .meta-value {
    color: #0f172a;
    font-weight: 600;
  }

  .cover-footer {
    text-align: center;
    font-size: 9pt;
    color: #64748b;
    border-top: 1px solid #cbd5e1;
    padding-top: 12px;
  }

  /* HEADINGS */
  h1 {
    font-size: 15pt;
    color: #1e3a8a;
    border-bottom: 2px solid #2563eb;
    padding-bottom: 4px;
    margin-top: 6px;
    margin-bottom: 8px;
    font-weight: 700;
  }

  h2 {
    font-size: 11.5pt;
    color: #0f172a;
    margin-top: 10px;
    margin-bottom: 4px;
    font-weight: 600;
    border-left: 3px solid #2563eb;
    padding-left: 6px;
  }

  p {
    margin: 0 0 6px 0;
    text-align: justify;
  }

  ul, ol {
    margin: 0 0 6px 0;
    padding-left: 18px;
  }

  li {
    margin-bottom: 3px;
  }

  .feature-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 8px;
    margin-top: 6px;
  }

  .feature-box {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-left: 3px solid #3b82f6;
    border-radius: 4px;
    padding: 7px 10px;
  }

  .feature-box strong {
    color: #1e40af;
    display: block;
    font-size: 9.5pt;
    margin-bottom: 2px;
  }

  /* SCREENSHOTS */
  .screenshot-main {
    text-align: center;
    margin-bottom: 8px;
  }

  .screenshot-main img {
    width: 82%;
    max-width: 540px;
    border: 1px solid #94a3b8;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }

  .screenshot-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 10px;
    text-align: center;
  }

  .screenshot-row img {
    width: 98%;
    border: 1px solid #94a3b8;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }

  .caption {
    font-size: 8pt;
    color: #475569;
    font-weight: 600;
    margin-top: 3px;
  }

  /* OOP BLOCKS */
  .oop-card {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-left: 3.5px solid #2563eb;
    border-radius: 4px;
    padding: 7px 11px;
    margin-bottom: 7px;
  }

  .oop-header {
    font-weight: 700;
    color: #1e3a8a;
    font-size: 10pt;
    margin-bottom: 3px;
  }

  code {
    font-family: Consolas, 'Courier New', monospace;
    background: #f1f5f9;
    padding: 1px 4px;
    border-radius: 3px;
    font-size: 8.5pt;
    color: #0f172a;
    border: 1px solid #e2e8f0;
  }

  table {
    width: 100%;
    border-collapse: collapse;
    margin: 6px 0 8px 0;
    font-size: 8.5pt;
  }

  th, td {
    border: 1px solid #cbd5e1;
    padding: 4px 8px;
    text-align: left;
  }

  th {
    background-color: #f1f5f9;
    color: #1e293b;
    font-weight: 700;
  }

  .split-card {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 8px;
    margin-top: 6px;
  }

  .card-pane {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 4px;
    padding: 7px 10px;
  }

  .card-pane h3 {
    margin: 0 0 4px 0;
    font-size: 9.5pt;
    color: #1e40af;
  }

  /* UML CONTAINER */
  .uml-container {
    text-align: center;
    margin-top: 4px;
  }

  .uml-svg {
    width: 100%;
    max-height: 236mm;
    height: auto;
  }
</style>
</head>
<body>

<!-- ================= PAGE 1: TITLE PAGE ================= -->
<div class="page">
  <div class="cover-container">
    <div class="cover-header">
      <div class="cover-univ">Department of Computer Science & Software Engineering</div>
      <div class="cover-dept">Bachelor of Science in Software Engineering (BS SE)</div>
      <div class="cover-badge">Academic Project Report</div>
    </div>

    <div class="cover-main">
      <div class="report-label">Course Project Submission</div>
      <h1 class="assignment-title">Snake Game Made in Windows Forms Application</h1>
      <div class="assignment-subtitle">A Desktop 2D Game Implementing Object-Oriented Software Architecture in C# and .NET</div>
    </div>

    <div class="cover-meta-box">
      <div class="meta-grid">
        <div class="meta-label">Student Name:</div>
        <div class="meta-value">Muhammad Ahsan Nasir</div>

        <div class="meta-label">Registration No:</div>
        <div class="meta-value">FA25-BSE-028</div>

        <div class="meta-label">Course Title:</div>
        <div class="meta-value">Object Oriented Programming</div>

        <div class="meta-label">Section:</div>
        <div class="meta-value">Section B</div>

        <div class="meta-label">Academic Session:</div>
        <div class="meta-value">2025 - 2029</div>

        <div class="meta-label">Framework / Tech:</div>
        <div class="meta-value">C# | .NET 10.0 | Windows Forms (WinForms)</div>
      </div>
    </div>

    <div class="cover-footer">
      Submission Date: October 2026 &bull; Developed in Visual Studio 2026 / 2022
    </div>
  </div>
</div>

<!-- ================= PAGE 2: INTRODUCTION & FEATURES ================= -->
<div class="page">
  <h1>1. Brief Introduction to the Game</h1>
  <p>
    The <strong>Snake Game</strong> is an interactive desktop game built as a modern Windows Forms application in C# targeting .NET 10.0. The player controls a snake advancing across a 2-dimensional grid. The core objective is to steer the snake to consume food items, thereby earning score points and growing in length, while avoiding boundary walls, self-intersections, and stationary obstacles.
  </p>
  <p>
    The primary goal of this project is to apply foundational <strong>Object-Oriented Programming (OOP)</strong> principles—encapsulation, inheritance, polymorphism, and abstraction—within a graphical event-driven architecture. Game rules, state updates, graphics rendering, audio playback, and file persistence are cleanly decoupled into distinct classes.
  </p>

  <h1>2. List of Implemented Features</h1>
  <div class="feature-grid">
    <div class="feature-box">
      <strong>Grid Movement & Double-Buffered Canvas</strong>
      Smooth discrete movement across a 25&times;30 grid (20px cell size). The custom <code>GameCanvas</code> panel uses double buffering to prevent screen flickering during rapid timer ticks.
    </div>

    <div class="feature-box">
      <strong>Dual Food System & Scoring</strong>
      Two food types: Regular Food (red circle, 10 points) and Bonus Food (orange circle, 20 points, 20% random spawn probability) to introduce strategic scoring opportunities.
    </div>

    <div class="feature-box">
      <strong>Three Difficulty Presets</strong>
      Selectable difficulty dynamically alters tick interval and obstacle density:
      Easy (180ms, 0 obstacles), Medium (110ms, 4 obstacles), and Hard (70ms, 8 obstacles).
    </div>

    <div class="feature-box">
      <strong>Comprehensive Collision Detection</strong>
      Instantaneous detection of boundary wall impacts, body self-collisions, and obstacle crashes. Includes a reversal safeguard preventing accidental 180-degree self-bites.
    </div>

    <div class="feature-box">
      <strong>Persistent High Score Tracking</strong>
      Reads the highest record on startup from <code>highscore.txt</code>, compares real-time player score against the high score, and persists new records immediately upon achievement.
    </div>

    <div class="feature-box">
      <strong>Windows Multimedia Audio Engine</strong>
      Continuous background music (<code>game_music.mp3</code>) utilizing the native Windows MCI API (<code>winmm.dll</code>) with synchronized play, pause, resume, and stop controls.
    </div>

    <div class="feature-box">
      <strong>Flexible Dual-Input Controls</strong>
      Simultaneous support for <strong>Arrow Keys</strong> and <strong>W, A, S, D</strong>. Direct command-key processing ensures keystrokes are intercepted before button focus changes.
    </div>

    <div class="feature-box">
      <strong>Intuitive Game State Management</strong>
      Comprehensive UI showing real-time Score, High Score, and Status (Ready, Playing, Paused, Game Over), with Start, Restart, Pause/Resume, and Exit controls.
    </div>
  </div>

  <div class="page-footer">
    <span>Snake Game - Windows Forms Application</span>
    <span>Page 2</span>
  </div>
</div>

<!-- ================= PAGE 3: SCREENSHOTS ================= -->
<div class="page">
  <h1>3. Screenshots of the Running Application</h1>

  <div class="screenshot-main">
    <img src="data:image/png;base64,$gameplayB64" alt="Active Gameplay Screenshot">
    <div class="caption">Figure 3.1: Active Gameplay on Medium Difficulty (Snake navigating toward food, obstacles rendered, real-time score tracking)</div>
  </div>

  <div class="screenshot-row">
    <div>
      <img src="data:image/png;base64,$readyB64" alt="Launch State Screenshot">
      <div class="caption">Figure 3.2: Initial Ready State upon Launch (Difficulty selector, Start button, High Score display, Instructions)</div>
    </div>
    <div>
      <img src="data:image/png;base64,$pausedB64" alt="Paused State Screenshot">
      <div class="caption">Figure 3.3: Paused State during Match (Timer halted, Music paused, Resume button active, Status: Paused)</div>
    </div>
  </div>

  <div class="page-footer">
    <span>Snake Game - Windows Forms Application</span>
    <span>Page 3</span>
  </div>
</div>

<!-- ================= PAGE 4: UML CLASS DIAGRAM ================= -->
<div class="page">
  <h1>4. UML Class Diagram</h1>
  <p style="margin-bottom: 2px;">
    Structural UML diagram showing class hierarchy, visibilities (<code>+</code> public, <code>-</code> private, <code>#</code> protected), generalization, composition, and aggregation.
  </p>

  <div class="uml-container">
    <svg class="uml-svg" viewBox="0 0 1020 755" xmlns="http://www.w3.org/2000/svg">
      <defs>
        <!-- Generalization / Inheritance marker -->
        <marker id="inheritance" markerWidth="12" markerHeight="12" refX="12" refY="6" orient="auto">
          <polygon points="0 0, 12 6, 0 12" fill="#ffffff" stroke="#1e293b" stroke-width="1.5" />
        </marker>
        <!-- Composition marker -->
        <marker id="composition" markerWidth="14" markerHeight="14" refX="0" refY="7" orient="auto">
          <polygon points="0 7, 7 0, 14 7, 7 14" fill="#0f172a" stroke="#0f172a" stroke-width="1.5" />
        </marker>
        <!-- Aggregation marker -->
        <marker id="aggregation" markerWidth="14" markerHeight="14" refX="0" refY="7" orient="auto">
          <polygon points="0 7, 7 0, 14 7, 7 14" fill="#ffffff" stroke="#0f172a" stroke-width="1.5" />
        </marker>
        <!-- Arrowhead marker -->
        <marker id="arrow" markerWidth="9" markerHeight="9" refX="9" refY="4.5" orient="auto">
          <polyline points="0 0, 9 4.5, 0 9" fill="none" stroke="#1e293b" stroke-width="1.5" />
        </marker>
      </defs>

      <style>
        .ubox { fill: #ffffff; stroke: #334155; stroke-width: 1.5; rx: 3; }
        .uh-main { fill: #1e3a8a; }
        .uh-abs { fill: #047857; }
        .uh-enum { fill: #b45309; }
        .utitle { fill: #ffffff; font-family: 'Segoe UI', sans-serif; font-weight: bold; font-size: 12px; text-anchor: middle; }
        .usub { fill: #e2e8f0; font-family: 'Segoe UI', sans-serif; font-size: 9.5px; font-style: italic; text-anchor: middle; }
        .utext { fill: #0f172a; font-family: Consolas, monospace; font-size: 10px; }
        .udiv { stroke: #cbd5e1; stroke-width: 1; }
        .uline { stroke: #334155; stroke-width: 1.5; fill: none; }
        .udash { stroke: #334155; stroke-width: 1.5; stroke-dasharray: 4,3; fill: none; }
        .ucard { font-family: 'Segoe UI', sans-serif; font-size: 9.5px; fill: #475569; font-weight: bold; }
      </style>

      <!-- Row 1: Form1 (left), GameCanvas (mid), GameMusic (right) -->
      <g id="box-form1">
        <rect x="25" y="10" width="310" height="215" class="ubox" />
        <rect x="25" y="10" width="310" height="32" class="uh-main" />
        <text x="180" y="24" class="usub">&lt;&lt;Windows Form&gt;&gt;</text>
        <text x="180" y="37" class="utitle">Form1</text>
        <text x="32" y="55" class="utext">- gameManager : GameManager</text>
        <text x="32" y="68" class="utext">- gameMusic : GameMusic</text>
        <text x="32" y="81" class="utext">- pnlGameArea : GameCanvas</text>
        <text x="32" y="94" class="utext">- gameTimer : Timer</text>
        <text x="32" y="107" class="utext">- cmbDifficulty : ComboBox</text>
        <text x="32" y="120" class="utext">- btnStart, btnRestart, btnPause, btnExit</text>
        <line x1="25" y1="126" x2="335" y2="126" class="udiv" />
        <text x="32" y="141" class="utext">+ Form1()</text>
        <text x="32" y="154" class="utext">- StartGame() : void / PauseOrResume()</text>
        <text x="32" y="167" class="utext">- GetTimerSpeed(diff) / GetObstacleCount(diff)</text>
        <text x="32" y="180" class="utext">- UpdateLabels() : void</text>
        <text x="32" y="193" class="utext"># ProcessCmdKey(ref Message, Keys) : bool</text>
        <text x="32" y="206" class="utext">- GameTimer_Tick(sender, e) : void</text>
      </g>

      <g id="box-canvas">
        <rect x="375" y="10" width="225" height="85" class="ubox" />
        <rect x="375" y="10" width="225" height="30" class="uh-main" />
        <text x="487" y="23" class="usub">&lt;&lt;Panel Component&gt;&gt;</text>
        <text x="487" y="35" class="utitle">GameCanvas</text>
        <text x="382" y="55" class="utext">DoubleBuffered : bool = true</text>
        <line x1="375" y1="62" x2="600" y2="62" class="udiv" />
        <text x="382" y="78" class="utext">+ GameCanvas()</text>
      </g>

      <g id="box-music">
        <rect x="640" y="10" width="355" height="135" class="ubox" />
        <rect x="640" y="10" width="355" height="28" class="uh-main" />
        <text x="817" y="29" class="utitle">GameMusic</text>
        <text x="648" y="52" class="utext">- filePath : string | - playerName : string</text>
        <text x="648" y="65" class="utext">- isOpen : bool</text>
        <line x1="640" y1="72" x2="995" y2="72" class="udiv" />
        <text x="648" y="87" class="utext">+ GameMusic(filePath : string)</text>
        <text x="648" y="100" class="utext">+ PlayLoop() : void / Pause() / Resume() / Stop()</text>
        <text x="648" y="113" class="utext">- Send(command : string) : void</text>
        <text x="648" y="126" class="utext">[DllImport("winmm.dll")] mciSendString(...)</text>
      </g>

      <!-- Row 2: GameManager (left), GameBoard (mid), HighScoreStore (right) -->
      <g id="box-gamemanager">
        <rect x="25" y="260" width="335" height="235" class="ubox" />
        <rect x="25" y="260" width="335" height="28" class="uh-main" />
        <text x="192" y="279" class="utitle">GameManager</text>
        <text x="32" y="301" class="utext">- board : GameBoard | - snake : Snake</text>
        <text x="32" y="314" class="utext">- food : Food | - obstacles : List&lt;Obstacle&gt;</text>
        <text x="32" y="327" class="utext">- highScoreStore : HighScoreStore</text>
        <text x="32" y="340" class="utext">- score : int | isRunning, isPaused, isGameOver</text>
        <line x1="25" y1="346" x2="360" y2="346" class="udiv" />
        <text x="32" y="361" class="utext">+ Score, HighScore, IsPaused, IsGameOver</text>
        <text x="32" y="374" class="utext">+ GameManager(r, c, cellSize, highScorePath)</text>
        <text x="32" y="387" class="utext">+ StartNewGame(obstacleCount : int) : void</text>
        <text x="32" y="400" class="utext">+ TogglePause() : bool / ChangeDirection(dir)</text>
        <text x="32" y="413" class="utext">+ Update() : void / + Draw(graphics : Graphics)</text>
        <text x="32" y="426" class="utext">+ GetStatusText() : string</text>
        <text x="32" y="439" class="utext">- EndGame() / - CreateObstacles(count)</text>
        <text x="32" y="452" class="utext">- CreateRandomFood() : Food</text>
        <text x="32" y="465" class="utext">- RandomEmptyCell() : Position</text>
        <text x="32" y="478" class="utext">- HitsObstacle(pos : Position) : bool</text>
      </g>

      <g id="box-board">
        <rect x="405" y="260" width="260" height="130" class="ubox" />
        <rect x="405" y="260" width="260" height="28" class="uh-main" />
        <text x="535" y="279" class="utitle">GameBoard</text>
        <text x="412" y="302" class="utext">- rows, columns, cellSize : int</text>
        <text x="412" y="316" class="utext">+ Rows, Columns, CellSize : int { get; }</text>
        <line x1="405" y1="323" x2="665" y2="323" class="udiv" />
        <text x="412" y="338" class="utext">+ GameBoard(rows, cols, cellSize)</text>
        <text x="412" y="352" class="utext">+ IsInsideBoard(pos: Position) : bool</text>
        <text x="412" y="366" class="utext">+ Draw(graphics: Graphics) : void</text>
      </g>

      <g id="box-highscore">
        <rect x="705" y="260" width="290" height="115" class="ubox" />
        <rect x="705" y="260" width="290" height="28" class="uh-main" />
        <text x="850" y="279" class="utitle">HighScoreStore</text>
        <text x="712" y="302" class="utext">- filePath : string | - highScore : int</text>
        <text x="712" y="316" class="utext">+ HighScore : int { get; }</text>
        <line x1="705" y1="323" x2="995" y2="323" class="udiv" />
        <text x="712" y="338" class="utext">+ HighScoreStore(filePath: string)</text>
        <text x="712" y="352" class="utext">+ Load() : void / SaveIfBetter(score: int)</text>
      </g>

      <!-- Row 3: Snake (left), Position & Direction (mid), GameObject / Food / Obstacle (right) -->
      <g id="box-snake">
        <rect x="25" y="535" width="315" height="205" class="ubox" />
        <rect x="25" y="535" width="315" height="28" class="uh-main" />
        <text x="182" y="554" class="utitle">Snake</text>
        <text x="32" y="576" class="utext">- body : List&lt;Position&gt;</text>
        <text x="32" y="589" class="utext">- currentDirection, nextDirection : Direction</text>
        <text x="32" y="602" class="utext">+ Head : Position { get; }</text>
        <line x1="25" y1="609" x2="340" y2="609" class="udiv" />
        <text x="32" y="624" class="utext">+ Snake(startPosition: Position)</text>
        <text x="32" y="637" class="utext">+ SetDirection(newDirection: Direction) : void</text>
        <text x="32" y="650" class="utext">+ Move(grow: bool) : void</text>
        <text x="32" y="663" class="utext">+ WouldHitBody(nextHead: Position) : bool</text>
        <text x="32" y="676" class="utext">+ Occupies(position: Position) : bool</text>
        <text x="32" y="689" class="utext">+ GetNextHeadPosition() : Position</text>
        <text x="32" y="702" class="utext">+ Draw(graphics: Graphics, cellSize: int) : void</text>
      </g>

      <g id="box-position">
        <rect x="375" y="535" width="185" height="100" class="ubox" />
        <rect x="375" y="535" width="185" height="28" class="uh-main" />
        <text x="467" y="554" class="utitle">Position</text>
        <text x="382" y="576" class="utext">- x : int | - y : int</text>
        <text x="382" y="590" class="utext">+ X, Y : int { get; }</text>
        <line x1="375" y1="597" x2="560" y2="597" class="udiv" />
        <text x="382" y="612" class="utext">+ Position(x: int, y: int)</text>
        <text x="382" y="626" class="utext">+ IsSameAs(other: Position) : bool</text>
      </g>

      <g id="box-direction">
        <rect x="375" y="650" width="150" height="90" class="ubox" />
        <rect x="375" y="650" width="150" height="28" class="uh-enum" />
        <text x="450" y="663" class="usub">&lt;&lt;enumeration&gt;&gt;</text>
        <text x="450" y="674" class="utitle">Direction</text>
        <text x="385" y="694" class="utext">Up, Down</text>
        <text x="385" y="710" class="utext">Left, Right</text>
      </g>

      <g id="box-gameobject">
        <rect x="610" y="440" width="275" height="100" class="ubox" />
        <rect x="610" y="440" width="275" height="30" class="uh-abs" />
        <text x="747" y="454" class="usub">&lt;&lt;abstract&gt;&gt;</text>
        <text x="747" y="466" class="utitle">GameObject</text>
        <text x="618" y="487" class="utext">- position : Position | + Position : Position</text>
        <line x1="610" y1="494" x2="885" y2="494" class="udiv" />
        <text x="618" y="510" class="utext">+ GameObject(position: Position)</text>
        <text x="618" y="525" class="utext">+ {abstract} Draw(g: Graphics, size: int) : void</text>
      </g>

      <g id="box-obstacle">
        <rect x="585" y="580" width="205" height="75" class="ubox" />
        <rect x="585" y="580" width="205" height="26" class="uh-main" />
        <text x="687" y="598" class="utitle">Obstacle</text>
        <text x="592" y="620" class="utext">+ Obstacle(pos: Position)</text>
        <line x1="585" y1="626" x2="790" y2="626" class="udiv" />
        <text x="592" y="642" class="utext">+ override Draw(g, size) : void</text>
      </g>

      <g id="box-food">
        <rect x="815" y="570" width="190" height="90" class="ubox" />
        <rect x="815" y="570" width="190" height="26" class="uh-main" />
        <text x="910" y="588" class="utitle">Food</text>
        <text x="822" y="608" class="utext">- points : int | + Points : int</text>
        <line x1="815" y1="615" x2="1005" y2="615" class="udiv" />
        <text x="822" y="630" class="utext">+ Food(pos, points = 10)</text>
        <text x="822" y="645" class="utext">+ override Draw(g, size) : void</text>
      </g>

      <g id="box-bonusfood">
        <rect x="815" y="675" width="190" height="65" class="ubox" />
        <rect x="815" y="675" width="190" height="24" class="uh-main" />
        <text x="910" y="692" class="utitle">BonusFood</text>
        <text x="822" y="713" class="utext">+ BonusFood(position)</text>
        <text x="822" y="728" class="utext">+ override Draw(g, size) : void</text>
      </g>

      <!-- CONNECTING LINES & RELATIONSHIPS -->
      <!-- Form1 *-- GameManager (Composition) -->
      <path d="M 180 225 L 180 260" class="uline" marker-start="url(#composition)" />
      <text x="185" y="238" class="ucard">1</text>
      <text x="185" y="254" class="ucard">1</text>

      <!-- Form1 *-- GameCanvas (Composition) -->
      <path d="M 335 55 L 375 55" class="uline" marker-start="url(#composition)" />

      <!-- Form1 *-- GameMusic (Composition) -->
      <path d="M 335 95 L 640 95" class="uline" marker-start="url(#composition)" />

      <!-- GameManager *-- Snake (Composition) -->
      <path d="M 180 495 L 180 535" class="uline" marker-start="url(#composition)" />
      <text x="185" y="508" class="ucard">1</text>
      <text x="185" y="528" class="ucard">1</text>

      <!-- GameManager *-- GameBoard (Composition) -->
      <path d="M 360 325 L 405 325" class="uline" marker-start="url(#composition)" />

      <!-- GameManager *-- HighScoreStore (Composition) -->
      <path d="M 360 290 L 405 290 L 405 245 L 850 245 L 850 260" class="uline" marker-start="url(#composition)" />

      <!-- GameManager o-- GameObject (Aggregation) -->
      <path d="M 360 460 L 610 460" class="uline" marker-start="url(#aggregation)" />
      <text x="375" y="453" class="ucard">1</text>
      <text x="590" y="453" class="ucard">1..*</text>

      <!-- Inheritance: Obstacle -> GameObject -->
      <path d="M 687 580 L 687 540" class="uline" marker-end="url(#inheritance)" />

      <!-- Inheritance: Food -> GameObject -->
      <path d="M 910 570 L 910 550 L 780 550 L 780 540" class="uline" marker-end="url(#inheritance)" />

      <!-- Inheritance: BonusFood -> Food -->
      <path d="M 910 675 L 910 660" class="uline" marker-end="url(#inheritance)" />

      <!-- Snake o-- Position (Aggregation) -->
      <path d="M 340 585 L 375 585" class="uline" marker-start="url(#aggregation)" />
      <text x="358" y="580" class="ucard">1..*</text>

      <!-- GameObject o-- Position (Aggregation) -->
      <path d="M 610 490 L 520 490 L 520 535" class="uline" marker-start="url(#aggregation)" />

      <!-- Snake ..> Direction (Dependency) -->
      <path d="M 340 685 L 375 685" class="udash" marker-end="url(#arrow)" />
    </svg>
  </div>

  <div class="page-footer">
    <span>Snake Game - Windows Forms Application</span>
    <span>Page 4</span>
  </div>
</div>

<!-- ================= PAGE 5: EXPLANATION OF OOP CONCEPTS ================= -->
<div class="page">
  <h1>5. Explanation of OOP Concepts Used</h1>
  <p style="margin-bottom: 8px;">
    The game design explicitly incorporates the four core pillars of Object-Oriented Programming (OOP) to achieve loose coupling, modularity, and high maintainability without procedural sprawl:
  </p>

  <div class="oop-card">
    <div class="oop-header">1. Encapsulation (Information Hiding & State Protection)</div>
    <p>
      Internal variables are declared <code>private</code> across all classes to preserve object integrity and eliminate unauthorized state manipulation:
    </p>
    <ul>
      <li>In <code>Snake</code>, the body coordinates (<code>List&lt;Position&gt; body</code>) and directional state (<code>currentDirection</code>, <code>nextDirection</code>) are hidden. Movement is restricted to the <code>Move()</code> method.</li>
      <li><strong>Input Integrity:</strong> <code>Snake.SetDirection()</code> strictly validates direction changes to prevent immediate 180-degree self-collisions (e.g., attempting to turn Down while moving Up is rejected).</li>
      <li><strong>Read-Only Properties:</strong> Public properties with getters only (e.g., <code>GameManager.Score</code>, <code>GameBoard.Rows</code>, <code>Position.X</code>, <code>Food.Points</code>) expose state safely without allowing external alteration.</li>
    </ul>
  </div>

  <div class="oop-card">
    <div class="oop-header">2. Inheritance (Hierarchical Code Reuse)</div>
    <p>
      Inheritance structures domain objects into intuitive parent-child relationships, eliminating redundant declarations:
    </p>
    <ul>
      <li><code>GameObject</code> serves as the abstract base class for all board items, providing shared spatial properties (<code>Position</code>) and requiring a standardized drawing contract.</li>
      <li><code>Food : GameObject</code> inherits position logic and introduces food point value (default 10 points).</li>
      <li><code>BonusFood : Food</code> extends <code>Food</code>, passing <code>base(position, 20)</code> to specialize score value and visual rendering while reusing all positioning mechanics.</li>
      <li><code>Obstacle : GameObject</code> inherits spatial tracking while implementing distinct obstacle graphics.</li>
      <li><strong>Framework Inheritance:</strong> <code>Form1</code> inherits from <code>Form</code> and <code>GameCanvas</code> inherits from <code>Panel</code>, enabling custom paint overrides and double-buffered window rendering.</li>
    </ul>
  </div>

  <div class="oop-card">
    <div class="oop-header">3. Polymorphism (Dynamic Dispatch & Uniform Interface)</div>
    <p>
      Polymorphism allows derived classes to override base contracts to deliver specialized behaviors through a common interface:
    </p>
    <ul>
      <li><strong>Method Overriding:</strong> <code>GameObject</code> defines the abstract method <code>Draw(Graphics g, int size)</code>. Derived classes <code>Food</code> (red circle), <code>BonusFood</code> (orange circle), and <code>Obstacle</code> (gray square) override <code>Draw()</code> with customized rendering algorithms.</li>
      <li><strong>Uniform Execution:</strong> <code>GameManager</code> handles food polymorphically: whether it holds an instance of <code>Food</code> or <code>BonusFood</code>, invoking <code>food.Draw(graphics, cellSize)</code> executes the appropriate specialized rendering routine without type casting.</li>
      <li><strong>System Event Interception:</strong> <code>Form1</code> overrides <code>ProcessCmdKey</code> to intercept arrow key inputs before default Windows Form focus navigation can switch button states.</li>
    </ul>
  </div>

  <div class="oop-card">
    <div class="oop-header">4. Abstraction (Separation of Concerns & Interface Simplicity)</div>
    <p>
      Abstraction separates high-level domain operations from intricate low-level mechanics:
    </p>
    <ul>
      <li><code>GameObject</code> provides an abstract representation of spatial grid entities without concerning itself with whether an object is edible, hazardous, or stationary.</li>
      <li><code>GameManager</code> encapsulates game mechanics, collision math, and timer ticks. The presentation layer (<code>Form1</code>) interacts only through clean operations: <code>StartNewGame()</code>, <code>Update()</code>, and <code>ChangeDirection()</code>.</li>
      <li><code>GameMusic</code> abstracts Win32 Multimedia API calls (<code>mciSendString</code> via P/Invoke) behind simple methods: <code>PlayLoop()</code>, <code>Pause()</code>, <code>Resume()</code>, and <code>Stop()</code>.</li>
    </ul>
  </div>

  <div class="page-footer">
    <span>Snake Game - Windows Forms Application</span>
    <span>Page 5</span>
  </div>
</div>

<!-- ================= PAGE 6: RUN INSTRUCTIONS & LIMITATIONS ================= -->
<div class="page">
  <h1>6. Instructions to Run the Project</h1>
  
  <div style="font-size: 9pt; margin-bottom: 6px;">
    <strong>Prerequisites:</strong> Visual Studio 2022 (v17.10+) or Visual Studio 2026 &bull; .NET 10.0 SDK &bull; Windows 10/11 OS (x64)
  </div>

  <div class="split-card" style="margin-top: 0; margin-bottom: 6px;">
    <div class="card-pane">
      <h3>Method A: Running via Visual Studio</h3>
      <ol style="margin: 0; padding-left: 16px; font-size: 8.5pt;">
        <li>Open <code>SnakeGameFinal.slnx</code> in Visual Studio.</li>
        <li>Set solution configuration to <strong>Debug</strong> and platform to <strong>Any CPU</strong>.</li>
        <li>Press <kbd>F5</kbd> (or click <strong>Start</strong>) to build and run.</li>
      </ol>
    </div>
    <div class="card-pane">
      <h3>Method B: Running via Command Line (CLI)</h3>
      <ol style="margin: 0; padding-left: 16px; font-size: 8.5pt;">
        <li>Open terminal in the project directory:
          <br><code>cd c:\Users\vboxuser\Desktop\SnakeGameFinal</code></li>
        <li>Execute: <code>dotnet run</code></li>
      </ol>
    </div>
  </div>

  <h2>Controls & Input Mapping</h2>
  <table>
    <thead>
      <tr>
        <th style="width: 32%;">Input Key / Control</th>
        <th>Function / In-Game Action</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><strong>Up Arrow</strong> / <strong>W</strong></td>
        <td>Direct snake upward (reversal prevented if currently moving downward)</td>
      </tr>
      <tr>
        <td><strong>Down Arrow</strong> / <strong>S</strong></td>
        <td>Direct snake downward (reversal prevented if currently moving upward)</td>
      </tr>
      <tr>
        <td><strong>Left Arrow</strong> / <strong>A</strong></td>
        <td>Direct snake leftward (reversal prevented if currently moving rightward)</td>
      </tr>
      <tr>
        <td><strong>Right Arrow</strong> / <strong>D</strong></td>
        <td>Direct snake rightward (reversal prevented if currently moving leftward)</td>
      </tr>
      <tr>
        <td><strong>P</strong> Key</td>
        <td>Pause / Resume the ongoing game session</td>
      </tr>
      <tr>
        <td><strong>Difficulty Dropdown</strong></td>
        <td>Select Easy (180ms, 0 obstacles), Medium (110ms, 4 obstacles), or Hard (70ms, 8 obstacles)</td>
      </tr>
      <tr>
        <td><strong>Start / Restart Buttons</strong></td>
        <td>Start a fresh match with randomized board layout and selected difficulty</td>
      </tr>
      <tr>
        <td><strong>Exit Button</strong></td>
        <td>Stop music playback and cleanly exit the application</td>
      </tr>
    </tbody>
  </table>

  <h1>7. Limitations & Future Improvements</h1>
  
  <div class="split-card">
    <div class="card-pane" style="border-left: 3px solid #e11d48;">
      <h3>Current Project Limitations</h3>
      <ul style="font-size: 8.5pt; margin: 0; padding-left: 16px;">
        <li><strong>Platform Dependency:</strong> Relies on Windows Forms and native Win32 MCI (<code>winmm.dll</code>), limiting portability to Microsoft Windows.</li>
        <li><strong>Fixed Grid Resolution:</strong> Board size is fixed at 25&times;30 cells (20px each); responsive window resizing is disabled.</li>
        <li><strong>Local Persistence:</strong> High score is saved in plain text (<code>highscore.txt</code>) without online leaderboard integration or encryption.</li>
      </ul>
    </div>
    <div class="card-pane" style="border-left: 3px solid #16a34a;">
      <h3>Proposed Future Improvements</h3>
      <ul style="font-size: 8.5pt; margin: 0; padding-left: 16px;">
        <li><strong>Dynamic Power-Ups:</strong> Introduce collectibles like speed boosts, slow-motion timers, and obstacle-destroyer pills.</li>
        <li><strong>Custom Themes & Audio:</strong> Add selectable retro arcade, neon matrix, and dark-mode themes with customizable snake skins.</li>
        <li><strong>Multiplayer & AI Opponents:</strong> Implement local split-screen 2-player mode and an autonomous AI snake driven by A* pathfinding.</li>
        <li><strong>Cross-Platform Port:</strong> Migrate the UI layer to .NET MAUI or Avalonia UI to support macOS, Linux, and mobile platforms.</li>
      </ul>
    </div>
  </div>

  <div class="page-footer">
    <span>Snake Game - Windows Forms Application</span>
    <span>Page 6</span>
  </div>
</div>

</body>
</html>
"@

Set-Content -Path "report.html" -Value $htmlContent -Encoding UTF8
Write-Host "report.html updated successfully"

# Render HTML to PDF using Edge headless with no-pdf-header-footer
$edgePath = "C:\Program Files (x86)\Microsoft\EdgeCore\155.0.4283.45\msedge.exe"
$tempDataDir = Join-Path $env:TEMP "edge-pdf-report"
$htmlFullPath = "file:///" + (Resolve-Path "report.html").Path.Replace("\", "/")
$pdfOutputPath = "C:\Users\vboxuser\Desktop\SnakeGameFinal\Snake_Game_Project_Report.pdf"

Write-Host "Rendering PDF from $htmlFullPath to $pdfOutputPath..."

& $edgePath --headless=new --disable-gpu --no-sandbox --no-pdf-header-footer --user-data-dir="$tempDataDir" --print-to-pdf="$pdfOutputPath" "$htmlFullPath"

Start-Sleep -Seconds 3

if (Test-Path $pdfOutputPath) {
    $pdfItem = Get-Item $pdfOutputPath
    Write-Host "SUCCESS: PDF generated! Size: $($pdfItem.Length) bytes ($([math]::Round($pdfItem.Length/1KB, 2)) KB)"
} else {
    Write-Error "Failed to generate PDF."
}
