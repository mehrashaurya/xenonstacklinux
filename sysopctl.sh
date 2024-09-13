#!/bin/bash

VERSION="v0.1.0"

# Function to display help menu
show_help() {
    echo "Usage: sysopctl [OPTION] COMMAND"
    echo ""
    echo "System operation management tool"
    echo ""
    echo "Commands:"
    echo "  service list           List all active services"
    echo "  service start <name>   Start a specific service"
    echo "  service stop <name>    Stop a specific service"
    echo "  system load            Display system load averages"
    echo "  disk usage             Display disk usage statistics"
    echo "  process monitor        Monitor system processes in real-time"
    echo "  logs analyze           Summarize critical log entries"
    echo "  backup <path>          Backup system files to the specified path"
    echo ""
    echo "Options:"
    echo "  --help                 Show help information"
    echo "  --version              Show the version of sysopctl"
}

# Function to display version
show_version() {
    echo "sysopctl $VERSION"
}

# Function to list running services
list_services() {
    echo "Listing all active services..."
    systemctl list-units --type=service
}

# Function to start a service
start_service() {
    echo "Starting service: $1"
    systemctl start "$1"
}

# Function to stop a service
stop_service() {
    echo "Stopping service: $1"
    systemctl stop "$1"
}

# Function to display system load averages
system_load() {
    echo "System load averages:"
    uptime
}

# Function to display disk usage
disk_usage() {
    echo "Disk usage statistics:"
    df -h
}

# Function to monitor system processes
monitor_processes() {
    echo "Monitoring system processes..."
    top
}

# Function to analyze system logs
analyze_logs() {
    echo "Analyzing recent critical logs..."
    journalctl -p 3 -xb
}

# Function to backup system files
backup_files() {
    if [ -z "$1" ]; then
        echo "Please provide a valid path for backup."
    else
        echo "Backing up files to $1..."
        rsync -av --progress / "$1"
    fi
}

# Main script logic
case "$1" in
    --help)
        show_help
        ;;
    --version)
        show_version
        ;;
    service)
        case "$2" in
            list)
                list_services
                ;;
            start)
                start_service "$3"
                ;;
            stop)
                stop_service "$3"
                ;;
            *)
                echo "Unknown service command: $2"
                show_help
                ;;
        esac
        ;;
    system)
        case "$2" in
            load)
                system_load
                ;;
            *)
                echo "Unknown system command: $2"
                show_help
                ;;
        esac
        ;;
    disk)
        case "$2" in
            usage)
                disk_usage
                ;;
            *)
                echo "Unknown disk command: $2"
                show_help
                ;;
        esac
        ;;
    process)
        case "$2" in
            monitor)
                monitor_processes
                ;;
            *)
                echo "Unknown process command: $2"
                show_help
                ;;
        esac
        ;;
    logs)
        case "$2" in
            analyze)
                analyze_logs
                ;;
            *)
                echo "Unknown logs command: $2"
                show_help
                ;;
        esac
        ;;
    backup)
        backup_files "$2"
        ;;
    *)
        echo "Unknown command: $1"
        show_help
        ;;
esac
