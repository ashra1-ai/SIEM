<!DOCTYPE html>
<html lang="en">
<body>
    <header>
        <h1>SIEM: Azure Sentinel RDP Honeypot Monitoring Project</h1>
    </header>
    <section id="overview">
        <h2>Overview</h2>
        <p>
            This project implements a <strong>Security Information and Event Management (SIEM)</strong> system using
            <strong>Azure Sentinel</strong> to monitor and analyze failed Remote Desktop Protocol (RDP) login attempts.
            It demonstrates real-world SIEM capabilities, visualizes cyberattack patterns, and provides a hands-on
            learning experience in cybersecurity monitoring.
        </p>
    <section id="key-features">
        <h2>Key Features</h2>
        <h3>1. Honeypot Virtual Machine</h3>
        <ul>
            <li>Configured an intentionally vulnerable Azure VM to attract attackers.</li>
            <li>Disabled firewalls to simulate a highly exposed environment.</li>
        </ul>
        <h3>2. SIEM Integration with Azure Sentinel</h3>
        <ul>
            <li>Monitored and ingested Windows Event Logs for failed RDP attempts.</li>
            <li>Built custom dashboards and workbooks for advanced data visualization.</li>
        </ul>
        <h3>3. Geolocation Analysis</h3>
        <ul>
            <li>Integrated with a geolocation API to extract attacker details (e.g., country, state, latitude, longitude).</li>
            <li>Displayed global attack origins on a real-time map.</li>
        </ul>
        <h3>4. Custom Logging and Automation</h3>
        <ul>
            <li>Used PowerShell to parse event logs, query geolocation data, and structure logs for Sentinel ingestion.</li>
            <li>Automated continuous monitoring and data ingestion.</li>
        </ul>
    </section>
    <section id="architecture">
        <h2>SIEM Architecture</h2>
        <h3>1. Data Source</h3>
        <ul>
            <li>A honeypot Azure VM exposed to the internet to gather attack data.</li>
            <li>Windows Event Viewer logs (Event ID 4625 for failed logins).</li>
        </ul>
        <h3>2. Log Collection</h3>
        <ul>
            <li>Log Analytics Workspace in Azure for centralized log storage.</li>
            <li>Custom PowerShell scripts to preprocess and structure logs.</li>
        </ul>
        <h3>3. SIEM Dashboard</h3>
        <ul>
            <li>Azure Sentinel for querying, analyzing, and visualizing data.</li>
            <li>Interactive map showing geolocation of attackers.</li>
        </ul>
        <h3>4. Alerting and Analytics</h3>
        <ul>
            <li>(Optional) Set up alerts to detect high-frequency attacks.</li>
            <li>Analyze attack trends by IP, region, and time.</li>
        </ul>
    </section>
    <section id="setup">
        <h2>Setup Instructions</h2>
        <h3>Prerequisites</h3>
        <ul>
            <li>Azure Subscription with Sentinel and Log Analytics enabled.</li>
            <li>Geolocation API key from <a href="https://ipgeolocation.io/">ipgeolocation.io</a>.</li>
            <li>Basic familiarity with PowerShell and the Azure portal.</li>
        </ul>
        <h3>Steps</h3>
        <h4>1. Azure Resources Setup</h4>
        <ul>
            <li>Create a new Azure Virtual Machine.</li>
            <li>Configure a Log Analytics Workspace and link it to the VM.</li>
            <li>Enable Azure Sentinel and associate it with the workspace.</li>
        </ul>
        <h4>2. Deploy the PowerShell Script</h4>
        <ol>
            <li>Clone this repository:
                <pre><code>
git clone <repository_url>
cd <repository_folder>
                </code></pre>
            </li>
            <li>Replace <code>API_KEY</code> in <code>RDP_Honeypot_Script.ps1</code> with your geolocation API key.</li>
            <li>Run the script on the VM to log failed RDP attempts.</li>
        </ol>
        <h4>3. Visualize in Azure Sentinel</h4>
        <ul>
            <li>Import the custom workbook provided (<code>workbook_template.json</code>) into Sentinel.</li>
            <li>Use the included KQL queries (<code>queries.kql</code>) for advanced analytics.</li>
        </ul>
    </section>
    <section id="key-files">
        <h2>Key Files</h2>
        <table>
            <thead>
                <tr>
                    <th>File Name</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>RDP_Honeypot_Script.ps1</code></td>
                    <td>PowerShell script for log extraction and geolocation data retrieval.</td>
                </tr>
                <tr>
                    <td><code>workbook_template.json</code></td>
                    <td>Preconfigured workbook for Sentinel visualization.</td>
                </tr>
                <tr>
                    <td><code>queries.kql</code></td>
                    <td>KQL queries for extracting and analyzing data in Sentinel.</td>
                </tr>
                <tr>
                    <td><code>sample_logs.txt</code></td>
                    <td>Example log file format for reference.</td>
                </tr>
            </tbody>
        </table>
    </section>
    <section id="features">
        <h2>SIEM Dashboard Features</h2>
        <h3>1. Global Attack Map</h3>
        <p>Real-time visualization of failed login attempts worldwide.</p>
        <h3>2. Attack Trends</h3>
        <p>Analysis of attacker frequency by IP, country, and time.</p>
        <h3>3. Custom Queries</h3>
        <p>Flexible KQL-based queries for detailed investigation.</p>
    </section>
    <section id="learning-objectives">
        <h2>Learning Objectives</h2>
        <ul>
            <li>Understand the principles of <strong>Security Information and Event Management (SIEM)</strong>.</li>
            <li>Gain hands-on experience with <strong>Azure Sentinel</strong> and Log Analytics.</li>
            <li>Learn how to analyze cybersecurity threats using geolocation data.</li>
            <li>Develop skills in <strong>PowerShell scripting</strong> for log processing.</li>
        </ul>
    </section>
    <section id="future-enhancements">
        <h2>Future Enhancements</h2>
        <ul>
            <li>Implement alerting and triggers for high-frequency attack detection.</li>
            <li>Explore additional log sources (e.g., IIS logs, DNS queries).</li>
            <li>Integrate Machine Learning for advanced threat detection.</li>
        </ul>
    </section>
    <footer>
        <h2>Contributing</h2>
        <p>Contributions are welcome! Please fork the repository, make your changes, and submit a pull request.</p>
        <h2>License</h2>
        <p>This project is licensed under the MIT License. See the <code>LICENSE</code> file for details.</p>
        <h2>Acknowledgments</h2>
        <p>
            - <strong>Microsoft Azure Sentinel</strong> for providing robust SIEM capabilities.<br>
            - <strong>ipgeolocation.io</strong> for geolocation API services.<br>
            - Tutorials and cybersecurity communities for inspiring this project.
        </p>
    </footer>
</body>
</html>
