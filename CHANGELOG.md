# Changelog

All notable changes to the Grafana Final Scanner project will be documented in this file.

## [2.0.0] - 2025-02-17

### Added
- **New CVE Checks (3 additional):**
  - CVE-2023-50164 - Plugin Path Traversal (HIGH)
  - CVE-2023-1410 - SSRF via Data Source Proxy (HIGH)
  - CVE-2023-2183 - Authentication Bypass via API (HIGH)
  - CVE-2024-1313 - Information Disclosure via API (MEDIUM)
  - CVE-2024-8118 - OAuth Authentication Bypass (CRITICAL)

- **Authentication Support:**
  - `--auth-token` flag for Bearer token authentication
  - `--auth-user` / `--auth-pass` flags for Basic authentication
  - Allows scanning of authenticated-only endpoints

- **Multi-Format Reporting:**
  - HTML report generation with modern responsive design
  - CSV report export for spreadsheet analysis
  - All formats generated automatically with single `-o` flag
  - Severity color-coded badges in HTML reports

- **Parallel Scanning:**
  - `--threads` flag for configurable concurrency (default: 5)
  - Thread pool executor for parallel CVE checks
  - Faster batch scanning with concurrent target processing

- **Enhanced Configuration Analysis:**
  - HTTP security headers audit (CSP, HSTS, XFO, etc.)
  - CORS misconfiguration detection
  - User self-signup availability check
  - API key exposure detection in settings

- **Rate Limiting Detection:**
  - Automatic detection of 429 responses
  - Rate limit header monitoring
  - Smart retry with backoff

### Changed
- **Expanded version detection** from 4 to 7+ endpoints
- **Wider plugin coverage** for CVE-2021-43798 (5 → 35+ plugins)
- **More snapshot IDs** for CVE-2021-39226 (5 → 50 IDs)
- **Improved version comparison** with proper range-based checking
- **Better false positive reduction** with stricter content validation
- **Enhanced CVE-2025-4123** with 7 test vectors instead of 2
- **Renamed** `requirments.txt` → `requirements.txt` (fixed typo)

### Fixed
- **False Positive Reduction:**
  - CVE-2021-43798: Requires 3+ indicators AND content > 100 bytes
  - CVE-2018-15727: Uses actual API endpoints instead of HTML text parsing
  - CVE-2021-39226: Better JSON snapshot validation
  - All CVEs: Proper HTTP status code differentiation
  - Version-aware filtering prevents irrelevant CVE checks

- **Error Handling Improvements:**
  - Safe request wrapper with retry logic
  - Graceful handling of connection errors
  - Better timeout management

### Security
- Added rate limiting detection to prevent scanner from being blocked
- Implemented connection retry with exponential backoff
- Safe request wrapper prevents crashes on network failures

## [1.0.0] - 2025-01-15

### Added
- Initial release with 10 CVE vulnerability checks
- Multi-source version detection (4 endpoints)
- Configuration security analysis
- JSON report generation
- Color-coded severity indicators
- Support for single and batch scanning
