# Remote development setting
Ref : https://code.visualstudio.com/docs/remote/troubleshooting   
REF : https://code.visualstudio.com/docs/remote/ssh-tutorial   
## Remote SSH setting
	```
	{
    "security.allowedUNCHosts": [
        "samba.ipd"
    ],
    "remote.SSH.remotePlatform": {
        "hostname": "OS_Platform", (e.g. "id.host": "linux")
    },
    "remote.SSH.enableRemoteCommand": true,
    "remote.SSH.useLocalServer": true,
    "security.workspace.trust.untrustedFiles": "open"
	}
	```
# Extension
- Python environments in VS Code
  ref : https://code.visualstudio.com/docs/python/environments   
- Tensorboard inegration
	ref : https://devblogs.microsoft.com/python/python-in-visual-studio-code-february-2021-release/   
