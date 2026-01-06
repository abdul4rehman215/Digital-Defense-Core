import psutil
import os
from patch_manager import PatchManager
from vulnerability_scanner import VulnerabilityScanner

class AutomatedPatcher:
    def __init__(self, config_file):
        self.pm = PatchManager(config_file)
        self.vs = VulnerabilityScanner()

    def pre_patch_checks(self):
        return {
            "disk_ok": psutil.disk_usage("/").free > 1 * 1024**3,
            "memory_ok": psutil.virtual_memory().percent < 90,
            "snapshot": self.pm.create_system_snapshot()
        }

    def post_patch_verification(self):
        return {
            "reboot_required": os.path.exists("/var/run/reboot-required")
        }

    def execute_patch_cycle(self, security_only=True):
        return {
            "pre": self.pre_patch_checks(),
            "scan": self.vs.run_comprehensive_scan(),
            "install": self.pm.install_updates(security_only),
            "post": self.post_patch_verification()
        }
