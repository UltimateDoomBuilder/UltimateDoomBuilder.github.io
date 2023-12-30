<!DOCTYPE html>
<html>
	<head>
		<title>Ultimate Doom Builder</title>
		<link rel="stylesheet" type="text/css" href="./static/styles.css">
		<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap">
	</head>
	<body>
		<header>
			<h1>Get Ultimate Doom Builder</h1>
		</header>
		<main role="main">
			<div class="x64-notice">
				<strong>Note:</strong> Unless you are using a severely outdated operating system or CPU, you most likely want to always download the <strong>x64</strong> (64-bit) version of Ultimate Doom Builder.
				<br><br>
				The 64-bit version has less limitations on the total size of the project that you can load and edit, while the x86 (32-bit) version of Ultimate Doom Builder only exists for compatibility with older PCs.<br><br>
				If not sure, follow these instructions to find out whether your system is 64-bit: <a href="https://support.microsoft.com/en-us/windows/which-version-of-windows-operating-system-am-i-running-628bec99-476a-2c13-5296-9dd081cdd808">Which version of Windows operating system am I running?</a>
			</div>
			<div class="primary-version">
				<a class="primary-download-link" href="./files/UltimateDoomBuilder-Setup-latest-x64.exe">
					<div class="recommended"></div>
					Download Latest
					<span class="primary-download-specifics">Installer, x64</span>
				</a>
				<a class="primary-download-link" href="./files/UltimateDoomBuilder-Setup-latest-x86.exe">
					Download Latest
					<span class="primary-download-specifics">Installer, x86</span>
				</a>
			</div>
			{% if versions %}
			<h2 class="versions-header">All recent versions</h2>
			<div class="past-versions">
				{% for version in versions %}
				<div class="past-version">
					<div class="version-header">
						<div class="version-revision">Ultimate Doom Builder R{{ version.rev }}</div>
						<div class="version-date">{{ version.changelog_date }}</div>
					</div>
					<div class="version-comment">
						{% for line in version.changelog.split('\n') %}
						{{ line }}<br>
						{% endfor %}
					</div>
					<div class="version-files">
						{% for file in version.files %}
						<a class="version-link" href="./files/{{file.filename}}">{{'Installer' if file.type == 'exe' else 'Archive'}} ({{'64-bit' if file.platform == 'x64' else '32-bit'}})</a>
						{% endfor %}
					</div>
				</div>
				{% endfor %}
			</div>
			{% endif %}
		</main>
	</body>
</html>
