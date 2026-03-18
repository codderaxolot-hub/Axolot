#!/data/data/com.termux/files/usr/bin/bash

WATCH_FILE="/storage/emulated/0/Download/Telegram/MySRC/New Menu storm/app/src/main/jniLibs/arm64-v8a/libAxolot.so"
REPO_DIR="$HOME/Axolot"
TARGET_FILE="$REPO_DIR/libAxolot.so"

LAST_HASH=""

while true
do
    if [ -f "$WATCH_FILE" ]; then
        CURRENT_HASH=$(md5sum "$WATCH_FILE" | awk '{print $1}')

        if [ "$CURRENT_HASH" != "$LAST_HASH" ]; then
            echo "Файл изменился!"

            cp "$WATCH_FILE" "$TARGET_FILE"
            cd "$REPO_DIR"

            git add .
            git commit -m "Auto update: $(date)"
            git push

            LAST_HASH="$CURRENT_HASH"
        fi
    else
        echo "Файл не найден..."
    fi

    sleep 5
done
