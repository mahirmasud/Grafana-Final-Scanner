# GRAFANA FINAL SCANNER v2.0

---

## Executive Summary

**Grafana Final Scanner** is a professional-grade security assessment tool designed for comprehensive vulnerability detection in Grafana deployments. It features multi-source version fingerprinting, version-aware CVE checking, configuration analysis, and multi-format reporting.

---

## Key Features

### Core Capabilities

- **15 CVE Vulnerability Checks** - Comprehensive coverage from 2018-2025
- **Smart Version Detection** - Multi-endpoint fingerprinting with 7+ fallback strategies
- **False Positive Reduction** - Strict content validation with multi-indicator verification
- **Parallel Scanning** - Configurable threading for high-speed batch assessments
- **Authentication Support** - Bearer token and Basic auth for internal targets
- **Multi-Format Reports** - JSON, HTML, and CSV output with severity visualization

### What's New in v2.0

- **5 New CVE Checks** - Extended coverage for 2023-2024 vulnerabilities
- **Authentication Support** - Scan authenticated-only endpoints
- **Parallel Scanning** - Up to 10x faster with configurable threads
- **HTML & CSV Reports** - Professional HTML reports with severity badges
- **Improved False Positive Reduction** - Stricter validation, more test vectors
- **Rate Limiting Detection** - Automatic handling of 429 responses
- **Expanded Plugin Coverage** - 35+ plugins tested for path traversal
- **Enhanced Configuration Analysis** - Security headers, CORS, signup checks

---

## Installation

### Quick Start

```bash
pip install requests urllib3
git clone https://github.com/Zierax/Grafana-Final-Scanner.git
chmod +x scanner.py
python scanner.py -u https://grafana.example.com
```

---

## Usage

### Basic Commands

```bash
# Single target
python scanner.py -u https://grafana.example.com

# Batch scan with HTML report
python scanner.py -f targets.txt -o report

# Verbose authenticated scan
python scanner.py -u https://grafana.target.com -v --auth-token "glsa_xxx"

# Basic auth with parallel scanning
python scanner.py -u https://internal.grafana.local --auth-user admin --auth-pass password

# Self-signed SSL (internal targets)
python scanner.py -u https://grafana.internal.local --no-ssl-verify

# High-speed batch scan
python scanner.py -f targets.txt --threads 20 -o scan_results
```

### Command-Line Options

```
-u, --url              Single target URL
-f, --file             File with target URLs (one per line)
-o, --output           Save reports (JSON, HTML, CSV auto-generated)
-t, --timeout          HTTP timeout in seconds (default: 10)
--no-ssl-verify        Disable SSL certificate verification
-v, --verbose          Enable detailed logging (shows all checks)
--auth-token           Bearer token for authenticated scanning
--auth-user            Username for basic authentication
--auth-pass            Password for basic authentication
--threads              Max threads for parallel scanning (default: 5)
```

---

## Vulnerability Database

### Critical Severity

| CVE | CVSS | Description | Affected Versions |
|-----|------|-------------|-------------------|
| CVE-2025-4123 | 8.2 | Path Traversal & Open Redirect XSS | < 12.0.0+security-01 |
| CVE-2024-9264 | 9.0+ | DuckDB SQL Injection (RCE) | 11.0.0-11.2.1 |
| CVE-2024-8118 | 9.0+ | OAuth Authentication Bypass | 11.0.x-11.2.1 |
| CVE-2021-43798 | 7.5 | Directory Traversal (File Read) | 8.0.0-8.3.0 |

### High Severity

| CVE | CVSS | Description | Affected Versions |
|-----|------|-------------|-------------------|
| CVE-2023-50164 | 8.0 | Plugin Path Traversal | < 9.2.10, 9.3.x < 9.3.6 |
| CVE-2023-1410 | 8.8 | SSRF via Data Source Proxy | 8.0.0-9.2.17, 9.3.x < 9.3.5 |
| CVE-2023-2183 | 8.1 | Authentication Bypass | 8.x, 9.x before patches |
| CVE-2018-15727 | 8.1 | Auth Bypass (Cookie Forging) | 2.x-5.2.2 |
| CVE-2021-27358 | 7.5 | DoS via Snapshots API | 6.7.3-7.4.1 |

### Medium/Low Severity

