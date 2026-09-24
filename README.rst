WeaR Stream Studio <https://github.com/RidTheWann/WeaR-Stream-Studio>
=====================================================================

.. image:: https://github.com/RidTheWann/WeaR-Stream-Studio/actions/workflows/push.yaml/badge.svg?branch=master
   :alt: WeaR Stream Studio Build Status - GitHub Actions
   :target: https://github.com/RidTheWann/WeaR-Stream-Studio/actions/workflows/push.yaml?query=branch%3Amaster

What is WeaR Stream Studio?
---------------------------

WeaR Stream Studio is a **Windows-only** fork of OBS Studio for video
recording and live streaming, maintained by WeaR Studio starting at
v1.0.0. Compared to upstream it ships only the Windows build
(x64 and arm64), with macOS/Linux platform code removed from the
source tree and the product rebranded.

- Repository: https://github.com/RidTheWann/WeaR-Stream-Studio
- Bug Tracker: https://github.com/RidTheWann/WeaR-Stream-Studio/issues
- Releases: https://github.com/RidTheWann/WeaR-Stream-Studio/releases
- Contributing: see CONTRIBUTING.md in this repository

.. warning::
   v1 releases are **not code-signed** (no Authenticode certificate yet).
   Windows SmartScreen will warn on first launch — choose "More info" →
   "Run anyway" only for builds downloaded from this repository's
   official Releases page.

Building
--------

Windows builds run through GitHub Actions (see `.github/workflows/`).
Local developer builds need Visual Studio, CMake 3.28+, Qt6, and the
prebuilt obs-deps, then::

   cmake --preset windows-x64 -DOBS_VERSION_OVERRIDE=1.0.0
   cmake --build --preset windows-x64 --config RelWithDebInfo

NOTICE — Upstream Attribution
-----------------------------

This project is derived from `OBS Studio <https://obsproject.com>`_
by the OBS Project (https://github.com/obsproject/obs-studio),
which is distributed under the GNU General Public License v2.
Upstream copyright and authorship are retained where applicable:
see the accompanying COPYING file, frontend/data/license/gplv2.txt,
the AUTHORS file, and the in-app About dialog. Rebranding covers
product name, logos, and installer metadata only — internal library
and API names (libobs, obs-*) are intentionally unchanged.

License
-------

WeaR Stream Studio is distributed under the GNU General Public
License v2 (or any later version) - see the accompanying COPYING
file for more details.
