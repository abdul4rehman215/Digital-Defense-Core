#!/usr/bin/env python3
import os
import subprocess
import json
import yaml
import logging
import datetime
from typing import List, Dict

class PatchManager:
    def __init__(self, config_file="configs/patch_config.yaml"):
        self.config_file = config_file
        self.config = self.load_config()
        self.setup_logging()

    def load_config(self) -> Dict:
        if not os.path.exists(self.config_file):
            raise FileNotFoundError("Config file not found")
        with open(self.config_file) as f:
            return yaml.safe_load(f)

    def setup_logging(self):
        os.makedirs("logs", exist_ok=True)
        logging.basicConfig(
            level=self.config["logging"]["level"],
            format="%(asctime)s %(levelname)s %(message)s",
            handlers=[
                logging.FileHandler(self.config["logging"]["file"]),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)

    def get_available_updates(self) -> List[Dict]:
        subprocess.run(["sudo", "apt", "update"], stdout=subprocess.DEVNULL)
        result = subprocess.check_output(["apt", "list", "--upgradable"], text=True)
        updates = []
        for line in result.splitlines()[1:]:
            pkg = line.split("/")
            updates.append({"package": pkg[0], "raw": line})
        return updates

    def get_security_updates(self) -> List[Dict]:
        return [u for u in self.get_available_updates() if "security" in u["raw"]]

    def install_updates(self, security_only=True) -> Dict:
        timestamp = datetime.datetime.now().isoformat()
        cmd = ["sudo", "unattended-upgrade"] if security_only else ["sudo", "apt", "upgrade", "-y"]
        result = subprocess.run(cmd, capture_output=True, text=True)
        reboot_required = os.path.exists("/var/run/reboot-required")
        return {
            "timestamp": timestamp,
            "success": result.returncode == 0,
            "stdout": result.stdout,
            "stderr": result.stderr,
            "reboot_required": reboot_required
        }

    def create_system_snapshot(self) -> Dict:
        snapshot = {
            "timestamp": datetime.datetime.now().isoformat(),
            "packages": subprocess.check_output(["dpkg", "-l"], text=True),
            "os": subprocess.check_output(["lsb_release", "-a"], text=True),
            "services": subprocess.check_output(["systemctl", "list-units"], text=True)
        }
        file = f"reports/system_snapshot_{int(datetime.datetime.now().timestamp())}.json"
        with open(file, "w") as f:
            json.dump(snapshot, f, indent=2)
        return {"snapshot_file": file}
