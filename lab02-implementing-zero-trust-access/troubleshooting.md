# 🛠️ Troubleshooting – Lab 02

### Permission Denied
- Ensure scripts are executable: chmod +x script.sh
- Verify directory ownership and permissions

### Policy Not Applied
- Check formatting of access_policy.conf
- Ensure no trailing spaces

### Monitoring Not Detecting Changes
- Recreate baseline
- Verify absolute paths are used

### Script Cannot Find Files
- Confirm working directory
- Use $HOME paths consistently
