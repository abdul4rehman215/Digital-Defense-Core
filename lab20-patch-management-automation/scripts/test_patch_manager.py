from patch_manager import PatchManager

pm = PatchManager()
updates = pm.get_available_updates()
print(f"Available updates: {len(updates)}")

snapshot = pm.create_system_snapshot()
print("Snapshot created:", snapshot["snapshot_file"])
