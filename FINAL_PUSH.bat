@echo off
REM Reconciles divergent local & remote main, applies my edits, and pushes.
REM Self-closing (no pause). Logs to FINAL_PUSH.log.

cd /d "C:\Users\Billy\Desktop\Superdev\BBProjectDevelopment\WhatChannelAreTheYankeesOn"
set LOG=FINAL_PUSH.log
echo === FINAL_PUSH.bat run %DATE% %TIME% === > %LOG%

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

echo [4] Restoring my edited index.html from backup >> %LOG%
copy /Y index.html.NEW index.html >> %LOG% 2>&1

echo [5] Staging only index.html >> %LOG%
git add index.html >> %LOG% 2>&1

echo [6] Status before commit >> %LOG%
git status --short >> %LOG% 2>&1

echo [7] Committing >> %LOG%
git commit -m "Major UI refresh: YES fallback, expanded next-game card, dedupe finals, end-of-season prep, mobile fixes, light-mode polish, collapsible How-to-Watch" >> %LOG% 2>&1

echo [8] Pushing to origin/main >> %LOG%
git push origin main >> %LOG% 2>&1

echo [9] Final state >> %LOG%
git log --oneline -3 >> %LOG% 2>&1
echo Done. Check FINAL_PUSH.log for full output. >> %LOG%

REM Remove the .NEW backup file once we're done
if exist "index.html.NEW" del /f /q "index.html.NEW"

echo === END === >> %LOG%
exit /b 0
