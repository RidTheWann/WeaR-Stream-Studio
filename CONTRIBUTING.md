# WeaR Stream Studio Contribution Guidelines

WeaR Stream Studio accepts contributions via public **pull requests** against
https://github.com/RidTheWann/WeaR-Stream-Studio. Keep contributions
focused, Windows-only, and easy to review. Decisions on merging lie with
WeaR Studio maintainers.

## Scope rules (fork-specific, non-negotiable)

* **Windows-only.** Do not add macOS/Linux/BSD code, presets, or CI jobs.
  New platform branches (`if(OS_MACOS)`, `__APPLE__`, …) will be rejected.
* **User-visible strings only.** Product/UI text uses "WeaR Stream Studio".
  Do **not** rename internal library/API names (`libobs`, `obs_*`,
  `obs-studio` CMake targets) — community plugins depend on them.
* **No new third-party credentials.** Do not commit API keys, client
  secrets, certificates, or update-server keys. Features needing them
  (updater, OAuth, signing) stay disabled until WeaR Studio provisions
  its own.
* **License.** All contributions stay under GPLv2. Keep `COPYING` and
  `frontend/data/license/gplv2.txt` untouched, and keep upstream
  attribution (OBS Project) intact.

## Pull requests

* One logical change per PR/commit series; each commit must leave
  `cmake --preset windows-x64` configuring cleanly.
* Fill in the PR template. CI (build x64+arm64, clang-format, gersemi)
  must pass.
* `en-US.ini` is the source locale. Do not bulk-edit translated
  (`non-en-US`) locale files; flag them for translators instead.

## Commit messages

50/72 standard: title ≤ 50 chars, body lines ≤ 72 chars.

```
prefix: Short title in 50 characters

Why the change was made, in up to 72-char lines.
```

Use the module as prefix (`frontend`, `libobs`, `cmake`, `ci`,
`plugins/<name>`, `docs`). Example: `ci: trim matrix to Windows-only`.

## Code style

* C/C++: `clang-format` config in repo (`.clang-format`).
* CMake: `gersemi` config in repo (`.gersemirc`).
* Follow surrounding code. The project is C++17/Qt6 on Windows
  (no Objective-C/Swift remains in tree).

## Conduct

Be respectful and constructive. The upstream
[Code of Conduct](COC.rst) applies until WeaR Studio publishes its own.
