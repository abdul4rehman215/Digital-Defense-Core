from vulnerability_scanner import VulnerabilityScanner

scanner = VulnerabilityScanner()
results = scanner.run_comprehensive_scan()
file = scanner.save_scan_results(results)

print("Scan saved to:", file)
