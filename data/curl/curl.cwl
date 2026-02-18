cwlVersion: v1.2
class: CommandLineTool
baseCommand: curl
label: curl
doc: "Transfer data from or to a server\n\nTool homepage: https://github.com/curl/curl"
inputs:
  - id: url
    type: string
    doc: URL to interact with
    inputBinding:
      position: 1
  - id: data
    type:
      - 'null'
      - string
    doc: HTTP POST data
    inputBinding:
      position: 102
      prefix: --data
  - id: fail
    type:
      - 'null'
      - boolean
    doc: Fail silently (no output at all) on HTTP errors
    inputBinding:
      position: 102
      prefix: --fail
  - id: include
    type:
      - 'null'
      - boolean
    doc: Include protocol response headers in the output
    inputBinding:
      position: 102
      prefix: --include
  - id: remote_name
    type:
      - 'null'
      - boolean
    doc: Write output to a file named as the remote file
    inputBinding:
      position: 102
      prefix: --remote-name
  - id: silent
    type:
      - 'null'
      - boolean
    doc: Silent mode
    inputBinding:
      position: 102
      prefix: --silent
  - id: upload_file
    type:
      - 'null'
      - File
    doc: Transfer local FILE to destination
    inputBinding:
      position: 102
      prefix: --upload-file
  - id: user
    type:
      - 'null'
      - string
    doc: Server user and password
    inputBinding:
      position: 102
      prefix: --user
  - id: user_agent
    type:
      - 'null'
      - string
    doc: Send User-Agent <name> to server
    inputBinding:
      position: 102
      prefix: --user-agent
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Make the operation more talkative
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write to file instead of stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/curl:7.80.0
