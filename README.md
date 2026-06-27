# ytOP 🎬

A modern, lightweight YouTube enhancement and local downloader suite. It combines a premium browser userscript interface with a robust, zero-config local Python bridge server utilizing `yt-dlp`.

---

## 🌟 Key Features

### 1. Advanced Video Controls
*   **Speed Selection & Fine-Tuning**: Preset speed buttons (`0.5x` to `3x`) plus precise increment adjustments (`-` / `+`).
*   **Player Add-ons**: Cinema overlay mode, continuous A/B looping, and high-definition player screenshots.
*   **On-Screen Display (OSD)**: Visual indicators for active actions (like speed shifts) overlapping the player.

### 2. Multi-Format Downloader
*   **Integrated Formats Panel**: Instant extraction of available media profiles directly from YouTube watch/shorts pages.
*   **Category Tabs**: Separate lists for `Video + Audio` (muxed), `Video Only`, and `Audio Only`.
*   **Dynamic Extension Filters**: Filter available format options instantly using file extensions (like `MP4` or `WebM`).

### 3. Sleek Visual Feedback
*   **Inline Progress Bars**: Slim horizontal progress tracks rendering along format rows during downloads.
*   **Detailed Tooltips**: Real-time download statistics (percentage, network speed, and ETA).
*   **Minimize to Background**: Collapse active download dialogs into a interactive floating progress widget on the corner of the browser page, letting you continue watching or browsing YouTube.
*   **Auto-Minimize on Close**: Hitting `Esc` or clicking the backdrop during active downloads automatically minimizes the modal instead of destroying the visual progress indicators.

### 4. Smart System Diagnostics
*   **Self-Healing Paths**: Automatically searches and resolves local `ffmpeg` and `yt-dlp` executables in standard Windows package directories (like WinGet folders) to prevent PATH configuration issues.
*   **FFmpeg Validation**: Startup verification on the bridge server. If FFmpeg is missing from the host environment, the user is warned directly inside the Tampermonkey modal.

---

## 🚀 Installation & Setup

### Prerequisites
*   [Python 3](https://www.python.org/)
*   [Tampermonkey](https://www.tampermonkey.net/) (or Violentmonkey) browser extension.
*   `yt-dlp` and `ffmpeg` installed. Recommended to install via WinGet:
    ```powershell
    winget install yt-dlp Gyan.FFmpeg
    ```

### Step 1: Install the Userscript
1. Open Tampermonkey in your browser and create a new script.
2. Paste the contents of **[YouTube Enhanced Suite.user.js](YouTube%20Enhanced%20Suite.user.js)**.
3. Save the script.

### Step 2: Start the Bridge Server
*   Run the **[start-server.bat](start-server.bat)** batch script to launch the local Python server (`http://127.0.0.1:9898`).
*   Downloads are saved to your system's `Downloads/ytOP` folder by default.

---

## 🛠 Configurations

You can modify the following variables inside **[yt-dlp-server.py](yt-dlp-server.py)**:
*   `PORT`: Port for the local bridge server (default: `9898`).
*   `DOWNLOAD_DIR`: Absolute path to save downloads (default: `%USERPROFILE%/Downloads/ytOP`).
*   `FFMPEG_BIN` / `YTDLP_BIN`: Customize absolute paths to the binaries if not using standard system installation paths.

---

## ❓ Frequently Asked Questions (FAQ)

### How do I start the server silently in the background?
Instead of double-clicking `start-server.bat` (which leaves a Command Prompt window open), double-click **[start-silent.vbs](start-silent.vbs)**. This runs the Python server completely in the background.

### How do I stop the background server?
To stop the silent background server, double-click **[stop-server.bat](stop-server.bat)** in this repository folder. It will find the running Python server process and terminate it immediately.

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
