import argparse
import json
from automated_patcher import AutomatedPatcher

parser = argparse.ArgumentParser()
parser.add_argument("--security-only", action="store_true")
args = parser.parse_args()

patcher = AutomatedPatcher("configs/patch_config.yaml")
result = patcher.execute_patch_cycle(args.security_only)

print(json.dumps(result, indent=2))
