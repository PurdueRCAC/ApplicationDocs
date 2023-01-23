import os
import sys

import sphinx_rtd_theme

sys.path.insert(0, os.path.abspath(".."))
sys.path.append(os.path.dirname(__file__))
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "readthedocs.settings.dev")

# Load Django after sys.path and configuration setup
# isort: split
import django

django.setup()

sys.path.append(os.path.abspath("_ext"))

templates_path = ["_templates"]


html_theme = "sphinx_rtd_theme"
html_static_path = ["_static", f"{docset}/_static"]
html_css_files = ["css/custom.css", "css/sphinx_prompt_css.css"]
html_js_files = ["js/expand_tabs.js"]
html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
html_logo = "configs/rcac.jpeg"
html_theme_options = {
    "logo_only": True,
    "display_version": False,
}

hoverxref_auto_ref = True
hoverxref_domains = ["py"]
hoverxref_roles = [
    "option",
    "doc",  # Documentation pages
    "term",  # Glossary terms
]
hoverxref_role_types = {
    "mod": "modal",  # for Python Sphinx Domain
    "doc": "modal",  # for whole docs
    "class": "tooltip",  # for Python Sphinx Domain
    "ref": "tooltip",  # for hoverxref_auto_ref config
    "confval": "tooltip",  # for custom object
    "term": "tooltip",  # for glossaries
}
