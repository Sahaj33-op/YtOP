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
