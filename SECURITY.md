
Security Policy
Reporting a vulnerability
If you find a security issue (e.g., a script that executes untrusted input, or a template injection vector), please do not open a public issue. Instead:

Email the maintainer via the address on the GitHub profile at https://github.com/Jazz1-6.

Include a minimal reproduction and the version of the plugin.

You will receive a response within 7 days.

Scope
This plugin runs locally, produces HTML, and shells out to a headless browser for PDF rendering. The relevant attack surface is:

The PDF conversion scripts (scripts/convert-*).

Any user-supplied HTML injected into notes-template.html.

The plugin does not make network calls, does not upload content, and does not persist data beyond the output directory you specify.
