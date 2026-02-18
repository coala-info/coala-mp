---
name: curl
description: curl is a robust command-line utility designed for data transfer with URL syntax.
homepage: https://github.com/curl/curl
---

# curl

## Overview
curl is a robust command-line utility designed for data transfer with URL syntax. It serves as a Swiss Army knife for network communication, allowing agents to simulate browser behavior, interact with complex APIs, and debug connectivity issues. This skill focuses on leveraging curl's extensive flag system to handle authentication, headers, redirects, and specialized protocols like WebSocket (WS) and MQTT.

## Core CLI Patterns

### API Interaction
*   **GET Request**: `curl https://api.example.com/resource`
*   **POST with JSON**: `curl -X POST https://api.example.com/data -H "Content-Type: application/json" -d '{"key":"value"}'`
*   **Custom Headers**: Use `-H` for every header required (e.g., `-H "Authorization: Bearer <token>"`).
*   **Follow Redirects**: Always use `-L` if the server might issue a 3xx redirect.

### File Handling
*   **Download and Rename**: `curl -o filename.zip https://example.com/file.zip`
*   **Download with Remote Name**: `curl -O https://example.com/file.zip`
*   **Resume Download**: Use `-C -` to automatically resume a partially downloaded file.
*   **Upload (FTP/HTTP)**: `curl -T localfile.txt ftp://ftp.example.com/remote/path/`

### Debugging and Metadata
*   **Verbose Output**: Use `-v` to see the request and response headers (useful for debugging 4xx/5xx errors).
*   **Trace Everything**: Use `--trace-ascii <file>` for a full hex/ASCII dump of all incoming and outgoing data.
*   **Extract Specific Info**: Use `-w` (write-out) to extract metadata like status codes or timing:
    `curl -s -o /dev/null -w "%{http_code}\n" https://example.com`
*   **Silent Mode**: Use `-s` to suppress progress meters and error messages, often combined with `-S` to show only errors.

### Advanced Connectivity
*   **Retries**: Use `--retry <num>` to handle transient network failures.
*   **Timeouts**: Set `--connect-timeout <seconds>` and `--max-time <seconds>` to prevent hanging processes.
*   **Insecure Connections**: Use `-k` or `--insecure` to bypass SSL certificate validation (use only in trusted/dev environments).
*   **AWS SIGv4**: For AWS services, use `--aws-sigv4 "aws:amzn-s3:us-east-1"` for automated request signing.

## Expert Tips
*   **Protocol Support**: curl supports a wide range of protocols beyond web traffic, including MQTT, SCP, SFTP, and SMB. Ensure the URL scheme matches the intended protocol.
*   **WebSocket Testing**: For WS/WSS, curl can initiate handshakes. Use the `--connect-to` or specific WS flags if the environment supports the latest versions.
*   **Globbing**: curl supports URL globbing. For example, `curl -O "https://example.com/file[1-100].jpg"` will download 100 files in sequence.
*   **Config Files**: For complex requests with many headers, use `--config <file>` to read arguments from a text file instead of cluttering the CLI.

## Reference documentation
- [curl README](./references/curl_curl.md)
- [curl Wiki Home](./references/curl_curl_wiki.md)
- [curl Security Policy](./references/curl_curl_security.md)