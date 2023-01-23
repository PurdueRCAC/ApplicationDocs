import os
import sys

import sphinx_rtd_theme

html_theme = "sphinx_rtd_theme"
html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
html_logo = "images/rcac.jpeg"
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
