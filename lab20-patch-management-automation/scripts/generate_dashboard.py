import os

html = "<h1>Patch Reports</h1><ul>"
for f in os.listdir("reports"):
    html += f"<li>{f}</li>"
html += "</ul>"

with open("reports/dashboard.html", "w") as d:
    d.write(html)

print("Dashboard generated: reports/dashboard.html")
