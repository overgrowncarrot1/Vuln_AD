# Vuln_AD

This is a vulerable Domain Controller. I have taken ideas from other scripts and added to it.

**Run Build_DC.ps1 first, way for restart then run vuln_ad.ps1**

The following groups are on the machine:

Account Operators
Sever Operators
Backup Operators

The script does everything for you and the following is setup on the machine:

SeBackupPrivilege
SeRestorePrivilege
SeDebugPrivilege
SeTcpPrivilege
SeTakeOwnershipPrivilege
SeSecurityPrivilege
SeShutdownPrivilege
SeRemoteShutdownPrivilege
SeSystemEnvironmentPrivilege
SeLoadDriverPrivilege
SeCreateSymbolicLinkPrivilege
SeImpersonatePrivilege

Along with Delegation Privileges if you want to setup another machine (stay tuned for more).

The following DACL abuses are on the machine:

GenericAll
GenericWrite
WriteOwner
Owns
WriteDACL
ForceChangePassword
AddUserToGroup
TargetedKerberos
GetChanges

There is also an unquoted Service Path and and executable path for takeover

