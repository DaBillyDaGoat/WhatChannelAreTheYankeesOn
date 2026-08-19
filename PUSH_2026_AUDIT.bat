@echo off
REM Pushes the 2026 broadcast-audit fixes to origin/main (GitHub Pages).
REM Self-closing. Logs to PUSH_2026_AUDIT.log.

cd /d "C:\Users\Billy\Desktop\Superdev\BBProjectDevelopment\WhatChannelAreTheYankeesOn"
set LOG=PUSH_2026_AUDIT.log
echo === PUSH_2026_AUDIT.bat run %DATE% %TIME% === > %LOG%

echo [1] Clearing stale locks >> %LOG%
if exist ".git\index.lock" del /f /q ".git\index.lock" >> %LOG% 2>&1
if exist ".git\objects\maintenance.lock" del /f /q ".git\objects\maintenance.lock" >> %LOG% 2>&1
if exist ".git\HEAD.lock" del /f /q ".git\HEAD.lock" >> %LOG% 2>&1
if exist ".git\refs\heads\main.lock" del /f /q ".git\refs\heads\main.lock" >> %LOG% 2>&1
for /f %%f in ('dir /b /s ".git\objects\tmp_obj_*" 2^>nul') do del /f /q "%%f" >> %LOG% 2>&1

echo [2] Fetching latest origin/main >> %LOG%
git fetch origin main >> %LOG% 2>&1

echo [3] Resetting local main to origin/main while keeping working tree >> %LOG%
git reset --mixed origin/main >> %LOG% 2>&1

echo [4] Staging only index.html >> %LOG%
git add index.html >> %LOG% 2>&1

echo [5] Status before commit >> %LOG%
git status --short >> %LOG% 2>&1

echo [6] Committing >> %LOG%
git commit -m "2026 broadcast audit: NBC/Peacock SNB, Netflix events, Apple TV paid; fix NBCSN filter bug + add WEB/Streaming types; Rate Field, Athletics/Sutter Health Park; JSON-LD SportsEvent schema, noscript fallback, og:image absolute URL, robots meta; widen offseason fallback; misc polish" >> %LOG% 2>&1

echo [7] Pushing to origin/main >> %LOG%
git push origin main >> %LOG% 2>&1

echo [8] Final state >> %LOG%
git log --oneline -3 >> %LOG% 2>&1
echo Done. Check PUSH_2026_AUDIT.log for full output. >> %LOG%

echo === END === >> %LOG%
exit /b 0
