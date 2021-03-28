$au_root = $PSScriptRoot
$Options = [ordered]@{
    Timeout  = 10
    Threads  = 4
    Push     = $false

    RepeatOn = @(
        'Could not create SSL/TLS secure channel'
        'Could not establish trust relationship'
        'Unable to connect'
        'The remote name could not be resolved'
        'Choco pack failed with exit code 1'
        'The operation has timed out'
        'Internal Server Error'
        'An exception occurred during a WebClient request'
        'remote session failed with an unexpected state'
        'The connection was closed unexpectedly.'
    )
}

updateall -Options $Options