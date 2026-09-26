param(
    [ValidateSet('debug', 'release')]
    [string]$Mode = 'debug',
    [ValidateSet('android-arm', 'android-arm64', 'android-x64')]
    [string]$TargetPlatform = 'android-arm64'
)

$ErrorActionPreference = 'Stop'
$projectDirectory = Split-Path -Parent $PSScriptRoot
$socketDirectory = Join-Path $projectDirectory 'build\java-sockets'
$previousJavaOptions = $env:JAVA_TOOL_OPTIONS

try {
    New-Item -ItemType Directory -Force -Path $socketDirectory | Out-Null
    # Windows can reject Java's AF_UNIX connection in the default temp directory.
    # This setting is scoped to this build and its child JVM processes.
    $socketOption = '-Djdk.net.unixdomain.tmpdir="' + $socketDirectory + '"'
    $env:JAVA_TOOL_OPTIONS = "$previousJavaOptions $socketOption".Trim()
    Push-Location $projectDirectory
    try {
        & flutter build apk "--$Mode" "--target-platform=$TargetPlatform"
        if ($LASTEXITCODE -ne 0) {
            throw "Android build failed with exit code $LASTEXITCODE."
        }
    } finally {
        Pop-Location
    }
} finally {
    $env:JAVA_TOOL_OPTIONS = $previousJavaOptions
}