| CVE | CVSS | Description | Affected Versions |
|-----|------|-------------|-------------------|
| CVE-2024-1313 | 5.5 | Information Disclosure | Multiple versions |
| CVE-2021-39226 | 6.5 | Snapshot Enumeration | 8.0.0-8.3.0 |
| CVE-2020-11110 | - | Stored XSS | < 6.7.0 |
| CVE-2021-41174 | - | AngularJS XSS | 8.0.0-8.3.0 |
| CVE-2022-32275/32276 | - | v8.4.3 Specific Issues | 8.4.3 only |

### Configuration Checks

- **Anonymous Access** - Unauthenticated viewing enabled?
- **Metrics Exposure** - Prometheus endpoint publicly accessible?
- **Plugin Analysis** - Unsigned plugins detected?
- **Security Headers** - CSP, HSTS, XFO, XSS-Protection audit
- **CORS Configuration** - Wildcard/reflective CORS detected?
- **Self-Signup** - Unauthorized user registration enabled?
- **API Configuration** - Sensitive data in API responses?

---

## Sample Output

```
╔══════════════════════════════════════════════════════════════════════╗
║ TARGET ASSESSMENT                                                    ║
║ https://grafana.example.com                                          ║
╚══════════════════════════════════════════════════════════════════════╝

ℹ [INFO] Phase 1: Connectivity Verification
  ✓ [OK] Target reachable (HTTP 200)

ℹ [INFO] Phase 2: Version Fingerprinting
  ✓ [OK] Version detected: Grafana v8.2.5

ℹ [INFO] Phase 3: Vulnerability Scanning

  🔴 [CRITICAL] CVE-2021-43798    Directory Traversal
     └─ Directory traversal CONFIRMED - File read via 'alertlist' plugin (3/8 indicators, 1245 bytes)
     └─ Test URL: https://grafana.example.com/public/plugins/alertlist/../../../../../../../../etc/passwd

  🟡 [MEDIUM] CVE-2024-1313    Information Disclosure
     └─ OAuth client ID exposed in frontend settings
     └─ Test URL: https://grafana.example.com/api/frontend/settings

ℹ [INFO] Phase 4: Security Configuration Analysis
  🟡 [MEDIUM] Anonymous access ENABLED - unauthenticated viewing possible
  ⚡ [WARN] CORS misconfiguration: Origin header reflected
  🔵 [LOW] Missing security headers (2): Content-Security-Policy, Strict-Transport-Security

╔══════════════════════════════════════════════════════════════════════╗
║ ASSESSMENT SUMMARY                                                   ║
╚══════════════════════════════════════════════════════════════════════╝

Targets Scanned:      1
Vulnerable Targets:   1
Secure Targets:       0

Vulnerability Distribution:
  🔴 CRITICAL      1
  🟠 HIGH          0
  🟡 MEDIUM        1
  🔵 LOW           1
```

---

## Technical Methodology

### Scanning Process

1. **Connectivity Verification** - TCP/HTTP handshake and SSL validation
2. **Version Fingerprinting** - Multi-source detection from 7+ endpoints
3. **Vulnerability Assessment** - Version-aware CVE testing with strict validation
4. **Configuration Analysis** - Security posture evaluation (headers, CORS, auth)
5. **Report Generation** - Multi-format output (JSON, HTML, CSV)

### False Positive Reduction

- **Version-Based Filtering**: Skip inapplicable CVE checks (~40% reduction)
- **Content Validation**: Require specific indicators, not just HTTP status (~60% reduction)
- **Multi-Vector Testing**: Test multiple variants for confirmation
- **Response Validation**: Content length, JSON structure, and indicator matching
- **Rate Limit Detection**: Prevents false negatives from rate-limited responses

### Multi-Format Reporting

```bash
# Generate all formats simultaneously
python scanner.py -u https://grafana.example.com -o scan_results

# Creates:
#   scan_results.json   - Machine-readable JSON
#   scan_results.html   - Professional HTML report
#   scan_results.csv    - Spreadsheet-compatible CSV
```

---

## Contributing

Contributions welcome! Submit pull requests with:
- New CVE detection modules
- False positive fixes
- Documentation improvements
- Test cases

---

## License

See [LICENSE](LICENSE) file for details.
