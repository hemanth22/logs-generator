#!/bin/bash

# Configuration
SCRIPT_NAME="dummy_log_generator.py"
PID_FILE="log_generator.pid"
LOG_FILE="dummy.log"

# Start function
start() {
    if [ -f "$PID_FILE" ] && kill -0 "$(cat $PID_FILE)" 2>/dev/null; then
        echo "Log generator already running (PID $(cat $PID_FILE))"
        exit 1
    fi

    echo "Starting log generator..."
    nohup python3 "$SCRIPT_NAME" > /dev/null 2>&1 &
    echo $! > "$PID_FILE"
    echo "Started with PID $(cat $PID_FILE)"
}

# Stop function
stop() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        if kill -0 "$PID" 2>/dev/null; then
            echo "Stopping log generator (PID $PID)..."
            kill "$PID"
            rm -f "$PID_FILE"
            echo "Stopped."
        else
            echo "Process not running, cleaning up PID file."
            rm -f "$PID_FILE"
        fi
    else
        echo "Log generator not running."
    fi
}

# Status function
status() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")
        if kill -0 "$PID" 2>/dev/null; then
            echo "Log generator is running (PID $PID)"
        else
            echo "PID file found, but process not running."
        fi
    else
        echo "Log generator is not running."
    fi
}

# Help function
usage() {
    echo "Usage: $0 {start|stop|status}"
}

# Main logic
case "$1" in
    start) start ;;
    stop) stop ;;
    status) status ;;
    *) usage ;;
esac
