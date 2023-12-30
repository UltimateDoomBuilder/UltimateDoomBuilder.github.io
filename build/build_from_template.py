from jinja2 import Environment, FileSystemLoader, select_autoescape
import pathlib
import os
import re
import xml.etree.ElementTree as ET
import dateutil.parser

no_export = ['*.py', './requirements.txt']

env = Environment(
    loader=FileSystemLoader("."),
    autoescape=select_autoescape()
)

changelog_xml = tree = ET.parse('../files/Changelog.xml')
versions = []

for filename in os.listdir('../files'):
    match = re.match(r'^ultimatedoombuilder-(setup-|)r(\d+)-([a-z0-9]+)\.([a-z0-9]+)$', filename.lower())
    if not match:
        continue
    match = match.groups()
    rev_number = int(match[1])
    rev_platform = match[2]
    rev_type = match[3]
    existing = [x for x in versions if x['rev'] == rev_number]
    if not existing:
        changelog_entry = changelog_xml.find('.//logentry[@revision="%d"]' % rev_number)
        if changelog_entry:
            changelog_date = dateutil.parser.isoparse(changelog_entry.find('./date').text).strftime('%d %b %Y')
            changelog_text = changelog_entry.find('./msg').text.strip()
            
        existing = {
            'rev': rev_number,
            'files': [],
            'changelog': changelog_text,
            'changelog_date': changelog_date
        }
        versions.append(existing)
    else:
        existing = existing[0]
    existing['files'].append({
        'platform': rev_platform,
        'type': rev_type,
        'filename': filename
    })
    
    
versions = sorted(versions, key=lambda x: x['rev'], reverse=True)
tpl_vars = dict(versions=versions)

for dirname, _, filenames in os.walk('.'):
    for filename in filenames:
        fullname = str(pathlib.PurePosixPath(dirname)) + '/' + filename
        if True in [pathlib.PurePosixPath(fullname).match(pattern) for pattern in no_export]:
            continue
        if fullname.lower().endswith('.tpl'):
            # load it with template manager
            tpl = env.get_template(fullname)
            content = tpl.render(**tpl_vars).encode('utf-8')
            fullname = fullname[:-4]
        else:
            with open(fullname, 'rb') as f:
                content = f.read()
        target_name = '../' + '/'.join(fullname.split('/')[1:])
        with open(target_name, 'wb') as f:
            f.write(content)
