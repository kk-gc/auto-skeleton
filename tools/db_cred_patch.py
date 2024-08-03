# usage: <module> user name
import sys

try:
    user = sys.argv[1]
    name = sys.argv[2]
except IndexError:
    user = '_user'
    name = '_name'

r = f'''
DATABASES = {{
    "default": {{
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "{name}",
        "USER": "{user}",
    }},
}}
'''

with open('base.py.patch', 'w') as f:
    f.write(r)

print(r)
