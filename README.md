# ytOP 🎬

```
██╗░░░██╗████████╗░█████╗░██████╗░
╚██╗░██╔╝╚══██╔══╝██╔══██╗██╔══██╗
░╚████╔╝░░░░██║░░░██║░░██║██████╔╝
░░╚██╔╝░░░░░██║░░░██║░░██║██╔═══╝░
░░░██║░░░░░░██║░░░╚█████╔╝██║░░░░░
░░░╚═╝░░░░░░╚═╝░░░░╚════╝░╚═╝░░░░░
```

A premium, lightweight YouTube integration and local downloader suite. **ytOP** bridges the gap between browser convenience and raw CLI power, linking a beautiful Tampermonkey userscript overlay with a multi-threaded Python backend server powered by `yt-dlp` and `ffmpeg`.

---

## 📖 Table of Contents
*   [Key Features](#-key-features)
*   [Architecture Flow](#%EF%B8%8F-architecture-flow)
*   [Installation & Setup](#-installation--setup)
*   [File Structure](#-file-structure)
*   [Configurations](#-configurations)
*   [Frequently Asked Questions (FAQ)](#-frequently-asked-questions-faq)
*   [Disclaimer](#-disclaimer)

---

## 🌟 Key Features

### 🎮 Player Enhancement & Controls
*   **Speed Tuning**: Instant speed preset buttons (`0.5x` to `3x`) plus high-fidelity fine-tuning controls (`-` / `+` in steps of `0.25x`).
*   **Player Extras**: Native cinema mode overlay, A/B looping boundaries, and high-definition canvas screenshots.
*   **OSD (On-Screen Display)**: Sleek, non-intrusive micro-animations indicating status updates directly over the YouTube player.

### 📥 High-Speed Multi-Format Downloader
*   **Intelligent Formats Extraction**: Dynamic extraction of available media profiles directly inside watch and shorts pages.
*   **Tabbed Interface**: Clean separation for `Video + Audio` (muxed streams), `Video Only` (raw streams), and `Audio Only` (audios).
*   **Dynamic Extension Filters**: Filter profiles instantly via clickable format pills (e.g. `[MP4]`, `[WEBM]`, `[M4A]`, `[OPUS]`).

### ⚡ Live Progress & Background Execution
*   **Sleek Inline Progress Tracks**: A 3px horizontal red progress line glides along the format row during active downloads.
*   **Tooltips**: Hovering the button exposes real-time transfer speeds and ETA.
*   **Minimize to Background**: Click the minimize (`🗕`) button or press `M` to collapse the overlay into a compact, interactive floating card. Browse or watch other videos on YouTube while the download runs in the background.
*   **Self-Restoring State**: Click the minimized card to expand the modal back to its original state.
*   **Auto-Minimize on Close**: Hitting `Esc` or clicking outside the modal during active downloads auto-minimizes the window instead of destroying it.

### 🛠 System Self-Healing & Diagnostics
*   **Auto-Resolution**: The Python backend checks system PATH and automatically resolves WinGet installation directories for `ffmpeg` and `yt-dlp` to ensure a zero-config start.
*   **Availability Warnings**: Startup verification checks. If FFmpeg is missing from the environment, a `(⚠️ FFmpeg missing)` warning is highlighted in the modal footer.

---

## ⚙️ Architecture Flow

```
+---------------------------------------------------------+
|                  YouTube Watch Page                     |
|                                                         |
|  [ Tampermonkey / Violentmonkey Userscript Overlay ]    |
|   - Interactive format lists & filter chips             |
|   - Minimize button, keyboard shortcuts, progress bar  |
+---------------------------+-----------------------------+
                            |
                 (POST /download, GET /progress)
                            |
                            v
+---------------------------------------------------------+
|             Local Python Bridge Server                  |
|                 (http://127.0.0.1:9898)                 |
|                                                         |
|  [ Multi-Threaded HTTP Server & Progress Manager ]      |
|   - Executable path self-resolution (WinGet path lookup)|
|   - Real-time stdout regex stream parsing               |
+---------------------------+-----------------------------+
                            |
                   (subprocess.Popen)
                            |
                            v
+---------------------------------------------------------+
|               System Binaries (CLI)                     |
|                                                         |
|        [ yt-dlp.exe ]  =======>  [ ffmpeg.exe ]         |
|      (Stream Fetcher)          (Format Muxer/Joiner)    |
+---------------------------------------------------------+
```

---

## 🚀 Installation & Setup

### Prerequisites
*   [Python 3.x](https://www.python.org/)
*   A userscript manager extension (e.g., [Tampermonkey](https://www.tampermonkey.net/) or [Violentmonkey](https://violentmonkey.github.io/))
*   `yt-dlp` and `ffmpeg` installed. We recommend installing via WinGet:
    ```powershell
    winget install yt-dlp Gyan.FFmpeg
    ```

### Step 1: Install the Userscript
1. Open Tampermonkey in your browser and select **Create a new script**.
2. Replace the template code with the contents of **[YouTube Enhanced Suite.user.js](YouTube%20Enhanced%20Suite.user.js)**.
3. Save the script (`Ctrl + S`).

### Step 2: Run the Local Bridge Server
*   Double-click **[start-server.bat](start-server.bat)** to launch the console bridge.
*   *Alternatively*, run **[start-silent.vbs](start-silent.vbs)** to execute the server invisibly in the background.

---

## 📁 File Structure

*   `YouTube Enhanced Suite.user.js` - Tampermonkey userscript containing the client UI and player controls.
*   `yt-dlp-server.py` - Multi-threaded Python server handling background subprocess spawning and progress reports.
*   `start-server.bat` - Standard console window startup script.
*   `start-silent.vbs` - Visual Basic script to launch the server silently.
*   `stop-server.bat` - Shell script to automatically search and terminate active server processes.
*   `.gitignore` - Pre-configured git rules to ignore caches and IDE configurations.

---

## 🛠 Configurations

You can modify config parameters at the top of **[yt-dlp-server.py](yt-dlp-server.py)**:
```python
PORT           = 9898                                                   # Network Port
DOWNLOAD_DIR   = os.path.join(os.path.expanduser("~"), "Downloads", "ytOP") # Output folder
ALLOWED_ORIGIN = "https://www.youtube.com"                              # CORS restriction
```

---

## ❓ Frequently Asked Questions (FAQ)

### How do I stop the background server?
Double-click **[stop-server.bat](stop-server.bat)** in this repository folder. It searches for active python processes running `yt-dlp-server.py` and terminates them safely.

### How do I make the server start automatically when my computer boots?
1. Press `Win + R` to open the Windows Run dialog.
2. Type `shell:startup` and press **Enter** (this opens your Windows Startup folder).
3. Right-click inside the folder, select **New ➔ Shortcut**.
4. Click **Browse...**, select **[start-silent.vbs](start-silent.vbs)**, and click **Finish**.

### Why do I see a `(⚠️ FFmpeg missing)` warning?
The bridge server checked your PATH and standard folders but could not find a valid `ffmpeg.exe` installation. To resolve this:
* Make sure FFmpeg is installed (e.g. via `winget install Gyan.FFmpeg`).
* If already installed, open **[yt-dlp-server.py](yt-dlp-server.py)** and set `FFMPEG_BIN` to the absolute path of your executable (e.g. `r"C:\tools\ffmpeg\bin\ffmpeg.exe"`).

### Can I change where downloaded videos are saved?
Yes. Open **[yt-dlp-server.py](yt-dlp-server.py)** and update the `DOWNLOAD_DIR` path to any directory of your choice.

### Is it safe to run this server?
Yes. The server binds strictly to `127.0.0.1` (localhost) and only handles requests from `https://www.youtube.com`. Other devices on your local network cannot connect or access your filesystem.

---

## ⚖️ Disclaimer

This software is for personal educational purposes only. Downloading copyrighted material from YouTube without authorization violates YouTube's Terms of Service. The developers are not responsible for any misuse of this tool.
