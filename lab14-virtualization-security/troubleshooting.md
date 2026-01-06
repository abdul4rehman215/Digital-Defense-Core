# 🛠️ Troubleshooting – Lab 14: Virtualization Security

## KVM modules not loading
Check CPU virtualization:
egrep -c '(vmx|svm)' /proc/cpuinfo

## Permission denied with virsh
Ensure user is in libvirt group and re-login.

## Snapshot failures
Ensure VM disk uses qcow2 and sufficient disk space.

## Backup failures
Verify VM shutdown state and available storage.
