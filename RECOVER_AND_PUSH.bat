@echo off
REM Recovers a corrupted git index and pushes the WCATYO updates to GitHub.
REM Run this from any cmd or by double-clicking it on Windows.

setlocal
cd /d "C:\Users\Billy\Desktop\Superdev\BBProjectDevelopment\WhatChannelAreTheYankeesOn"

echo === Clearing stale git lock & corrupted index ===
if exist ".git\index.lock" del /f /q ".git\index.lock"
if exist ".git\index" del /f /q ".git\index"

echo === Rebuilding the git index from HEAD ===
git read-tree HEAD
if errorlevel 1 (
  echo Failed to rebuild index. Aborting.
  pause
  exit /b 1
)
git update-index --refresh >nul 2>&1

echo === Current status ===
git status

echo === Staging changes ===
git add index.html

echo === Committing ===
git commit -m "Major UI refresh: YES fallback, expanded next-game card, dedupe finals, end-of-season prep, mobile fixes, light-mode polish, collapsible How-to-Watch"
if errorlevel 1 (
  echo Nothing to commit, or commit failed.
  pause
  exit /b 1
)

echo === Pushing to origin/main ===
git push origin main
if errorlevel 1 (
  echo Push failed. Check your network or credentials and run: git push origin main
  pause
  exit /b 1
)

echo.
echo === Done. Site will redeploy automatically (GitHub Pages / your host). ===
pause
